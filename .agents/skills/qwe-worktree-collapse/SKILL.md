---
name: qwe-worktree-collapse
description: "Reverse of `$qwe-worktree-add` — collapse a feature's worktree(s) back into their main checkout(s): bring each branch (and any uncommitted work, as staged changes) into its main repo, then remove the worktree. Collapses ALL of the feature's worktrees by default; one only if you restrict it. Leaves work staged, not committed."
---

# QWE Worktree Collapse

Collapse the worktree(s) named in the invoking request back into their main checkout(s). Deliberate, scoped exception to the no-commit / no-reset rule: it may use ONE transient commit PER worktree purely to transport uncommitted work, and must undo it so no commit I didn't ask for survives.

**Which worktrees to collapse:**
- A **feature identifier** (e.g. `xyz`) → find EVERY worktree matching it by directory name (`<repo>-…-xyz`, e.g. `frontend-xyz`, `backend-xyz`) across ALL reachable repos in this session (`git worktree list` in each), and collapse EACH — this is the default. Do NOT stop at the current/top repo.
- A **single worktree path**, or an identifier plus a repo label (e.g. `xyz backend`) → collapse only that one.
- If a repo that should have a matching worktree isn't reachable, say so; collapse the ones you can and report the rest.

For EACH target worktree, independently (one repo's problem must not block the others):

1. Resolve its branch `B` and its repo's MAIN checkout.
2. **Preconditions — check BEFORE any git write; if either fails, SKIP this repo and report (never clobber, never make a commit we can't land):** the main checkout is reachable, and CLEAN (`git status --short` empty).
3. **Collapse — from the worktree's state:**
   - **Worktree CLEAN** → `git worktree remove <path>` (no `--force`; skip + report if it refuses), then `git checkout B` in the main checkout. No temp commit, no reset.
   - **Worktree has uncommitted changes** → in the worktree `git add -A` then `git commit -m "collapse-wip"` (transient, includes untracked) → `git worktree remove <path>` (no `--force`) → `git checkout B` in the main checkout → `git reset --soft HEAD~1` (undo ONLY the transport commit, keeping changes staged).

**Never:** delete a branch, force-remove, hard-reset, push, or commit the staged result — that's mine.

**Report — per repo:** branch now on its main checkout, whether staged (uncommitted case) or already committed (clean case), worktree removed; plus any repo skipped and why (not reachable / main dirty / removal refused).
