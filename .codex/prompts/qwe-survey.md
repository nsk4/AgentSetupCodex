---
description: Survey a slice of the codebase (a domain/folder, or a whole repo) for duplication, inconsistency, and real abstraction/simplification opportunities. Read-only; proposes, changes nothing.
argument-hint: <path or domain to survey>
---

Use the **qwe-surveyor** agent (in its own context, so the codebase reading doesn't fill this conversation) to survey: $ARGUMENTS

If I didn't give a scope, ask which domain/folder to survey rather than scanning the whole repo blindly — a large repo is better done in per-domain passes. Show the surveyor's prioritized table exactly as returned. Change nothing. When I pick items to act on, I'll turn them into a plan with `/prompts:qwe-plan`.
