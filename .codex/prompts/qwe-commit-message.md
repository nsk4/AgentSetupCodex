---
description: Generate a commit message for the currently staged changes, in my style. Prints the message in chat only — never commits.
allowed-tools: Bash(git diff *), Bash(git status *), Bash(git branch *)
---

Inspect the **staged** changes only:
- `git diff --staged --stat` (which files changed)
- `git diff --staged` (the actual changes)

If nothing is staged, tell me and stop.

Write ONE commit message describing what changed, following these rules:

## Commit messages
- Single subject line, no body. Describe what changed, not why.
- Start with a past-tense verb, sentence case: Added, Fixed, Implemented,
  Updated, Changed, Reworked, Extended, Renamed, Removed, Moved, Simplified.
- No conventional-commit prefixes (no `feat:`/`fix:`/`chore:`), no scopes, no emoji.
- For multiple changes, join clauses with commas on one line.
- No trailing period.
- Keep it as short as the change allows; only run long when genuinely bundling work.
- Append ticket refs when relevant: ", closes YNT-123". Infer the ticket from the branch
  name (e.g. `git branch --show-current`) or the diff if one is clearly present; otherwise omit.
- Do not add Co-Authored-By / "Generated with" trailers.

Output just the message in a code block so I can copy it. Do NOT run `git commit`, `git add`,
or any other git write command — this produces text only.
