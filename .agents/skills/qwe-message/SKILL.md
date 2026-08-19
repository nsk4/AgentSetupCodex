---
name: qwe-message
description: Generate git messages, text-only — commit message (default), PR description (`pr`), or a merge-commit line (`merge`); single repo or several. Never commits, stages, or pushes.
---

# QWE Message

Produce the requested message(s) as text to copy — read-only git, output in code block(s), never run any git write command.

**Mode from the invoking request:**
- *(bare)* → COMMIT message for the current repo.
- `<repo-labels…>` → COMMIT message PER named repo (labels as the current project declares them, resolved to reachable roots — don't guess; each repo inspected independently, one labeled code block each).
- `merge` → MERGE-COMMIT message for the current repo.
- `pr [repo-labels…] [base]` → PR description for the current repo, or per named repo.

## Commit mode
Inspect the repo's **staged** changes only (`git diff --staged --stat`, `git diff --staged`). Nothing staged → say so (per repo) and stop.
Write ONE **brief** message:
- Single subject line, no body. Describe what changed, not why.
- Start with a past-tense verb, sentence case: Added, Fixed, Implemented, Updated, Changed, Reworked, Extended, Renamed, Removed, Moved, Simplified.
- No conventional-commit prefixes (`feat:`/`fix:`/`chore:`), no scopes, no emoji, no trailing period.
- Length matches the change: a small/medium change is ONE short clause — never padded. Only a commit genuinely bundling several DISTINCT changes earns more, as comma clauses on one line (one terse clause per distinct change; never split a single change into several). Summarize at a high level, never enumerate files. When in doubt, go shorter.
- Ticket refs: identifier like `ABC-123` (never `#123`), sourced from the plan's `## Tickets`, the branch name, or the diff. Fully resolves it → `, closes ABC-123`; only advances it → `, refs ABC-123`; none found → omit.
- No Co-Authored-By / "Generated with" trailers.

## Merge mode
Emit the standard git-style line, nothing more: `Merge branch '<source>' into <target>`. Source/target from context: an in-progress merge (`MERGE_HEAD`) or the branches I name; target defaults to the current branch. Can't tell the source → ask in one line. No body, no ticket refs.

## PR mode
Scope = everything the branch introduces vs its base: `git diff $(git merge-base HEAD <base>)` plus staged/unstaged/untracked (`git status --short`). Base = the one I named, else the repo's default branch (`git rev-parse --abbrev-ref origin/HEAD`, fallback `main`/`master`). Branch introduces nothing → say so.
**Output = a TITLE + the body.** Title first, on its own line: short, high-level, names the feature/change (same spirit as a commit subject, no prefixes/emoji/period).
**Template:** use the repo's PR template if present (`.github/PULL_REQUEST_TEMPLATE.md`, `.github/pull_request_template.md`, `docs/pull_request_template.md`, or under `.github/PULL_REQUEST_TEMPLATE/`) — follow it EXACTLY, filling each section from the actual changes (`N/A` only where it genuinely doesn't apply). No template → concise default: one-line summary, **Changes**, **Why**, **Testing** if relevant.
**Style — read like a CHANGELOG, not a recap of facts:** the changes section is a bulleted changelog — each bullet one coherent capability/change from the reader's perspective ("Added X", "Reworked Y to …"), grouped when related, ordered most significant first. Granularity scales with the work: small PR = a couple of bullets, big PR = more — but stay one level HIGHER than the implementation detail; never file-by-file, never narrate the process. Include `Closes ABC-123` / `Refs ABC-123` when a ticket applies.

Multi-repo: label each repo's message clearly, one code block per repo.
