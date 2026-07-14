---
description: Create a git worktree for a branch — reuse the local branch if it exists, else a remote branch, else create it off the base (default branch, or one you name). Project-agnostic. Never commits, stages, or pushes.
argument-hint: <branch-name> [base-branch]
---

Create an isolated worktree for a branch. From $ARGUMENTS take the branch name and an optional base branch. Fetch first if a remote exists, then resolve in THIS order and state plainly which case you hit:

1. **Local branch exists** → check it out: `git worktree add <path> <branch-name>` (whether or not a remote copy also exists). → say: "checked out existing local branch".
2. **Only a remote branch exists** (`origin/<branch-name>`, no local) → `git worktree add --track -b <branch-name> <path> origin/<branch-name>`. → say: "created local branch from existing remote origin/<branch-name>".
3. **Neither exists** → create it off the base: `git worktree add <path> -b <branch-name> <base>`. Base = the branch I named, else the repo's default branch (`git rev-parse --abbrev-ref origin/HEAD`, fallback `main` / `master`); if that base doesn't exist, STOP and tell me. → say: "created new branch off <base>".

**Worktree directory** = the branch name with `/` replaced by `-` (e.g. `feature/user-auth` -> `feature-user-auth`), placed as a sibling of the repo root (`../<dir>`) unless the repo already uses a specific worktrees location — then match it.

**Report — label each field clearly:**
- **Worktree folder:** the new directory name (and its path).
- **Active branch:** the branch checked out in that worktree.
- **Source:** exactly one of — `existing local branch checked out` / `local branch created from remote origin/<branch-name>` / `new branch created off <base>`.
- **Remote branch:** whether `origin/<branch-name>` exists. If it does, also report sync status vs the local branch — `in sync`, or `ahead N / behind M` (`git rev-list --left-right --count origin/<branch-name>...<branch-name>`). If it doesn't, state there is none yet.

Do NOT commit, stage, or push, and do NOT publish the branch — this only creates the local worktree. I'll run planning/implementation and push it myself.
