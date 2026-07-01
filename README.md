# Codex Agent Setup

Project-neutral Codex setup ported from the Claude QWE workflow.

This folder is intended to be copied into another checkout or synced into your
Codex home. Keep it technology-agnostic.

## Layout

- `AGENTS.md` - personal/global Codex guidance.
- `principles.md` - editable design principles source.
- `agents/` - Codex custom subagents, equivalent to Claude agents.
- `prompts/` - Codex slash-command prompts, equivalent to Claude commands.

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

The files in `prompts/` are direct mirrors of the Claude command files. To keep
change management simple, update the source Claude command and copy-replace the
matching prompt file here.

`principles.md` is also intended to be drop-in replaceable.

Agents must be TOML in Codex, so `agents/*.toml` are close translations of the
Claude agent Markdown files rather than byte-for-byte copies.

## Prompt Commands

- `/prompts:qwe-plan`
- `/prompts:qwe-implement`
- `/prompts:qwe-review`
- `/prompts:qwe-commit-message`
