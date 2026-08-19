---
name: qwe-review
description: Review changes — quick triage, full review of uncommitted changes, or full whole-branch pre-PR review. Agents inspect the tree themselves at the scope you name. Read-only; applies nothing (fix coordination belongs to $qwe-feature or to me).
---

# QWE Review

Review my code — strictly read-only: apply nothing, edit nothing. This skill only reports; applying fixes is coordinated by `$qwe-feature` (after its review step) or by me directly. Pick the mode from the invoking request:

**`short`** — quick, cheap triage, NO subagents: check `git status --short` (including untracked files) and the uncommitted diff yourself for high-value issues only — obvious bugs, out-of-scope churn, missing docstrings on new public interfaces. Output the same numbered table as the critic (`# | Sev | Location | Problem | Fix`), worst first, or one line if clean. Say this is NOT the pre-PR gate; point me at `$qwe-review branch`.

**`branch [base]`** — full pre-PR review of the whole branch. Base = the one I named, else the repo's default branch (`git rev-parse --abbrev-ref origin/HEAD`, fallback `main`/`master`). Run the full gate with scope **`branch <base>`**.

**no mode (default)** — full review of current uncommitted work. Run the full gate with scope **`uncommitted`**.

**Full gate — run it INLINE when this session didn't produce the changes** (a review-only session gains nothing from spawning — it would just re-pay diff discovery twice). **If THIS session wrote or materially shaped the code under review, SPAWN qwe-critic and qwe-reviewer instead** — fresh eyes beat saved discovery; a context that justified the changes can't impartially judge them. When inline: Inspect the scope ONCE yourself — `git status --short` first (untracked files included), then the diff — and apply BOTH lenses to that one read:
1. **Critic lens** — read `<agents>/qwe-critic.toml` and apply its checklist and output format exactly.
2. **Reviewer lens** — read `<agents>/qwe-reviewer.toml` and apply its nine dimensions and report template exactly.
Present both reports under clear headings, verdict at the top. Then append the findings (no verdict line — triage is mine) to `<logs>/qwe-findings.md` per `<templates>/findings-log.md`; create the folder/file only when there are findings.
