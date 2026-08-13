<!-- Reusable base. More specific AGENTS.md files, skills, and rules win on conflict. -->
# QWE instructions

Resolve the QWE layout before every QWE workflow and before writing or reviewing code:

1. Use the exact QWE coordinator layout declared by an applicable `AGENTS.md`.
2. Otherwise use the current repository root's `qwe-layout.toml` when present.
3. Otherwise use the current repository root's `.codex/qwe-layout.toml` when
   present.
4. Otherwise use `qwe-layout.toml` from Codex home (`$CODEX_HOME` when set,
   otherwise `~/.codex`).
5. If none exists, stop with a clear configuration error. Do not scan other
   workspace folders or guess among repositories.

The selected file must set `mode` to `product`, `project`, or `machine`, and
must define nonempty relative `plans`, `rules`, `logs`, and `templates` paths.
Reject an invalid mode, missing key, empty value, or absolute configured path.

Resolve every configured path relative to the directory containing the selected
`qwe-layout.toml`. Read `.codex/principles.md` below that directory when present;
otherwise read `principles.md` beside the selected layout. Read every Markdown
file under the configured `rules` directory. Ignore a rule whose stated scope
does not match the current repository or worktree.

## Optional Review Agents

The availability of `qwe-critic` and `qwe-reviewer` does not make either agent
mandatory outside an explicitly invoked QWE workflow. Codex may use them when
useful.

Whenever either agent is spawned, pass the exact resolved
`<templates>/findings-log.md` path. After it returns, append every returned
finding-log line exactly once to `<logs>/qwe-findings.md`, including when the
agent was spawned outside a QWE workflow. Create the configured logs directory
and file if needed. Append nothing when the agent returns no findings.

## Response style
- Be concise and direct. Lead with the answer, result, or recommendation. Default to SHORT — a few lines; length must be earned by the content, never by narration.
- No preambles, no walls of text, no restating my question, no summarizing what you just did or are about to do, no unrequested recaps/next-steps/offers at the end.
- Prefer short paragraphs and tight bullet lists over prose.
- Only expand when I ask, or when a change is risky or non-obvious — then only the point that matters.
- Don't narrate options you won't pursue; give a recommendation, not a survey.
- Answer exactly what I asked. If you think I should want something else, say so in one line — don't answer the different question instead.

## Precedence
The selected `principles.md` is the baseline. Where a repo's instructions, skills, rules, or conventions say otherwise, follow the repo.
