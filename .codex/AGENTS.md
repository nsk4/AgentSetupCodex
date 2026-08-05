<!-- User-level base. Repo AGENTS.md, skills, and rules load after this and win on any conflict. -->
# Global instructions

Read `~/.codex/principles.md` before writing or reviewing code.
Read every Markdown file under `~/.codex/rules/`. These files contain user-specific repository, environment, and workflow context.
When a rule file declares that it applies only to particular repository or worktree paths, ignore that file unless the current path matches.

## Response style
- Be concise and direct. Lead with the answer, result, or recommendation. Default to SHORT — a few lines; length must be earned by the content, never by narration.
- No preambles, no walls of text, no restating my question, no summarizing what you just did or are about to do, no unrequested recaps/next-steps/offers at the end.
- Prefer short paragraphs and tight bullet lists over prose.
- Only expand when I ask, or when a change is risky or non-obvious — then only the point that matters.
- Don't narrate options you won't pursue; give a recommendation, not a survey.
- Answer exactly what I asked. If you think I should want something else, say so in one line — don't answer the different question instead.

## Precedence
principles.md is the baseline. Where a repo's skills, rules, or conventions say otherwise, follow the repo.
