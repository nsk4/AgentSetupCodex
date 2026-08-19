#!/usr/bin/env bash
# Machine-level SessionStart hook. Product workspace (qwe-layout.md with `repos:`) -> sweeps the
# declared repos; plain repo workspace -> single-repo sweep. Injects doc/skill pointers (with
# trigger descriptions) + live git state. Best-effort; never hard-fails the session.
# PERF: written in pure bash on purpose — process spawns cost ~100ms each under Git Bash on
# Windows; this version spawns ~6 processes total (find x2-per-repo-tree, git x1 per repo, date).
set +e
_t0=${EPOCHREALTIME:-$SECONDS}
skill_desc_limit=180

layout="./qwe-layout.md"; [ -f "$layout" ] || layout="./.codex/qwe-layout.md"
repos_line=""
if [ -f "$layout" ]; then
  while IFS= read -r line; do
    case "$line" in repos:*) repos_line=${line#repos:}; break;; esac
  done < "$layout"
fi

REPOS=(); LABELS=()
if [ -n "$repos_line" ]; then
  agents_note="each declared code repo's root AGENTS.md is BINDING -- read it before work in that repo"
  IFS=',' read -ra _pairs <<< "$repos_line"
  for pair in "${_pairs[@]}"; do
    pair="${pair#"${pair%%[![:space:]]*}"}"; pair="${pair%"${pair##*[![:space:]]}"}"
    [ -n "$pair" ] || continue
    LABELS+=("${pair%%=*}"); REPOS+=("${pair#*=}")
  done
elif [ -d .git ] || [ -f .git ]; then
  agents_note="whatever the task, the root AGENTS.md is binding -- confirm it before work"
  REPOS=("."); LABELS=("${PWD##*/}")
fi
[ ${#REPOS[@]} -eq 0 ] && exit 0

nested=""; skills=""; git_state=""; missing=""
for i in "${!REPOS[@]}"; do
  r=${REPOS[$i]}; label=${LABELS[$i]}
  [ -d "$r" ] || { missing="$missing$r "; continue; }

  # nested AGENTS.md — one find per repo; prune heavy dirs, bound depth
  _n=""
  while IFS= read -r f; do
    [ "$f" = "$r/AGENTS.md" ] || [ "$f" = "./AGENTS.md" ] && continue
    _n="${_n:+$_n, }$f"
  done < <(find "$r" -maxdepth 4 \( -name node_modules -o -name .git -o -name .venv -o -name venv \
      -o -name dist -o -name build -o -name __pycache__ -o -name '.*_cache' -o -name .tox \
      -o -name coverage -o -name .next -o -name target -o -name pgdata \) -prune \
    -o -name AGENTS.md -print 2>/dev/null | sort)
  [ -n "$_n" ] && nested="${nested}[$label] $_n "

  # skills — glob the dirs, read each SKILL.md's description in PURE bash (zero spawns per skill)
  _s=""
  for d in "$r"/.github/skills/*/; do
    [ -d "$d" ] || continue
    name=${d%/}; name=${name##*/}
    desc=""
    if [ -f "$d/SKILL.md" ]; then
      while IFS= read -r line; do
        case "$line" in
          description:*)
            desc=${line#description:}
            desc="${desc#"${desc%%[![:space:]]*}"}"
            desc=${desc#\"}; desc=${desc%\"}; desc=${desc#\'}; desc=${desc%\'}
            desc=${desc//$'\r'/}
            break;;
        esac
      done < "$d/SKILL.md"
    fi
    if [ ${#desc} -gt "$skill_desc_limit" ]; then
      desc=${desc:0:$skill_desc_limit}; desc="${desc% *}..."
    fi
    if [ -n "$desc" ]; then _s="${_s}${name} -- ${desc}; "; else _s="${_s}${name}; "; fi
  done
  [ -n "$_s" ] && skills="${skills}[$label] $_s"

  # git — ONE spawn per repo; parse porcelain v2 in pure bash
  gb=""; gu=""; gab=""; gd=0; _ok=0
  while IFS= read -r line; do
    _ok=1
    case "$line" in
      "# branch.head "*)     gb=${line#\# branch.head };;
      "# branch.upstream "*) gu=${line#\# branch.upstream };;
      "# branch.ab "*)       gab=${line#\# branch.ab };;
      "#"*) ;;
      *) [ -n "$line" ] && gd=$((gd+1));;
    esac
  done < <(git -C "$r" status --porcelain=v2 --branch 2>/dev/null)
  if [ $_ok -eq 1 ]; then
    gt=""; [ -n "$gu" ] && gt=", upstream ${gu} (${gab:-+0 -0} = ahead/behind)"
    git_state="${git_state}[$label] branch=${gb:-unknown}${gt}, ${gd} dirty file(s). "
  fi
done
[ -n "$missing" ] && git_state="${git_state}LAYOUT MISMATCH: declared repo path(s) not found: ${missing}. "

now=$(date '+%A %Y-%m-%d %H:%M:%S %Z (UTC%z)' 2>/dev/null)

_t1=${EPOCHREALTIME:-$SECONDS}
_a=${_t0%.*}; _b=${_t1%.*}; _am=${_t0#*.}; _bm=${_t1#*.}
_dur="$((_b-_a)).$(( (10#${_bm:0:1}0 - 10#${_am:0:1}0 + 100) % 100 / 10 ))"

ctx="Machine local time at session start: ${now:-unavailable}. \
Code-repo documentation contract: \
(1) ${agents_note}. \
(2) Before editing files under a directory, read the nearest AGENTS.md up the tree: ${nested:-none}. \
(3) When a task matches a skill, read its SKILL.md first: ${skills:-none} \
(4) GIT STATE, live and AUTHORITATIVE (the harness's built-in gitStatus goes stale -- trust this): ${git_state:-unavailable} \
(session-start hook runtime: ${_dur}s)"

ctx=${ctx//\\/\\\\}; ctx=${ctx//\"/\\\"}
printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$ctx"
