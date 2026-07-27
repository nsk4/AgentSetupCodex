---
name: qwe-implement
description: Implement a plan — per increment, an isolated qwe-implementer then a qwe-critic pass, accepted fixes to a fresh implementer (max 3 cycles). Live checklist, plan updates, terse report. Never stages or commits; `$qwe-review` is the full gate.
---

# QWE Implement

Implement from the plan named in the invoking request.

**Repo scope** — follow the plan's scope. Single-repo plan (`## Repos` is `None`) → the current repo. Multi-repo plan (`## Repos` + `[repo]`-tagged increments) → implement each increment in its OWNING repo; cross-repo is fine when the plan spans repos and both are open. To restrict, the invoking request names the repo (e.g. `<repo> only`). Don't touch folders outside the plan's repos.

**Mode** — default: ALL remaining unchecked increments this run. `step` (or `one`/`next`) in the invoking request: only the next one.

**Entry — existing working state.** A clean checkout is NOT required. First inspect `git status --short` and the diff: changes related to the active plan or this conversation are valid working state — continue from them. Preserve unrelated changes byte-for-byte and keep new work away from them; don't stop merely because the tree is dirty. Stop and ask ONLY if unrelated changes overlap the requested work enough that continuing risks overwriting or misattributing them.

**Orchestration — agents are isolated leaf workers; you (the skill context) coordinate. The implementer and critic never share context; their shared artifact is the working tree, and findings you relay are the intentional handoff.**

1. **Checklist** — seed the session to-do list: one item per increment you'll do (multi-repo: prefix `[repo]`), plus a final "update plan + report". Mark in-progress/done as you go; update after EVERY item.

2. **Per increment** (skip `⛔ blocked` ones and anything I excluded):
   a. Spawn **qwe-implementer** in its own context with the increment, the plan context it needs, and any relevant working-state note (it doesn't run git — from your entry inspection, tell it what's already changed to build on or leave alone). Receive its terse result.
   b. Spawn **qwe-critic** in a separate context with scope `increment <name>` (it inspects the cumulative working tree itself, including untracked files — don't paste diffs).
   c. Evaluate its findings HERE: accept what holds up, reject with reason what doesn't.
   d. Accepted findings → hand as an explicit fix list to a FRESH **qwe-implementer** invocation.
   e. Repeat b–d until the critic returns clean, or after at most **3 critic/fix cycles**.
   f. A genuinely blocked increment: tag it `⛔ blocked: <reason>` in the plan and move on — never stall the run.

3. **Update the plan** (canonical file — never a copy): move each finished increment from `## To do` to `## Done` as `- [x] <increment — terse note>`, dropping its sub-bullets. Blocked ones stay under `## To do` tagged. Never delete Done entries; never archive/move the plan (that's `$qwe-plan`'s job).

4. **Report — terse, status first:** **STATUS** (`DONE`/`PARTIAL`/`NEEDS INPUT`/`BLOCKED`); **Done** one line each; **Left/blocked** + why, or `none`; **Sanity-check** or `none`. End with: review on your own terms — `$qwe-review` (uncommitted), `$qwe-review branch` (whole branch), `$qwe-review short` (triage).

5. **Git safety.** Never stage, commit, push, or create checkpoint commits; no destructive git operations (`git reset`/`restore`/`checkout --`/`clean`/`stash`/`revert`). Everything stays as working-tree changes for me to review and commit.

6. In step mode, also propose the next unchecked increment as a checklist item, without implementing it.
