---
name: qwe-feature
description: End-to-end feature — detect or create worktree(s), one canonical plan, per-increment implementation, full review with owned fix loop until READY FOR PR. Follows sibling workflow skills so logic stays centralized. Leaves everything uncommitted. Never commits or pushes.
---

# QWE Feature

Take a feature from a plan to reviewed, PR-ready (but UNCOMMITTED) worktree(s). Don't duplicate logic — **read each sibling workflow skill named below and follow it**, so later edits flow through here.

**Checklist:** maintain the session to-do list across the run — resolve repos → worktree(s) → plan → increments (qwe-implement's flow adds these) → review/fix loop → report. Update after every step.

Interpret the invoking request: leading repo labels (the ones my setup rule defines) → scope; a feature IDENTIFIER if I give one (e.g. `xyz`) — used to FIND existing worktrees whose directory matches it (`<repo>-…-xyz`, e.g. `frontend-xyz`), and, if none exist, as the stem for new ones; a plan path or a description; remaining text = extra guidance. If I give no identifier or branch, derive it from the plan/feature (kebab-case).

**Repo scope** — from the keywords if given, else the plan's `## Repos`. If neither names extra repos → current repo only. NEVER infer a second repo just because it's reachable. Multi-repo needs explicitly scoped access — a workspace containing only those repos, or the session's add-a-directory mechanism (e.g. `--add-dir`); if a named repo isn't reachable or identifiable (match each label to a reachable root via my setup's mapping, or by name/manifest — don't guess), STOP and ask. Order work by dependency: the repo the others depend on first.

Then:

1. **Worktree(s) — detect or create.** Using the feature identifier, for each in-scope repo:
   - **Match existing worktrees by DIRECTORY name** via `git worktree list` — `xyz` matches `frontend-xyz`, `backend-xyz`, etc. For a match, use that worktree's ACTUAL branch and path (do NOT assume a `feature/<id>` branch). **Exists → REUSE it** and CONTINUE the work in progress there — a dirty worktree is expected; don't recreate it, and NEVER fall back to the repo's main checkout.
   - **No match → create** by reading and following `../qwe-worktree-add/SKILL.md` (branch = the one I named, else `feature/<identifier>`; it must be clean before implementing).
   Record each repo's resolved worktree path. **Once a feature worktree exists (or was just created) for a repo, ALL that repo's work happens in that worktree path — never in its main checkout, even if the plan just says `frontend`/`backend`.**
   **Repo instructions:** if the session wasn't opened in/above a repo, that repo's own instructions were NOT auto-loaded. Before implementing in it, READ them from the worktree checkout — its applicable root/nested `AGENTS.md` files and relevant `.agents/skills/` and `.codex/` guidance — honor them, and pass the relevant conventions to every implementer/critic working in that repo.

2. **One canonical plan** — exactly ONE plan file drives the whole feature, also for multi-repo (repo-tagged increments, one owning repo each, dependencies explicit). NEVER create per-repo copies or slices. If a plan for this feature already exists in the plans folder, USE it (don't recreate). Otherwise, if I gave a description, read and follow `../qwe-plan/SKILL.md` (new-plan case) to create it. Pass each worker the increment + context it needs from this one file.

3. **Clarification gate — normally a no-op.** All questions belong to the planner, so expect `## Needs your input: None`; if so, proceed without asking me ANYTHING. Only if unanswered items remain (I didn't answer them at plan time) ask them ONCE, in one numbered batch with recommended defaults, fold the answers in, and set the section to `None`. From here on the run is non-interactive: anything that surfaces mid-run takes the safest default (recorded under `## Assumptions`) or a `⛔ blocked` tag — surfaced in the FINAL report, never as a mid-run stop. Stop mid-run only for a true showstopper (continuing would destroy work or contradict an explicit instruction).

4. **Implement** — read and follow `../qwe-implement/SKILL.md` against the canonical plan (its per-increment implementer/critic loop, checklist, and plan updates). Each increment is implemented IN ITS OWNING REPO'S WORKTREE — the path recorded in step 1, never the repo's main checkout. Pass every qwe-implementer (and critic) the specific worktree path to work in; do NOT touch the main working directories.
   **Every in-scope repo is implemented in THIS run — never do one repo and hand me a prompt for the other; handoff prompts are only for repos outside this run's scope.** Work dependency-first, and when an increment was `⛔ blocked` on the other side's output and that output has now landed in this run, UNBLOCK it and implement it now — only increments still blocked on something external (my input, a real outside dependency) remain tagged.

5. **Review + fix loop (you own the fixes):**
   a. Read and follow `../qwe-review/SKILL.md` in FULL mode with scope `branch <base>` (covers committed history if the branch has any, plus all working-tree and untracked changes).
   b. Evaluate the findings: accept what holds up, reject with reason.
   c. Accepted fixes → hand as an explicit fix list to a fresh **qwe-implementer** (its own context).
   d. Re-run the review. Stop when it returns `READY FOR PR`, or after **2 full review/fix passes** — then report what's still open.

6. **Git safety** — everything stays UNCOMMITTED: no staging, commits, push, or destructive git operations (`git reset`/`restore`/`checkout --`/`clean`/`stash`/`revert`). I review and commit myself.

**Report — terse, per repo:** worktree folder + branch, implement STATUS, final review verdict, anything blocked/open (incl. cross-side blockers). Point me at each worktree to review and commit.
