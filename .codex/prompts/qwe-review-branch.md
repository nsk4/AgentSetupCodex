---
description: Full pre-PR review of the ENTIRE branch — every change since it left its base (committed + uncommitted) — with qwe-critic and qwe-reviewer. Lists findings; applies nothing.
argument-hint: [base branch]
---

Review everything this branch introduces relative to its base — the final look before I open a PR.

Determine the base: use $ARGUMENTS if I gave one, else the repo's default branch (`main`/`master`, preferring the `origin/` ref if present). The scope is the merge-base up to the current working tree, so it covers BOTH committed changes on the branch AND uncommitted (staged + unstaged) changes:
- `git diff $(git merge-base HEAD <base>)` — branch commits + working tree vs base.

Then, telling each subagent to review THAT full branch diff (not just uncommitted changes):
1. **qwe-critic** subagent — design and minimalism trims.
2. **qwe-reviewer** subagent — the full pre-PR gate: completeness, correctness, security, regressions, consistency, documentation (incl. docstrings), and tests, ending in a READY / NOT READY verdict.

Show both lists exactly as returned, under clear headings, with the reviewer's verdict at the top. Do NOT apply anything and do NOT edit any files — this is review only.
