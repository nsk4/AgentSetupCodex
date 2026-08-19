---
name: qwe-worktree
description: Manage feature worktrees — `add` creates one for a branch (reusing local/remote intelligently), `collapse` folds a feature's worktree(s) back into the main checkout(s), verifying removal. Never pushes; collapse's transient commit is the only scoped git-write exception.
---

# QWE Worktree

Mode = first word of the invoking request: `add` or `collapse`. Missing/unknown → print usage and stop.

## add <branch-name> [base-branch]

Create an isolated worktree for a branch.

**Remote** — don't assume `origin`: check `git remote`. One remote → use it. Several → prefer `origin`, else ask. None → skip remote steps. **Always fetch first** when a remote exists.

**Pre-checks:** branch already checked out in another worktree (`git worktree list`) → if that worktree is correct for this work and clean, REUSE it (report; create nothing); otherwise STOP and report. Target directory exists → reuse only if it's already this repo's worktree on this branch; anything else → STOP.

**Resolve `<branch-name>`, stating which case you hit:**
1. **Neither local nor remote** → `git worktree add --no-track -b <branch> <path> <base>`. Base = the one I named, else the default branch (`git rev-parse --abbrev-ref origin/HEAD`, fallback `main`/`master`); missing base → STOP. Then set tracking to its OWN name (never the base): `git config branch.<branch>.remote <remote>` + `git config branch.<branch>.merge refs/heads/<branch>`. Do NOT push. → "created new branch off <base>, tracking <remote>/<branch> (not yet pushed)".
2. **Only remote** → `git worktree add --track -b <branch> <path> <remote>/<branch>`. → "created local branch from remote".
3. **Only local** → `git worktree add <path> <branch>`, WARN: no remote counterpart.
4. **Both** → compare (`git rev-list --left-right --count <remote>/<branch>...<branch>`): local clean AND not ahead → sync to remote (fast-forward if behind; if it can't be done safely, STOP), then add the worktree. Unpushed commits, divergence, or uncommitted changes anywhere → STOP and report; never clobber.

**Worktree directory** = `<repo-folder-name>-<branch with / → ->` (e.g. `repo-a-feature-user-auth`), ALWAYS a sibling of THAT repo's root — `./product`, `./code-repo`, `./code-repo-worktree` side by side. A repo that already uses a specific worktrees location wins. If the new folder sits outside the current workspace roots and access prompts appear, say so and continue (I'll add it to the workspace).

**Report:** Worktree folder (name + path) · Active branch · Source (which case) · Remote branch (exists? `in sync` / `ahead N / behind M` / "none yet").

## collapse <feature-identifier | worktree-path> [repo-label]

Fold worktree(s) back into their main checkout(s): branch (and any uncommitted work, as staged changes) lands in the main repo; the worktree is REMOVED. May use ONE transient commit per worktree purely to transport uncommitted work — it must be undone so no commit I didn't ask for survives.

**Targets:** a feature identifier (e.g. `xyz`) → EVERY worktree matching by directory name (`<repo>-…-xyz`) across ALL reachable repos (`git worktree list` in each) — the default; do NOT stop at the current/top repo. A single path, or identifier + repo label → only that one.

For EACH target, independently (one repo's problem never blocks the others):
1. Resolve its branch `B` and its repo's MAIN checkout.
2. **Preconditions (before any git write; on failure SKIP this repo and report):** main checkout reachable AND clean (`git status --short` empty).
3. **Collapse:** worktree CLEAN → `git worktree remove <path>`, then `git checkout B` in main (no commit, no reset). Worktree DIRTY → in the worktree `git add -A` + `git commit -m "collapse-wip"` → `git worktree remove <path>` → `git checkout B` in main → `git reset --soft HEAD~1` (work ends up STAGED).
4. **VERIFY removal — mandatory, per repo:** `git worktree list` no longer shows it AND the directory is gone from disk. Directory still exists → say so explicitly and why (never `--force`, never delete files manually); a collapse that leaves the folder behind is NOT done silently.

**Never:** delete a branch, force-remove, hard-reset, push, or commit the staged result.

**Report — per repo:** branch now on main · staged (dirty case) or already committed (clean case) · worktree removed ✓ (verified) — plus any repo skipped and why.
