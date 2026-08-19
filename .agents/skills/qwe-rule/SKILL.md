---
name: qwe-rule
description: Capture a correction or preference as a persistent rule, in the right place — the project's rules folder for project conventions, principles.md for cross-project preferences. Distills to a terse rule with rationale; dedupes; shows the result.
---

# QWE Rule

Turn this into a persistent rule: the invoking request

1. **Generalization gate** — is this a recurring, generalizable preference, or a one-off fix tied to this situation? A one-off does NOT become a rule: say so and stop. (If it's really a plan item, point me at `$qwe-plan`.)

2. **Route it — never written into an implementation/code repository** (committed code-repo config is a separate, deliberate act — I do that myself via the repo's skills). Product-specific rules intentionally live in the PRODUCT repository's configured rules directory:
   - **Project-specific convention** (naming, structure, how code is written in THAT product) → the product's `<rules>` folder per the layout resolution. Write `<topic>.md` there, then ensure the product root `AGENTS.md` bootstrap loads `.codex/AGENTS.md`; that shared guidance reads every Markdown file in `<rules>`, so no static rules index is needed. No `paths:` frontmatter is needed; the product root is the scope. Report any layout mismatch you notice.
   - **Cross-project personal preference** (how I work, style, workflow) → a bullet in the fitting section of the installation's `principles.md` (resolved like other framework assets: product `.codex/` first, else Codex home (`$CODEX_HOME` or `~/.codex`)). Same bar as what's already there: one distilled bullet, no near-duplicates (merge instead), never a new section for one rule.
   - Ambiguous → ask me, one line.

3. **Distill** — write it as ONE terse rule: prefer guidance with the rationale ("prefer X because Y") over absolutes, unless it's genuinely a hard rule. Keep the scope honest — don't over-generalize a narrow preference into a blanket law, and don't invent detail I didn't give.

4. **Dedup** — read the target file first: if an existing rule already covers or contradicts this, MERGE or update it instead of appending a near-duplicate; flag a contradiction to me instead of silently overriding.

5. Show me the final rule text and where it now lives. Nothing else changes — no code edits.
