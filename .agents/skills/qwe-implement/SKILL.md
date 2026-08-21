---
name: qwe-implement
description: Implement a plan — per increment, an isolated qwe-implementer then a qwe-critic pass, accepted fixes to a fresh implementer (max 3 cycles). Live checklist, plan updates, terse report. Never stages or commits; $qwe-review is the full gate.
---

# QWE Implement

Implement from the plan at: the invoking request

**Repo scope** — follow the plan's scope. Single-repo plan (no `## Repos`) → the current repo. Multi-repo plan (`## Repos` + `[repo]`-tagged increments) → implement each increment in its OWNING repo; cross-repo is fine when the plan spans repos and both are open. To restrict, tell me (e.g. `<repo> only`). Don't touch folders outside the plan's repos.

**Mode** — default: ALL remaining unchecked increments this run. Step mode ONLY when the invocation carries the standalone mode token `step` (or `one`/`next`) after the plan path — the word merely appearing inside the path, a plan title, or prose does NOT trigger it.

**Entry — existing working state.** If this run CONTINUES an interrupted one: find your position from the checklist's in-progress item and the plan's `## To do`/`## Done`, then redo the interrupted step — re-spawn any agent whose result never came back (partial edits on disk are valid state for the fresh spawn to continue from); don't redo confirmed-done increments. A clean checkout is NOT required. First inspect `git status --short` and the diff: changes related to the active plan or this conversation are valid working state — continue from them. Preserve unrelated changes byte-for-byte and keep new work away from them; don't stop merely because the tree is dirty. Stop and ask ONLY if unrelated changes overlap the requested work enough that continuing risks overwriting or misattributing them.

**Orchestration — agents are isolated leaf workers; you (the skill context) coordinate. The implementer and critic never share context; their shared artifact is the working tree, and findings you relay are the intentional handoff.**

1. **Checklist** — seed the session to-do list: one item per increment you'll do (multi-repo: prefix `[repo]`), plus a final "update plan + report". Mark in-progress/done as you go; update after EVERY item.

2. **Per increment**, in plan order, skipping anything I excluded — with DYNAMIC dependency handling (this is the canonical algorithm):
   - An increment `⛔ blocked` on an INTERNAL prerequisite (an increment of this plan): skip it for now. After EVERY increment finishes (success or failure), re-evaluate all remaining blocked increments — if an increment's prerequisites are ALL under `## Done`, remove its blocker and implement it in THIS run. If a prerequisite failed or is itself still blocked, its dependents stay blocked.
   - An increment blocked EXTERNALLY (my input, outside work): stays blocked no matter what else completes — only I unblock it.
   - Continue until every increment is done or nothing further can be unblocked.
   **Spawn economy for the implementer:** spawning per increment pays on MULTI-increment runs (each increment's reads/edits stay out of this long-running context; the context package keeps spawns cheap). On a SINGLE-increment run (`step` mode, or a plan with one increment) in an otherwise fresh session, implement INLINE instead — read `<agents>/qwe-implementer.toml` and apply its rules yourself (smallest diff, hygiene incl. docstring enumeration, scope check, tests; Hard rule 1 unchanged — no git writes). TRIVIAL increments (single file, no logic — styling tweak, copy change, in-file rename) are always inline.
   **The critic is ALWAYS spawned** — the writer and the judge of a change never share a context: when you implemented inline, a fresh critic is what keeps the review honest.
   a. Spawn **qwe-implementer** in its own context with a CONTEXT PACKAGE so it edits instead of searching: the increment with its full sub-bullets (touches / mirror / involves / delete) as concrete paths, the files changed by earlier increments this run, any conventions that bear on it, and the working-state note (it doesn't run git — from your entry inspection, tell it what's already changed to build on or leave alone). It should not need to rediscover the codebase. Receive its terse result.
   b. Spawn **qwe-critic** in a separate context with scope `increment <name>` and a log tag `<increment-slug>-p<pass#>` (it inspects the cumulative working tree itself, including untracked files — don't paste diffs).
   c. Evaluate its findings HERE: accept what holds up, reject with reason what doesn't — reject anything that would merely reverse a deliberate simplification or undo a requested change; on a critic↔reviewer conflict, STOP and flag it rather than ping-ponging fixes. Then LOG the pass to `<logs>/qwe-findings.md`: append the critic's returned findings (one line each) plus ONE verdict line, per `<templates>/findings-log.md`. Create the folder/file only when there ARE findings — no findings, nothing written.
   d. Accepted findings → hand as an explicit fix list (exact `path:line — change`) to a FRESH **qwe-implementer** invocation — zero rediscovery: it goes straight to the named locations.
   e. Repeat b–d until the critic returns clean, or after at most **3 critic/fix cycles**.
   f. A genuinely blocked increment: tag it `⛔ blocked: <reason>` in the plan and move on — never stall the run. Don't stop mid-run to ask me questions: take the safest default and record it under `## Assumptions`, or tag `⛔ blocked` — questions belong in the final report (STATUS `NEEDS INPUT`).

3. **Update the plan** (canonical file — never a copy): move each finished increment from `## To do` to `## Done` as `- [x] <increment — terse note>`, dropping its sub-bullets. Blocked ones stay under `## To do` tagged. Never delete Done entries; never archive/move the plan (that's `$qwe-plan`'s job).

4. **Report — terse, status first:** **STATUS** (`DONE`/`PARTIAL`/`NEEDS INPUT`/`BLOCKED`); **Done** one line each; **Left/blocked** + why — for dependency chains name the ROOT cause (e.g. `B, C blocked ← A failed`), or `none`; in step mode also what became runnable next; **Sanity-check** or `none`. End with: review on your own terms — `$qwe-review` (uncommitted), `$qwe-review branch` (whole branch), `$qwe-review short` (triage).

5. **Git safety.** Never stage, commit, push, or create checkpoint commits; no destructive git operations (`git reset`/`restore`/`checkout --`/`clean`/`stash`/`revert`). Everything stays as working-tree changes for me to review and commit.

6. In step mode, also propose the next unchecked increment as a checklist item, without implementing it.
