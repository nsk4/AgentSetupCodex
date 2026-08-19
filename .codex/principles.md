# Design principles — read before writing or reviewing code

Minimalist by default. The smallest correct change wins. Throwing code away is progress.
When in doubt, build less.

## Hard rules — never break these
1. **No git writes**: never stage (`git add`), commit, or push; never `reset`/`restore`/`checkout --`/`clean`/`stash`/`revert`; no checkpoint commits. Staging and committing are only ever mine. (Editing agents run no git at all.) The ONLY exceptions are skills whose stated purpose IS a specific git write and that I directly invoked — each names its narrow exception itself (e.g. opening a PR pushes its source branch; collapsing a worktree uses one transient transport commit that must be undone). Never as a side effect of anything else.
2. **Byte-for-byte scope**: change only what the task requires; no reformatting or normalizing untouched code; never revert a change I asked for. This covers FUNCTIONAL overreach too: no fixing unrelated bugs you notice, no reworking related-but-not-the-point code, no improvements beyond the ask. Anything worth doing that isn't the task is a NOTE in your report (a finding / follow-up), never an edit. If an AD-HOC (non-plan) ask balloons beyond its implied size — a "small tweak" turning multi-file — confirm with me before proceeding; plan-driven work instead follows the plan's declared touches.
3. **Docstrings by enumeration**: every NEW public interface gets one — list them and check each off; "most" is a failure.
4. **Plans are the template**: anything called a plan is `<templates>/plan.md` filled in, all sections present.
5. **Grounded, on-request**: do what I actually asked — all of it, nothing else; re-read the request before acting and never SILENTLY substitute your own version of the task. This is not blind literalism: if the literal ask would force overengineering or fight these principles, don't contort the code to satisfy it — and don't quietly do something else either. Say so in one line, propose the simpler version, and let me decide (in a non-interactive run: take the simpler version and record it under the plan's Assumptions). Never state something as fact you haven't verified THIS session (file read, command run, output seen): no invented APIs/paths/behavior, no claiming an action succeeded unverified. Unsure → check or say you're unsure.

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
  existing example. Absence is a signal: a construct, pattern, dependency, or technique that appears
  NOWHERE in the codebase is probably not needed — solve it the way the codebase already solves such
  things, and introduce something new only deliberately, said out loud. Keep case-specific logic
  local — lift into shared/core only when the same pattern already repeats (~3+ real uses) and
  abstracting genuinely simplifies.
- Delete replaced code outright — no compat shims, no deprecation paths, no dual code paths kept "for safety".
- Docstrings (see Hard rule 3): sized to the CONTRACT, not the internals — a one-line thing gets a
  one-line docstring; say what it does for its caller and *why*, at THIS layer's abstraction. Never
  narrate *what* the code does; document an edge case once, at the layer that handles it — never
  echoed up into higher-level docstrings. Same restraint for comments. No ticket/issue IDs in code.
- Memory writes are EXPLICIT-ONLY: never save anything to memory (auto-memory or any other persistent store) on your own initiative — only when I explicitly ask you to remember something. Durable decisions live in the repo — code, docstrings, READMEs, rules, skills — never only in assistant memory; treat memory as disposable local hints, the repo is the source of truth.
- New behavior gets a test; don't test framework internals.

## Workflow
- Spawn a subagent only when isolation PAYS: large exploratory reads, repeated passes, protecting a
  long-running orchestration's context, or fresh judgment on this session's OWN output (self-review is
  biased). Never spawn for output cleanliness (that isn't real) or when the calling context could do the
  work with what it already has — every spawn re-pays context discovery. The writer and the judge of a
  change never share a context — at least one side is always spawned.
- Resume after interruption (API limit, network, terminated session): when I say to continue, re-derive
  where you were from durable state (task list, plan/notes on disk, `git status`) and REDO the interrupted
  step. A spawned agent with no returned result DIDN'T HAPPEN: spawn it again (its context is gone; partial
  edits on disk are valid working state). Never assume an unconfirmed step succeeded; never redo work
  that's confirmed done.
- Git roles (see Hard rule 1): editing agents run no git; review agents inspect read-only; the
  working tree is left for me. Never `git add` even to "reconcile" an already-staged file — the
  staged/unstaged split is mine. Correct mistakes through normal file edits, never git operations.
- A handoff prompt for a repo/agent OUTSIDE the current run's scope goes in chat as a Markdown block — never written into a plan, doc, or code file. Never hand off work for a repo that IS in scope — implement it.
- Any plan you write follows `<templates>/plan.md`, whatever its source (feature request, ticket, or review findings) — fill the template, don't freeform.
