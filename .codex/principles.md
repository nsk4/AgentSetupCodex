# Design principles — read before writing or reviewing code

Minimalist by default. The smallest correct change wins. Throwing code away is progress.
When in doubt, build less.

## Hard rules — never break these
1. **No git writes**: never stage (`git add`), commit, or push; never `reset`/`restore`/`checkout --`/`clean`/`stash`/`revert`; no checkpoint commits. Staging and committing are only ever mine. (Editing agents run no git at all.)
2. **Byte-for-byte scope**: change only what the task requires; no reformatting or normalizing untouched code; never revert a change I asked for. This covers FUNCTIONAL overreach too: no fixing unrelated bugs you notice, no reworking related-but-not-the-point code, no improvements beyond the ask. Anything worth doing that isn't the task is a NOTE in your report (a finding / follow-up), never an edit.
3. **Docstrings by enumeration**: every NEW public interface gets one — list them and check each off; "most" is a failure.
4. **Plans are the template**: anything called a plan is `~/.codex/templates/plan.md` filled in, all sections present.

## Design
- YAGNI. No speculative abstraction, no config/params/flags for cases that don't exist yet.
- Prefer simple, obvious code over clever or complex code. Simplicity beats cleverness — reach
  for the plainest solution that works.
- One caller? Inline it. Don't add a layer until there are two real, differing uses.
- No dead code, no unused imports/exports, no commented-out blocks, no "just in case" branches.
- Smallest diff that fully solves the task. Change ONLY the lines the task requires; leave every other
  line byte-for-byte, including in files you open for other reasons. Never reformat, restyle, reorder
  imports, or normalize quotes / whitespace / type-syntax (e.g. `Optional[X]` <-> `X | None`) in code the
  task didn't already change. No drive-by cleanups, ever.
- Follow the rest of the codebase: match its patterns, conventions, and folder layout before
  inventing anything new — even when a pattern looks suboptimal, consistency wins; deviate only
  when explicitly instructed. Put new code where its kind already lives and mirror the nearest
  existing example. Keep case-specific logic local — lift into shared/core only when the same
  pattern already repeats (~3+ real uses) and abstracting genuinely simplifies.
- Delete replaced code outright — no compat shims, no deprecation paths, no dual code paths kept "for safety".
- Docstrings (see Hard rule 3): sized to the CONTRACT, not the internals — a one-line thing gets a
  one-line docstring; say what it does for its caller and *why*, at THIS layer's abstraction. Never
  narrate *what* the code does; document an edge case once, at the layer that handles it — never
  echoed up into higher-level docstrings. Same restraint for comments. No ticket/issue IDs in code.
- Memory writes are EXPLICIT-ONLY: never save anything to memory (auto-memory or any other persistent store) on your own initiative — only when I explicitly ask you to remember something. Durable decisions live in the repo — code, docstrings, READMEs, rules, skills — never only in assistant memory; treat memory as disposable local hints, the repo is the source of truth.
- New behavior gets a test; don't test framework internals.

## Stack conventions live in the project
Language-, framework-, and project-specific rules — how code is structured, styled, and organized —
and project-phase policies (e.g. whether breaking changes are acceptable) are defined per project, in
that repo's own instructions, rules, and skills. Follow those. This file stays tech- and tool-agnostic.

## Workflow
- Every implemented change is challenged by the qwe-critic (design + minimalism) as it's built;
  the full qwe-reviewer gate runs on demand ($qwe-review) or before a PR ($qwe-feature).
- Git roles (see Hard rule 1): editing agents run no git; review agents inspect read-only; the
  working tree is left for me. Never `git add` even to "reconcile" an already-staged file — the
  staged/unstaged split is mine. Correct mistakes through normal file edits, never git operations.
- A handoff prompt for a repo/agent OUTSIDE the current run's scope goes in chat as a Markdown block — never written into a plan, doc, or code file. Never hand off work for a repo that IS in scope — implement it.
- Any plan you write follows `~/.codex/templates/plan.md`, whatever its source (feature request, ticket, or review findings) — fill the template, don't freeform.
- When relaying critic/reviewer findings to a fixer, the orchestrating skill decides what to apply: reject any finding that would merely reverse a deliberate simplification or undo a requested/legitimate change. If the critic and reviewer conflict (one wants something removed, the other kept or added), STOP and flag it — never ping-pong fixes back and forth.
