---
description: Manage a plan with the qwe-planner subagent — create a new one, extend/change an existing one, or check its status. Archives a finished plan to tmp/plans/done. Never writes code.
argument-hint: <feature description | existing plan path [+ changes]>
---

Work out which case applies from $ARGUMENTS:

**Status / finish check** — if $ARGUMENTS references an existing plan in `tmp/plans/` with NO new work to add (just the plan path, or you're asked to check / close it):
- Report what's left: every unchecked `- [ ]` increment, plus anything marked blocked, open, deferred, or TBD.
- The plan counts as DONE only if every increment is `- [x]` AND nothing is blocked, open, deferred, or TBD. Deferred/TBD items mean NOT done.
- If done: move the plan to `tmp/plans/done/<file>` (create the folder if needed) and tell me it's complete.
- If not done: leave it in place and list exactly what remains. Do not archive.

**Extend / change** — if $ARGUMENTS references an existing plan AND asks to add or change something: read it for context, use the **qwe-planner** subagent to produce only the additional/changed increments, then append/apply them as `- [ ]` items in that SAME file. Preserve existing increments and their checked state; don't create a new file and don't alter done items.

**New plan** — otherwise treat $ARGUMENTS as a feature description: use the **qwe-planner** subagent to produce a plan, then save it verbatim to `tmp/plans/<kebab-case-name>.md` (relative to the repo root; create `tmp/plans/` if needed).

In all cases: show me the result and print its path, then stop. Never write implementation code — that's what `/qwe-implement` is for.
