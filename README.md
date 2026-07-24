# Agent Setup Codex

Project-neutral Codex setup for the QWE agent workflow.

This folder is intended to be copied into another checkout or synced into your
Codex home. Keep it technology-agnostic.

## Layout

- `AGENTS.md` - personal/global Codex guidance.
- `principles.md` - editable design principles source.
- `rules/*.md` - extensible user-specific context; `rules/setup.md` is the starter skeleton.
- `agents/` - Codex custom agents.
- `prompts/` - explicit slash-command workflows.
- `templates/` - canonical plan and review-report formats.

## Install

Copy or sync this folder to your Codex home:

```text
.codex/AGENTS.md       -> ~/.codex/AGENTS.md
.codex/principles.md   -> ~/.codex/principles.md
.codex/agents/*.toml  -> ~/.codex/agents/
.codex/prompts/*.md   -> ~/.codex/prompts/
.codex/rules/*.md     -> ~/.codex/rules/
.codex/templates/*.md -> ~/.codex/templates/
```

Restart Codex after changing agents, prompts, or global instructions.

Markdown files under `rules/` are loaded because `AGENTS.md` explicitly tells
Codex to read them. Codex's executable permission rules use the separate
`*.rules` format in the same configuration namespace.

## Editing Rule

Keep `prompts/` close to the source workflow, translating only paths,
invocation syntax, and provider-specific capabilities that Codex cannot use.
Codex currently marks custom prompts deprecated, but this payload retains them
intentionally to preserve explicit command-style entrypoints.

`principles.md` is also intended to be drop-in replaceable.

Agents must be TOML in Codex, so `agents/*.toml` use Codex's required format
even when the same agent instructions are mirrored elsewhere in another format.

## Prompt Commands

- `/prompts:qwe-plan`
- `/prompts:qwe-implement`
- `/prompts:qwe-review`
- `/prompts:qwe-feature`
- `/prompts:qwe-worktree-add`
- `/prompts:qwe-worktree-collapse`
- `/prompts:qwe-survey`
- `/prompts:qwe-message-commit`
- `/prompts:qwe-message-pr`
- `/prompts:qwe-linear`
