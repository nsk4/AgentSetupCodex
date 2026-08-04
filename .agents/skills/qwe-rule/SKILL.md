---
name: qwe-rule
description: Capture a correction or preference as a persistent user-level Codex rule. Routes project-specific conventions to conditionally applicable files and cross-project preferences to unscoped files; distills, deduplicates, and shows the result. Invoke explicitly with `$qwe-rule`; do not use implicitly.
---

# QWE Rule

Turn the invoking request into a persistent rule.

1. **Generalization gate** — is this a recurring, generalizable preference, or a one-off fix tied to this situation? A one-off does NOT become a rule: say so and stop. If it is really a plan item, point me at `$qwe-plan`.

2. **Route it — everything lives at user level (`~/.codex/rules/`), never written into a repo** (committed repo config is a separate, deliberate act — I do that myself through the repo's skills):
   - **Project-specific convention** (naming, structure, how code is written in THAT project) → `~/.codex/rules/<repo-name>.md`. Start the file with a plain applicability statement naming the repository or worktree path pattern and saying to ignore the file when it does not match. Use a pattern such as `**/<repo-name>*/**`; the trailing `*` also catches worktrees (`<repo-name>-feature-x`). If the repo folder name is generic (for example, `backend`), make the pattern more specific by including the parent folder so it cannot match other projects.
   - **Cross-project personal preference** (how I work, style, workflow) → `~/.codex/rules/<topic>.md`, unscoped.
   - Ambiguous → ask me, one line.

3. **Distill** — write it as ONE terse rule: prefer guidance with the rationale ("prefer X because Y") over absolutes, unless it is genuinely a hard rule. Keep the scope honest — do not over-generalize a narrow preference into a blanket law, and do not invent detail I did not give.

4. **Dedup** — read the target file first: if an existing rule already covers or contradicts this, merge or update it instead of appending a near-duplicate; flag a contradiction to me instead of silently overriding.

5. Show me the final rule text and where it now lives. Nothing else changes — no code edits.
