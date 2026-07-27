---
name: qwe-message-pr
description: Generate a PR description in Markdown for the current branch, following the repo's PR template if one exists (else a fitting default). Prints it in chat to copy — never creates the PR, pushes, stages, or commits.
---

# QWE PR Message

Write a pull-request description for the current branch — text only.

**Scope** = everything the branch introduces vs its base: `git diff $(git merge-base HEAD <base>)` plus current staged/unstaged/untracked changes (`git status --short`). Base = the one named in the invoking request, else the repo's default branch (`git rev-parse --abbrev-ref origin/HEAD`, fallback `main`/`master`). If the branch introduces nothing, say so and stop.

**Template** — look for a repo PR template: `.github/PULL_REQUEST_TEMPLATE.md`, `.github/pull_request_template.md`, `docs/pull_request_template.md`, or any file under `.github/PULL_REQUEST_TEMPLATE/`. If one exists, follow it EXACTLY — fill each section from the actual changes; leave a section empty or `N/A` only if it genuinely doesn't apply. If none exists, use a fitting concise default: a one-line summary, a short **What changed** (high level — no file-by-file dump), **Why**, and **Testing** if relevant.

**Style** — same spirit as my commit style: concise, high-level, what changed and why; don't enumerate files unless a template section asks for it. If the work resolves a Linear ticket (from the plan's `## Tickets`, the branch name, or the diff), include the close keyword `Closes YNT-123`; if it only advances one, `Refs YNT-123`.

Output the PR description as Markdown in a single code block so I can copy it. Do NOT create the PR, push, stage, or commit — this produces text only.
