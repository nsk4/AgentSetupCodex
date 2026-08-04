<!-- User-level base. Repo AGENTS.md, skills, and rules load after this and win on any conflict. -->
# Global instructions

Read `~/.codex/principles.md` before writing or reviewing code.
Read every Markdown file under `~/.codex/rules/`. These files contain user-specific repository, environment, and workflow context.
When a rule file declares that it applies only to particular repository or worktree paths, ignore that file unless the current path matches.

## Response style
- Be concise and direct. Lead with the answer, result, or recommendation.
- No long preambles, no walls of text, no restating the question back to me.
- Prefer short paragraphs and tight bullet lists over prose.
- Only expand into detail when I ask, or when a change is risky or non-obvious — then keep it to the point that matters.
- Don't narrate options you won't pursue; give a recommendation, not a survey.

## Precedence
principles.md is the baseline. Where a repo's skills, rules, or conventions say otherwise, follow the repo.
