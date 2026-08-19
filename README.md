# Agent Setup Codex

Codex port of the QWE workflow. The provider-neutral workflow text stays aligned with the canonical
Claude package; only file locations, invocation syntax, discovery, hooks, and agent metadata differ.

Plan → implement (implementer↔critic loop) → review gate → your commit. Agents are isolated leaf
workers; skills orchestrate. Nothing stages, commits, or pushes except the narrow Git-write operations
named by explicitly invoked `$qwe-pr` and `$qwe-worktree collapse`.

## Payload

- `.codex/AGENTS.md` — reusable Codex guidance.
- `.codex/principles.md` — generic design and workflow principles.
- `.codex/qwe-contract.md` — canonical QWE layout and asset-resolution contract.
- `.codex/qwe-layout.md` — machine-mode fallback.
- `.codex/agents/` — isolated Codex custom agents.
- `.codex/templates/` — canonical plan, review, and findings-log formats.
- `.codex/hooks.json` and `.codex/hooks/` — best-effort SessionStart workspace context.
- `.agents/skills/` — explicit-only QWE workflows.

Every QWE skill sets `allow_implicit_invocation: false`. Invoke one directly with `$qwe-...`, or
have an explicitly invoked orchestrator call its sibling workflow.

## Layout

Layout files are plain `key: value` Markdown. Resolution is deterministic, first hit wins:

1. `<product>/qwe-layout.md`
2. `<product>/.codex/qwe-layout.md`
3. `$CODEX_HOME/qwe-layout.md`, or `~/.codex/qwe-layout.md`
4. Built-in machine defaults

The nearest file wins even when invalid. Workflows report every mismatch, apply the contract's
deterministic fallback for invalid values, and continue. See `.codex/qwe-contract.md` for the complete
grammar and asset-resolution rules.

`repos:` contains code repositories only. The product repository is implicit and is never listed.

## Product Installation

Use one product repository as the workspace root. Keep plans, rules, and logs there; keep each code
repository underneath it as an independent, gitignored repository. Relative sibling paths also work
when the session has access to them.

Add a root `qwe-layout.md` before installing:

```md
mode: product
repos: repo-a=repo-a, repo-b=repo-b
plans: plans
rules: rules
logs: logs
templates: .codex/templates
```

Add a minimal root `AGENTS.md`:

```md
Read `.codex/AGENTS.md` before writing or reviewing code.
Resolve QWE paths from `./qwe-layout.md` and report every mismatch.
```

Create the declared working directories, then install the framework into the product root:

```sh
CODEX_HOME="$PWD/.codex" AGENTS_HOME="$PWD/.agents" /path/to/agent-setup-codex/install.sh
```

Codex reads every Markdown file in the resolved rules directory; no `rules/index.md` is needed.
A typical product root is:

```text
ProductRepo/
|-- AGENTS.md
|-- qwe-layout.md
|-- .codex/
|-- .agents/
|-- plans/
|-- rules/
|-- logs/
|-- repo-a/
`-- repo-b/
```

## Project Installation

For a standalone code repository, add root `qwe-layout.md` first:

```md
mode: project
plans: .codex/plans
rules: .codex/rules
logs: .codex/logs
templates: .codex/templates
```

Use the same minimal root `AGENTS.md` bootstrap shown above. Create the declared working directories,
then install the payload locally:

```sh
CODEX_HOME="$PWD/.codex" AGENTS_HOME="$PWD/.agents" /path/to/agent-setup-codex/install.sh
```

## Machine Installation

Run from this repository:

```sh
./install.sh
```

This installs guidance, agents, templates, hooks, and skills into
`${CODEX_HOME:-$HOME/.codex}` and `${AGENTS_HOME:-$HOME/.agents}`. Machine mode stores
plans, rules, logs, and templates directly below Codex home.

The installer refreshes package-managed assets while preserving an existing `qwe-layout.md`,
plans, rules, and logs. On the first upgrade from the older Codex port, it converts a valid
`qwe-layout.toml` to `qwe-layout.md` and removes the obsolete TOML file. It also removes the
superseded split message and worktree skills.

## Hooks

Codex supports SessionStart hooks natively. `.codex/hooks.json` registers the QWE hook, which scans
declared repositories for nested `AGENTS.md` files and repository-owned `.github/skills`, then reports
their paths, skill descriptions, and live Git state as developer context. Product QWE skills remain in
`.agents/skills` and use Codex's native discovery. The hook is best-effort and never blocks a session.

Codex requires trust for new or changed non-managed hooks. Review it with `/hooks` after installation.
On Windows, `commandWindows` runs `session-start.cmd`, which resolves Git Bash explicitly instead of
using the system `bash` alias. Git for Windows is therefore required, matching the installer.
Codex combines matching hook layers, so enable the QWE SessionStart hook at only one active level for
a workspace when both machine and project installations are present.

## Findings

Critic and reviewer agents are read-only. They return findings to the invoking skill. That skill is the
only writer and appends findings exactly once to `<logs>/qwe-findings.md` using
`<templates>/findings-log.md`. No findings means no file write. Review agents are optional unless an
explicitly invoked workflow requires them.

## Workflows

- `$qwe-plan`
- `$qwe-implement`
- `$qwe-review`
- `$qwe-feature`
- `$qwe-worktree`
- `$qwe-survey`
- `$qwe-message`
- `$qwe-pr`
- `$qwe-linear`
- `$qwe-rule`

## Editing

Keep the Codex port aligned with the canonical source. Change provider-neutral behavior upstream first,
then re-import it. Codex-only changes belong here only when they concern Codex paths, metadata,
invocation, discovery, hooks, or capabilities.