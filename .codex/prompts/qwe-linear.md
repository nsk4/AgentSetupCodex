---
description: Create a Linear ticket from the passed content, at the right altitude — high-level for a feature, detailed only for genuinely low-level items. Requires a connected Linear MCP.
argument-hint: <what the ticket is about>
---

Create a Linear issue for: $ARGUMENTS

This needs a **Linear MCP** connected (the issue is created through it). If none is connected, say so and stop.

Write it at the altitude of the request — do not over-specify:
- A **high-level feature** stays high-level: what needs to be done, why, and its implications/impact to the degree that makes sense. Do NOT enumerate specific files, models, functions, or exact changes.
- A **low-level item / bug** gets the specific detail it genuinely needs.
- Never invent detail the request doesn't warrant.

Content: a clear title; a description covering *what* and *why*; implications/scope where they matter; acceptance criteria if they're obvious. Create it via the Linear MCP (ask which team/project if it isn't clear from context), then report the created identifier (e.g. `YNT-123`) and its URL. Do not start implementing.
