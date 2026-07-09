---
description: Manage a plan with the qwe-planner subagent — create a new one, extend/change an existing one, or check its status. Archives a finished plan to tmp/plans/done. Never writes code.
argument-hint: <feature description | existing plan path [+ changes]>
---

Work out which case applies from $ARGUMENTS:

**Status / finish check** — if $ARGUMENTS references an existing plan in `tmp/plans/` with NO new work to add (just the plan path, or you're asked to check / close it):
- Report what's left: everything still under `## To do`, plus anything marked blocked, open, deferred, or TBD.
- The plan is DONE only if `## To do` has no remaining items AND nothing anywhere is blocked / open / deferred / TBD.
- If done: move the plan to `tmp/plans/done/<file>` (create the folder if needed) and tell me it's complete.
- If not done: leave it in place and list exactly what remains. Do not archive.

**Extend / change** — if $ARGUMENTS references an existing plan AND asks to add or change something: read it for context, use the **qwe-planner** subagent to produce ONLY the additional/changed increments, then append them as `- [ ]` items under that file's `## To do`. Leave the existing structure, other increments, and the `## Done` section untouched. Keep it terse — don't restate or re-explain existing content.

**New plan** — otherwise treat $ARGUMENTS as a feature description: use the **qwe-planner** subagent to produce a plan in its standard structure, then save it to `tmp/plans/<kebab-case-name>.md` (relative to the repo root; create `tmp/plans/` if needed).

In all cases: show me the result and print its path, then stop. Never write implementation code — that's what `/qwe-implement` is for.
