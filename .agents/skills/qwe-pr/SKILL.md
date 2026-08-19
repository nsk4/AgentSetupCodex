---
name: qwe-pr
description: Open a pull request — generates the title + changelog body (qwe-message pr style) and creates the PR via gh CLI or a GitHub MCP. Pushing the source branch is this skill's scoped exception; it never commits.
---

# QWE PR

Open a PR. From the invoking request: optional repo label (default: current repo), the TARGET branch, and optionally the SOURCE branch (default: the repo's current branch). Missing target → print usage and stop.

1. **Pre-checks (in that repo):** source branch has commits ahead of target (`git log <target>..<source>`) — none → say so and stop. Uncommitted changes present → NOTE that they won't be in the PR (commits only) and continue; never commit them.
2. **Message** — produce title + body exactly as `../qwe-message/SKILL.md` PR mode would for this repo and base = target branch (read and follow it; changelog style, repo template if present, ticket refs).
3. **Push** — the source branch must be on the remote: `git push -u <remote> <source>` if not pushed/behind. This push is THIS skill's scoped exception to the no-push rule (I invoked it; that's the authorization). Never force-push; a diverged remote → STOP and report.
4. **Create** — via `gh pr create` (if the gh CLI is available/authenticated) or a connected GitHub MCP, with the generated title/body, base = target, head = source. Neither available → output the ready title/body and say PR creation needs gh or a GitHub MCP. Create as a normal (non-draft) PR unless I say draft.
5. **Report:** repo · source → target · PR URL · one-line title. Never merge.
