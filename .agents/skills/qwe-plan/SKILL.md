---
name: qwe-plan
description: Manage a plan with the qwe-planner agent — create, extend/change, or check status. Archives a finished plan to the plans folder's done/. Never writes code.
---

# QWE Plan

**Plans folder** — plans live in `../plans/` if that shared folder exists (a plans folder you've added to the workspace), otherwise `./tmp/plans/` in the current repo. Prefer the shared one when present; create the folder if needed.

**A plan is ALWAYS `~/.codex/templates/plan.md` filled in** — whatever its source (a feature request, a Linear ticket, or review findings). Never dump a freeform list; if I hand you findings or follow-ups to turn into a plan, still produce them through the template.

Work out which case applies from the invoking request:

**Status / finish check** — if the invoking request references an existing plan (in the plans folder) with NO new work to add (just the path, or you're asked to check / close it):
- FIRST check the plan mechanically against `~/.codex/templates/plan.md`: `# Plan:` title then exactly these sections in this order — Repos, Tickets, Needs your input, Assumptions, To do, Done, Out of scope (empty ones say `None`), tags standard (`⛔ blocked:` / `✎ polish`). If it doesn't fit, FLAG that clearly at the top of your report and offer to normalize it — do NOT silently proceed as if it's well-formed.
- Report what's left from `## To do`, GROUPED so I instantly see the nature of each: **⛔ blocked** (with exactly what each waits on), **✎ polish** (minor finishing touches), and plain **ready** items. Don't lump them together.
- The plan is DONE only if `## To do` is empty (no ready, blocked, or polish items).
- If done: move it to `<plans folder>/done/<file>` (create the folder if needed) and tell me.
- If not done: leave it in place and list what remains, grouped as above. Do not archive.

**Extend / change** — if the invoking request references an existing plan AND asks to add/change something: read it, use the **qwe-planner** agent for the new/changed increments, and append them under `## To do` formatted EXACTLY like the template's To-do items (checkbox, sub-bullets, tags). Leave existing items and `## Done` untouched; don't restate existing content. Then re-read the WHOLE file and confirm it still matches `~/.codex/templates/plan.md` (sections, order, tags); fix any drift before finishing.

**New plan** — otherwise treat the invoking request as a feature description: use the **qwe-planner** agent for the plan's SUBSTANCE (open decisions, increments, repos). Then WRITE the file by starting from `~/.codex/templates/plan.md` as the skeleton and filling each section with the planner's material — replace every `<...>` placeholder; keep ALL sections present and in order, writing `None` in any that don't apply — never drop a section. Do NOT regenerate the structure from scratch — the saved file must have the template's sections in order. Save as `<plans folder>/<kebab-case-name>.md` (shared `../plans/` if present, else per-repo `./tmp/plans/` under the repo the plan targets — ask if unclear).

**Cross-agent prompts:** if I ask for a prompt to hand to a DIFFERENT agent (e.g. another repo/side), output it as a Markdown code block in your CHAT reply — NEVER write it into the plan file. The plan is my working state; handoff prompts belong in chat.

**Tickets:** if the input is or references Linear ticket(s) — a ticket ID/URL, or I mention one — record the identifier(s) in the plan's `## Tickets` (e.g. `YNT-123`) so `$qwe-implement` and `$qwe-message-commit` can reference/close them.

In all cases: show me the result and print its path. If `## Needs your input` is non-empty, ASK me those questions NOW — numbered, with the planner's recommended default for each. Fold each answer into the plan (into the increments and/or `## Assumptions`) and REMOVE the resolved item, so `## Needs your input` ends at `None`. A finished qwe-plan run leaves NO open questions — the only way one remains is if I explicitly didn't answer it. Then stop. Never write implementation code — that's what `$qwe-implement` is for.
