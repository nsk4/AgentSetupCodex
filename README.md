# Agent Setup Codex

Project-neutral Codex setup for the QWE agent workflow.

This folder is intended to be copied into another checkout or synced into your
Codex home. Keep it technology-agnostic.

## Layout

- `AGENTS.md` - personal/global Codex guidance.
- `principles.md` - editable design principles source.
- `rules/*.md` - extensible user-specific context; `rules/setup.md` is the starter skeleton.
- `agents/` - Codex custom agents.
- `templates/` - canonical plan, review-report, and findings-log formats.
- `../.agents/skills/` - explicit-only QWE workflow skills.

## Install

On a local machine, clone the repository and run:

```sh
./install.sh
```

The installer copies `.codex/` into `${CODEX_HOME:-$HOME/.codex}` and
`.agents/` into `${AGENTS_HOME:-$HOME/.agents}`, preserving unrelated files. To
use other locations:

```sh
CODEX_HOME=/path/to/codex-home AGENTS_HOME=/path/to/agents-home ./install.sh
```

In GitHub Codespaces, run this from the repository root:

```sh
bash install.sh
```

Restart Codex if changed agents, skills, or global instructions do not appear automatically.

When upgrading, the installer removes the superseded package-managed
`qwe-message-commit` and `qwe-message-pr` skills. Their commit, PR, and merge
message modes now live in `$qwe-message`.

Markdown files under `rules/` are loaded because `AGENTS.md` explicitly tells
Codex to read them. Project-specific files declare their own applicability and
are ignored outside matching repository or worktree paths. Codex's executable
permission rules use the separate `*.rules` format in the same configuration
namespace.

## Editing Rule

Keep workflow skills close to the source commands, translating only argument
handling, paths, invocation syntax, and provider-specific capabilities that
Codex cannot use. Every QWE skill is explicit-only through
`allow_implicit_invocation: false`.

`principles.md` is also intended to be drop-in replaceable.

Agents must be TOML in Codex, so `agents/*.toml` use Codex's required format
even when the same agent instructions are mirrored elsewhere in another format.

## Workflow Skills

- `$qwe-plan`
- `$qwe-implement`
- `$qwe-review`
- `$qwe-feature`
- `$qwe-worktree-add`
- `$qwe-worktree-collapse`
- `$qwe-survey`
- `$qwe-message` (commit by default; `pr` and `merge` modes)
- `$qwe-linear`
- `$qwe-rule`
