# Agent Setup Codex

Project-neutral Codex setup for the QWE agent workflow.

The same workflow payload can be installed for a product workspace, a single
project repository, or the whole machine. Agent and skill behavior stays
generic; the installation layout controls where plans, rules, logs, and
templates live.

The checked-in `.codex/qwe-layout.toml` is the machine-mode default used by
`install.sh`. For a product or project installation, copy the payload locally,
create `qwe-layout.toml` at the repository root with the mode and paths shown
below, and have the root `AGENTS.md` load the reusable `.codex/AGENTS.md`
guidance.

## Payload Layout

- `.codex/AGENTS.md` - reusable Codex guidance source.
- `.codex/principles.md` - editable design principles source.
- `.codex/qwe-layout.toml` - installation mode and workflow paths.
- `.codex/agents/` - Codex custom agents.
- `.codex/templates/` - canonical plan, review-report, and findings-log formats.
- `.agents/skills/` - explicit-only QWE workflow skills.

Commands from the source workflow are represented as explicit-only skills.
Every QWE skill sets `allow_implicit_invocation: false` and runs only when it is
directly invoked or explicitly requested by an orchestrating agent.

## Installation Modes

### Product Workspace

Use this mode when a product or PM repository coordinates one or more sibling
implementation repositories.

```text
ProductRepo/
|-- AGENTS.md
|-- qwe-layout.toml
|-- .codex/
|   |-- principles.md
|   |-- agents/
|   `-- templates/
|-- .agents/
|   `-- skills/
|-- plans/
|-- rules/
`-- logs/
```

The product repository is the Codex project root. Add implementation
repositories as additional workspace folders. Keep its root `AGENTS.md` as a
small bootstrap to `.codex/AGENTS.md`; keep concrete repository ownership and
path mappings in the configured `rules/setup.md`.

```md
# Project Instructions

Read `.codex/AGENTS.md` for shared workflow instructions.
```

Use this layout:

```toml
mode = "product"
plans = "plans"
rules = "rules"
logs = "logs"
templates = ".codex/templates"
```

Paths are relative to `ProductRepo/`, where the selected layout lives. Plans,
rules, and logs therefore remain visible, Git-tracked product-workspace
artifacts while reusable templates remain under `.codex/`. A sibling code
repository may contain a small root `AGENTS.md` that declares the exact product
`ProductRepo/qwe-layout.toml` and points agents back to the product repository
bootstrap when that code repository is opened independently.

Copy the portable `.codex/rules/setup.md` skeleton to
`ProductRepo/rules/setup.md` and fill in this project's repository labels. The
configured rules directory is canonical; the payload copy under `.codex/rules`
is not read in product mode.

### Project Repository

Use this mode when the workflow is installed directly into one repository and
there is no separate product repository.

```text
ProjectRepo/
|-- AGENTS.md
|-- qwe-layout.toml
|-- .codex/
|   |-- principles.md
|   |-- agents/
|   |-- templates/
|   |-- plans/
|   |-- rules/
|   `-- logs/
`-- .agents/
    `-- skills/
```

Use this layout:

```toml
mode = "project"
plans = ".codex/plans"
rules = ".codex/rules"
logs = ".codex/logs"
templates = ".codex/templates"
```

The root layout selects this installation over machine configuration. All
workflow configuration and state other than that selector remains inside the
repository's hidden `.codex/` and `.agents/` directories.

Use the same minimal root `AGENTS.md` bootstrap shown for product mode.

The copied `.codex/rules/setup.md` is already in the configured rules
directory. Fill in the repository labels that this installation needs.

### Machine

Use this mode to make the workflow available from every repository on the
machine.

```text
~/.codex/
|-- AGENTS.md
|-- principles.md
|-- qwe-layout.toml
|-- agents/
|-- templates/
|-- plans/
|-- rules/
`-- logs/

~/.agents/
`-- skills/
```

Use this layout:

```toml
mode = "machine"
plans = "plans"
rules = "rules"
logs = "logs"
templates = "templates"
```

Machine mode deliberately uses the direct, unnamespaced
`~/.codex/{plans,rules,logs}` locations.

## Path Resolution

QWE workflows resolve paths from `qwe-layout.toml`; they do not hardcode
product, project, or home-directory paths.

Resolution order:

1. The exact QWE coordinator layout declared by an applicable `AGENTS.md`.
2. The current repository root's `qwe-layout.toml`.
3. The current repository root's `.codex/qwe-layout.toml`.
4. `qwe-layout.toml` in `$CODEX_HOME`, or `~/.codex` when `CODEX_HOME` is unset.
5. Stop with a clear configuration error when none exists.

Do not scan unrelated workspace folders. A product workspace's root
`AGENTS.md`, and any sibling-repo bootstrap used when that repo is opened
independently, must identify the product coordinator explicitly.

Every configured path is relative to the directory containing the selected
`qwe-layout.toml`. A root layout therefore overrides both the legacy
repository-local `.codex/qwe-layout.toml` fallback and a machine installation.
`$qwe-plan`, `$qwe-rule`, and findings logging must write only to the resolved
locations and must not guess or silently fall back to a different directory.

For repository-root layouts, reusable principles live at
`.codex/principles.md` below the layout directory. For `.codex` and machine
layouts, `principles.md` lives beside the layout file.

`mode` must be `product`, `project`, or `machine`. The `plans`, `rules`, `logs`,
and `templates` values are required, nonempty relative paths.

An orchestrating QWE skill resolves the layout once and passes the exact paths
to nested skills and isolated agents. Moving implementation into a sibling repo
or worktree therefore does not change where the feature's plans, rules, logs,
or templates live.

`qwe-critic` and `qwe-reviewer` remain optional outside explicitly invoked QWE
workflows. Whenever Codex chooses to use either agent, its caller persists the
returned finding-log lines once in the configured `logs/qwe-findings.md`; the
read-only review agent never writes the file itself.

## Machine Install

Clone the repository and run:

```sh
./install.sh
```

The installer copies package-managed guidance, agents, templates, and skills
into `${CODEX_HOME:-$HOME/.codex}` and `${AGENTS_HOME:-$HOME/.agents}`. It
creates the default `qwe-layout.toml` and `rules/setup.md` only when they do not
exist, preserving configured paths and repository labels across upgrades. To use
other locations:

```sh
CODEX_HOME=/path/to/codex-home AGENTS_HOME=/path/to/agents-home ./install.sh
```

In GitHub Codespaces, run this from the repository root:

```sh
bash install.sh
```

Restart Codex if changed agents, skills, or instructions do not appear
automatically.

When upgrading, the installer removes the superseded package-managed
`qwe-message-commit` and `qwe-message-pr` skills. Their commit, PR, and merge
message modes now live in `$qwe-message`.

## Rules

`$qwe-rule` writes persistent rules to the rules directory selected by
`qwe-layout.toml`. Project-specific instructions remain project-specific in
product and project modes; machine mode stores them under `~/.codex/rules/`.
The applicable `AGENTS.md` tells Codex to read the configured rule files.

Codex executable permission rules use the separate `*.rules` format. They are
not QWE Markdown guidance and are not routed through `$qwe-rule`.

## Editing Rule

Keep workflow skills close to the source commands, translating only argument
handling, paths, invocation syntax, and provider-specific capabilities that
Codex cannot use.

`principles.md` is intended to be drop-in replaceable.

Agents must be TOML in Codex, so `agents/*.toml` use Codex's required format
even when the same agent instructions are mirrored elsewhere in another
format.

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
