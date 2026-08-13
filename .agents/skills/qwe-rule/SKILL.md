---
name: qwe-rule
description: Capture a correction or preference as a persistent QWE rule. Routes project conventions to the configured rules directory and installation-wide preferences to the selected principles file; distills, deduplicates, and shows the result. Invoke explicitly with `$qwe-rule`; do not use implicitly.
---

# QWE Rule

Turn the invoking request into a persistent rule.

**Layout — resolve it once using the applicable `AGENTS.md` contract.** Use its resolved `rules` path. For a repository-root layout, use `.codex/principles.md` below the layout directory; otherwise use `principles.md` beside `qwe-layout.toml`.

1. **Generalization gate** — is this a recurring, generalizable preference, or a one-off fix tied to this situation? A one-off does NOT become a rule: say so and stop. If it is really a plan item, point me at `$qwe-plan`.

2. **Route it through the selected layout:**
   - **Project-specific convention** (naming, structure, how code is written in this project) → `<rules>/<topic>.md`. In `machine` mode, start the file with a plain applicability statement naming the repository or worktree path pattern and saying to ignore the file when it does not match. Make generic repo names specific enough that they cannot match unrelated projects. In `product` or `project` mode, the installation already scopes the rule; add narrower applicability only when needed.
   - **Installation-wide personal preference** (how I work, style, workflow) → the fitting section of the selected `principles.md`. Keep its existing structure; do not add a section for one rule.
   - Ambiguous → ask me, one line.

3. **Distill** — write it as ONE terse rule: prefer guidance with the rationale ("prefer X because Y") over absolutes, unless it is genuinely a hard rule. Keep the scope honest — do not over-generalize a narrow preference into a blanket law, and do not invent detail I did not give.

4. **Dedup** — read the target file first: if an existing rule already covers or contradicts this, merge or update it instead of appending a near-duplicate; flag a contradiction to me instead of silently overriding.

5. Show me the final rule text and where it now lives. Nothing else changes — no code edits.
