---
name: qwe-message-commit
description: Generate a commit message for the currently staged changes, in my style. Prints the message in chat only — never commits.
---

# QWE Commit Message

Inspect the **staged** changes only:
- `git diff --staged --stat` (which files changed)
- `git diff --staged` (the actual changes)

If nothing is staged, tell me and stop.

Write ONE **brief** commit message — the shortest line that captures what changed — following these rules:

## Commit messages
- Single subject line, no body. Describe what changed, not why.
- Start with a past-tense verb, sentence case: Added, Fixed, Implemented,
  Updated, Changed, Reworked, Extended, Renamed, Removed, Moved, Simplified.
- No conventional-commit prefixes (no `feat:`/`fix:`/`chore:`), no scopes, no emoji.
- No trailing period.
- Length matches the change: a small/medium change is ONE short clause — never padded. Only a commit genuinely bundling several DISTINCT changes earns more, as comma clauses on one line (one terse clause per distinct change; never split a single change into several). Summarize at a high level, never enumerate files. When in doubt, go shorter.
- Ticket refs (Linear): the identifier is like `YNT-123`, NOT `#123`. Source it from the plan's `## Tickets`, the branch name, or the diff. If this commit fully resolves the ticket, append the close keyword — `, closes YNT-123`; if it only advances it, reference without closing — `, refs YNT-123`. No ticket found → omit.
- Do not add Co-Authored-By / "Generated with" trailers.

Output just the message in a code block so I can copy it. Do NOT run `git commit`, `git add`,
or any other git write command — this produces text only.
