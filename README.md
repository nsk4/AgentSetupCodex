# Codex Agent Setup

Project-neutral Codex setup for the QWE agent workflow.

This folder is intended to be copied into another checkout or synced into your
Codex home. Keep it technology-agnostic.

## Layout

- `AGENTS.md` - personal/global Codex guidance.
- `principles.md` - editable design principles source.
- `agents/` - Codex custom subagents.
- `prompts/` - slash-command prompts written to stay portable across agent providers where practical.

## Install

Copy or sync this folder to your Codex home:

```text
.codex/AGENTS.md       -> ~/.codex/AGENTS.md
.codex/principles.md   -> ~/.codex/principles.md
.codex/agents/*.toml  -> ~/.codex/agents/
.codex/prompts/*.md   -> ~/.codex/prompts/
```

Restart Codex after changing agents, prompts, or global instructions.

## Editing Rule

Keep `prompts/` provider-portable where practical. These files are meant to be
easy to mirror to other agent tools, so avoid Codex-only wording unless the
workflow truly needs it.

`principles.md` is also intended to be drop-in replaceable.

Agents must be TOML in Codex, so `agents/*.toml` use Codex's required format
even when the same agent instructions are mirrored elsewhere in another format.

## Prompt Commands

- `/prompts:qwe-plan`
- `/prompts:qwe-implement`
- `/prompts:qwe-review`
- `/prompts:qwe-commit-message`
