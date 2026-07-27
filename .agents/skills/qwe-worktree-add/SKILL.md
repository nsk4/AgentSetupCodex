---
name: qwe-worktree-add
description: Create a git worktree for a branch — reuse local/remote intelligently, else create off the base. Always fetches first; handles existing worktrees, occupied branches, and non-origin remotes; stops on conflicts. Never commits or pushes.
---

# QWE Worktree Add

Create an isolated worktree for a branch. From the invoking request take the branch name and an optional base branch.

**Remote** — don't assume `origin`: check `git remote`. One remote → use it (all `origin/...` below means that remote). Several → prefer `origin` if present, otherwise ask. None → skip remote steps and say so. **Always fetch first** when a remote exists, so you know the remote state.

**Pre-checks (before resolving):**
- Branch already checked out in another worktree (`git worktree list`)? If that worktree is the correct one for this work and clean → REUSE it (report that; create nothing). Otherwise STOP and report where it's checked out — a branch can't live in two worktrees, and you never clobber.
- Target directory already exists? If it's already a worktree of this repo on this branch → reuse it. Anything else → STOP and report; never overwrite.

**Resolve `<branch-name>`, stating plainly which case you hit:**
1. **Neither local nor remote exists** → `git worktree add --no-track -b <branch-name> <path> <base>`. Base = the one I named, else the default branch (`git rev-parse --abbrev-ref origin/HEAD`, fallback `main`/`master`); missing base → STOP and ask. Then set tracking to its OWN name (never the base): `git config branch.<branch-name>.remote <remote>` and `git config branch.<branch-name>.merge refs/heads/<branch-name>`. Do NOT push — the remote branch appears on my first push. → "created new branch off <base>, tracking <remote>/<branch-name> (not yet pushed)".
2. **Only remote exists** → `git worktree add --track -b <branch-name> <path> <remote>/<branch-name>`. → "created local branch from remote".
3. **Only local exists** → `git worktree add <path> <branch-name>`, WARN clearly: no remote counterpart. → "used existing local branch — WARNING: no remote".
4. **Both exist** → compare (`git rev-list --left-right --count <remote>/<branch-name>...<branch-name>`):
   - Local clean AND not ahead → sync to remote (fast-forward if behind; if the branch is checked out in another worktree, fast-forward only from THAT checkout — if you can't safely, STOP and report), then add the worktree. → "both existed, in sync — using remote state".
   - Unpushed commits, divergence, or uncommitted changes in any checkout → STOP and report exactly what; do NOT clobber, reset, or guess.

**Worktree directory** = `<repo-folder-name>-<branch with / replaced by ->` (e.g. `<repo>-feature-user-auth`), sibling of THAT repo's root — unless the repo already uses a specific worktrees location, then match it.

**Report — label each field:** **Worktree folder** (name + path) · **Active branch** · **Source** (which case, incl. "reused existing worktree") · **Remote branch** (`<remote>/<branch-name>` exists? sync status `in sync` / `ahead N / behind M`, or "none yet").

Do NOT commit, stage, push, or publish the branch. No destructive git operations. I push it myself.
