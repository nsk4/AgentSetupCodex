---
description: Review changes — quick triage, full review of uncommitted changes, or full whole-branch pre-PR review. Agents inspect the tree themselves at the scope you name. Read-only; applies nothing (fix coordination belongs to /prompts:qwe-feature or to me).
argument-hint: [short | branch [base]]
---

Review my code — strictly read-only: apply nothing, edit nothing. This prompt only reports; applying fixes is coordinated by `/prompts:qwe-feature` (after its review step) or by me directly. Pick the mode from $ARGUMENTS:

**`short`** — quick, cheap triage, NO agents: check `git status --short` (including untracked files) and the uncommitted diff yourself for high-value issues only — obvious bugs, out-of-scope churn, missing docstrings on new public interfaces. Output the same numbered table as the critic (`# | Sev | Location | Problem | Fix`), worst first, or one line if clean. Say this is NOT the pre-PR gate; point me at `/prompts:qwe-review branch`.

**`branch [base]`** — full pre-PR review of the whole branch. Base = the one I named, else the repo's default branch (`git rev-parse --abbrev-ref origin/HEAD`, fallback `main`/`master`). Run the full gate with scope **`branch <base>`**.

**no mode (default)** — full review of current uncommitted work. Run the full gate with scope **`uncommitted`**.

**Full gate** — pass the SCOPE (not a pasted diff) to each agent; they run the git inspection themselves, including `git status --short` and untracked files:
1. **qwe-critic** agent — design/minimalism/duplication/placement/churn, at the named scope.
2. **qwe-reviewer** agent — the full nine-dimension gate at the named scope, ending in a READY / NOT READY verdict.
Show both outputs exactly as returned, under clear headings, verdict at the top.
