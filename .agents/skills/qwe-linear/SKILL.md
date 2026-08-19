---
name: qwe-linear
description: Create a Linear ticket from the passed content, at the right altitude — high-level for a feature, detailed only for genuinely low-level items. Requires a connected Linear MCP.
---

# QWE Linear

Create a Linear issue for: the invoking request

If the project's rules declare a ways-of-working reference (how tickets are written/handled), read and honor it — it overrides the generic guidance below where they differ.

This needs a **Linear MCP** connected (the issue is created through it). If none is connected, say so and stop.

Write it at the altitude of the request — do not over-specify:
- A **high-level feature** stays high-level: what needs to be done, why, and its implications/impact to the degree that makes sense. Do NOT enumerate specific files, models, functions, or exact changes.
- A **low-level item / bug** gets the specific detail it genuinely needs.
- Never invent detail the request doesn't warrant.

Content: a clear title; a description covering *what* and *why*; implications/scope where they matter; acceptance criteria if they're obvious. Create it via the Linear MCP (ask which team/project if it isn't clear from context).

**Status:** the ticket goes to the team's DEFAULT backlog status. Do NOT pick a status yourself — don't pass any state unless I asked for one; if the MCP call requires a state, look up the team's default backlog status and use exactly that (never another backlog-type status that merely looks right). A different status only when I clearly ask (e.g. "create it as Todo"). Report the created identifier (e.g. `ABC-123`), its URL, and the status it landed in. Do not start implementing.
