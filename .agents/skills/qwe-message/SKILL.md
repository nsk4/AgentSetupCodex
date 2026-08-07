---
name: qwe-message
description: Generate git messages, text-only — commit message (default), PR description (`pr`), or a merge-commit line (`merge`); single repo or several. Never commits, stages, or pushes.
---

# QWE Message

Produce the requested message(s) as text to copy — read-only git, output in code block(s), never run any git write command.

**Mode from the invoking request:**
- *(bare)* → COMMIT message for the current repo.
- `<repo-labels…>` → COMMIT message PER named repo (labels from my setup, resolved to reachable roots — don't guess; each repo inspected independently, one labeled code block each).
- `merge` → MERGE-COMMIT message for the current repo.
- `pr [repo-labels…] [base]` → PR description for the current repo, or per named repo.

## Commit mode
Inspect the repo's **staged** changes only (`git diff --staged --stat`, `git diff --staged`). Nothing staged → say so (per repo) and stop.
Write ONE **brief** message:
- Single subject line, no body. Describe what changed, not why.
- Start with a past-tense verb, sentence case: Added, Fixed, Implemented, Updated, Changed, Reworked, Extended, Renamed, Removed, Moved, Simplified.
- No conventional-commit prefixes (`feat:`/`fix:`/`chore:`), no scopes, no emoji, no trailing period.
- Length matches the change: a small/medium change is ONE short clause — never padded. Only a commit genuinely bundling several DISTINCT changes earns more, as comma clauses on one line (one terse clause per distinct change; never split a single change into several). Summarize at a high level, never enumerate files. When in doubt, go shorter.
- Ticket refs: identifier like `YNT-123` (never `#123`), sourced from the plan's `## Tickets`, the branch name, or the diff. Fully resolves it → `, closes YNT-123`; only advances it → `, refs YNT-123`; none found → omit.
- No Co-Authored-By / "Generated with" trailers.

## Merge mode
Emit the standard git-style line, nothing more: `Merge branch '<source>' into <target>`. Source/target from context: an in-progress merge (`MERGE_HEAD`) or the branches named in the invoking request; target defaults to the current branch. Can't tell the source → ask in one line. No body, no ticket refs.

## PR mode
Scope = everything the branch introduces vs its base: `git diff $(git merge-base HEAD <base>)` plus staged/unstaged/untracked (`git status --short`). Base = the one named in the invoking request, else the repo's default branch (`git rev-parse --abbrev-ref origin/HEAD`, fallback `main`/`master`). Branch introduces nothing → say so.
**Template:** use the repo's PR template if present (`.github/PULL_REQUEST_TEMPLATE.md`, `.github/pull_request_template.md`, `docs/pull_request_template.md`, or under `.github/PULL_REQUEST_TEMPLATE/`) — follow it EXACTLY, filling each section from the actual changes (`N/A` only where it genuinely doesn't apply). No template → concise default: one-line summary, **What changed** (high level), **Why**, **Testing** if relevant.
**Style:** same spirit as commit mode — concise, high-level, no file-by-file dumps. Include `Closes YNT-123` / `Refs YNT-123` when a ticket applies.

Multi-repo: label each repo's message clearly, one code block per repo.
