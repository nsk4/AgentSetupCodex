# Design principles — read before writing or reviewing code

This project is minimalist. The smallest correct change wins. Throwing code away is progress.
When in doubt, build less.

## Design
- YAGNI. No speculative abstraction, no config/params/flags for cases that don't exist yet.
- Prefer simple, obvious code over clever or complex code. Simplicity beats cleverness — reach
  for the plainest solution that works.
- One caller? Inline it. Don't add a layer until there are two real, differing uses.
- No dead code, no unused imports/exports, no commented-out blocks, no "just in case" branches.
- Smallest diff that fully solves the task. Don't refactor adjacent code unasked.
- Follow the rest of the codebase. Match its existing patterns, conventions, and folder
  layout before inventing anything new — even when a pattern looks suboptimal, consistency
  with the surrounding code wins. Deviate only when explicitly instructed.
- Delete replaced code outright — no compat shims, no deprecation paths, no dual code paths kept "for safety".
- Comments/docstrings explain *why* and document public interfaces. Never narrate *what* the code says.
- Durable decisions live in the repo — code, docstrings, READMEs, skills, CLAUDE.md/rules — never only in auto-memory. Treat auto-memory as disposable local hints; the repo is the source of truth.
- New behavior gets a test; don't test framework internals.

## Stack conventions live in the project
Language-, framework-, and project-specific rules — how code is structured, styled, and organized —
and project-phase policies (e.g. whether breaking changes are acceptable) are defined per project, in
that repo's CLAUDE.md, rules, and skills. Follow those. This file stays tech-agnostic.

## Workflow
- Every change gets reviewed before I see it: the qwe-critic challenges the design and trims it,
  then a general review checks for bugs, edge cases, and correctness.
- Don't commit. Leave changes in the working tree for me to review and commit myself.
  Commit or create a branch only when I explicitly ask.
