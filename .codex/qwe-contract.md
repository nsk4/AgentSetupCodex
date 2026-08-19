<!-- QWE workflow guidance — the layout/asset-resolution contract. Loaded via AGENTS.md. -->

## QWE layout contract
- Each product has ONE product repo holding the working material: `AGENTS.md` (a minimal bootstrap),
  the layout declaration, plans, rules, logs — and optionally its own `.codex/` and `.agents/`, so
  nothing has to live globally. **Workspace arrangement — canonical:** open the product root as the
  workspace, with the code repos UNDER it (each its own git repo; the product repo gitignores them).
  Product guidance loads first; before work in a code repo, read that repo's root and applicable nested
  `AGENTS.md` files and matching skills, so the repo's instructions win conflicts. Sibling code repos
  may instead be declared with relative `../` paths when the session can access them; never infer or
  scan undeclared repositories.
- **Layout resolution** (first hit wins): `<product>/qwe-layout.md` → `<product>/.codex/qwe-layout.md`
  → `$CODEX_HOME/qwe-layout.md` when set, otherwise `~/.codex/qwe-layout.md` → built-in machine defaults. Layout files are plain
  `key: value` lines (`plans`/`rules`/`logs`/`templates`, plus
  `repos: label=path, label=path` declaring the product's CODE repos ONLY — the product repo itself is
  implicit and never listed — as the single source for repo labels). Path values are nonempty RELATIVE
  paths. Resolution base by mode: `product`/`project` → the root the layout governs (the file's
  directory, or its parent when the file sits in `.codex/`); `machine` → Codex home itself. Resolve
  rather than block — but ANY mismatch MUST be reported loudly, never silently picked over: conflicting
  layout files (nearer wins), a declared folder missing, or an existing folder contradicting the
  declaration. `<plans>` / `<rules>` / `<logs>` / `<templates>` mean these resolved locations
  throughout the framework.
- **Layout parsing (deterministic):** recognized keys are `mode`, `plans`, `rules`, `logs`,
  `templates`, and optional `repos` — each at most ONCE. `mode` ∈ `machine` | `project` |
  `product`. Path values are nonempty RELATIVE paths. `repos:` is comma-separated
  `label=relative-path` entries, CODE repositories only (the product repo is implicit and never
  listed); labels nonempty and unique. Blank lines and lines starting with `#` are ignored. Anything
  else — duplicate, malformed, unknown, missing, or invalid — is a LAYOUT MISMATCH to report.
  **The nearest layout file always wins, even when invalid — never silently fall through to a farther
  one.** For an invalid or missing value, use the mode's built-in default for that key AND report the
  mismatch. Unknown keys are reported and ignored. Missing/invalid `mode` falls back deterministically:
  a layout under Codex home → `machine`; any repository-scoped layout → `project`; `product` is
  NEVER inferred. Workflows never stop over layout problems — they resolve, report, and continue.
- **Canonical modes** (default path sets): `machine` — plans/rules/logs/templates in Codex home;
  `project` — all four under the repo's `.codex/`; `product` — plans/rules/logs at the product
  root, `templates: .codex/templates`. Product mode's split is deliberate: the `.codex/` and
  `.agents/` setup can be upgraded without touching durable working material.
- **Framework assets:** `<templates>` resolves through the layout's `templates:` value (then the
  mode default). Skills, custom agents, principles, and this contract resolve independently:
  product-local `<product>/.agents/skills/` and `<product>/.codex/{agents,principles.md,qwe-contract.md}`
  first, else `$AGENTS_HOME/skills/` when set, otherwise `~/.agents/skills/` and
  `$CODEX_HOME/{agents,principles.md,qwe-contract.md}` when set, otherwise `~/.codex/{agents,principles.md,qwe-contract.md}`. Report when levels conflict.
  `<skills>` and `<agents>` mean those resolved locations.
- The product `AGENTS.md` is a minimal bootstrap: it tells Codex to read `.codex/AGENTS.md` and
  resolve the QWE layout. Repo labels come only from `repos:`; rules carry product prose and
  conventions. Codex reads every Markdown file in `<rules>`; no static rules index is required.
- **Repo documentation contract:** code repos may keep guidance outside Codex's active discovery path
  (for example a nested repo's root `AGENTS.md` and skills under `.github/skills/`). The SessionStart
  hook advertises those paths. Whatever the task, read the code repo's root `AGENTS.md` before work in
  it; before editing under a directory, read the nearest `AGENTS.md` up the tree; when the task matches
  one of the repo's advertised skills, read its `SKILL.md` first.
