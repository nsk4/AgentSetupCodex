---
description: Generate a commit message for the currently staged changes, in my style. Prints the message in chat only — never commits.
---

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
- Only when the commit genuinely bundles several DISTINCT changes, join them as comma clauses on one line — one terse clause per distinct change; never split a single change into multiple clauses.
- No trailing period.
- Length matches the change. A small or medium change is ONE short clause — do NOT pad it with detail that isn't needed to identify what changed. Only a genuinely large change spanning several distinct areas earns more (one terse clause per area). Summarize at a high level, never enumerate files. When in doubt, go shorter.
- Append ticket refs when relevant: ", closes YNT-123". Infer the ticket from the branch
  name (e.g. `git branch --show-current`) or the diff if one is clearly present; otherwise omit.
- Do not add Co-Authored-By / "Generated with" trailers.

Output just the message in a code block so I can copy it. Do NOT run `git commit`, `git add`,
or any other git write command — this produces text only.
