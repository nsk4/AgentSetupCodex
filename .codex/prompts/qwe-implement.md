---
description: Implement a plan. Default: all remaining increments in one run; pass "step" for only the next one. Does a hygiene pass, reviews with qwe-critic + qwe-reviewer, verifies completeness, updates docs, compacts done plan items, runs tests, reports. Never commits or stages.
argument-hint: <plan path> [step]
---

Implement from the plan at: $ARGUMENTS

**Mode** — by default implement ALL remaining unchecked (`- [ ]`) increments in this run. If the arguments include `step` (or `one`/`next`), implement only the next unchecked increment and stop.

1. **Implement** as the smallest, simplest correct diff — in plan order, each increment leaving the app working. No scope creep, no speculative abstraction, no refactoring of adjacent code. Include in the SAME diff any documentation the change makes stale (README, `docs/*.md`, public-interface docs, examples) — only what's affected, nothing gratuitous. If an increment hits a real blocker or open question, don't force it: leave it `- [ ]`, keep its detail, add a brief `⚠ blocked:` / `⚠ open:` note, and continue with the increments that don't depend on it. If the plan itself is wrong, stop and tell me.

2. **Hygiene pass — do this explicitly, it's the step that gets skipped.** Before any review, clean up your own diff:
   - **Docstrings** on every NEW public interface (exported/public module, class, function, endpoint, type) — document the contract and the *why*, not what the code says.
   - **Remove what shouldn't ship:** dead code, unused imports/exports, commented-out blocks, leftover debug prints/logging, and any TODO/FIXME you introduced.
   - **Formatting/lint:** make sure the project's formatter and linter have actually run on every touched file. The save hook normally handles this, but confirm — don't assume it fired.
   - **Consistency:** names, file placement, and patterns match the surrounding code.
   This is cleanup of what you just wrote — do not expand scope.

3. **qwe-critic loop** — iterate until it settles or you hit the cap:
   a. Run the **qwe-critic** subagent in its OWN isolated context — it pulls the diff itself (`git diff` / `git diff --staged`), so don't replay the diff into this conversation; only its findings come back. It challenges the current diff on design and minimalism.
   b. Apply the fixes that hold up.
   c. If you changed anything in (b), run qwe-critic AGAIN — a pass where you applied fixes is NEVER the last pass. Exit only on a clean confirming pass (qwe-critic comes back with nothing material), or after **3 passes**. Applying fixes is not the exit; a clean critic pass is.

4. **qwe-reviewer (full pre-PR gate)** — use the **qwe-reviewer** subagent for a FULL review of the diff: completeness (against the plan), correctness, security, regressions, consistency, documentation (incl. docstrings), and tests. Fix everything it flags; if its verdict is NOT READY, fix and re-run until it returns READY FOR PR, or after 2 reviewer passes. Its READY verdict is the bar — if it passes, the change is PR-ready.

5. **Test** the affected areas — run the project's test suite for what you touched. Fix failures before reporting.

6. **Update + compact the plan** (per increment, based on the reviewer's verdict):
   - Increment confirmed implemented, correct, and tested → mark it `- [x]` and **compact it**: collapse its sub-bullets into the checkbox line with a terse note of what landed (e.g. `- [x] Add rate limiting — limiter middleware + config, removed ad-hoc checks`).
   - Increment blocked, with an open question, or not implemented → leave it `- [ ]`, keep its detail **expanded**, and keep/add the `⚠ blocked:` / `⚠ open:` note so it's clear what remains and why.
   - Never delete increments or done notes.
   - Always leave the plan in `tmp/plans/` after this run — never archive or move it. Closing a finished plan is `/qwe-plan`'s job; here you only tick and compact it.

7. **Report — brief:**
   - Increments done (one line each) and files changed, including docs.
   - Hygiene: docstrings added, formatters run, cleanup done.
   - Anything left blocked/open, and why.
   - qwe-critic loop: iterations to settle; tests: what ran and pass/fail.
   - Decisions to sanity-check.
   - If every increment is done: say so and tell me to run `/qwe-plan <plan>` to verify and archive it (you do not archive here).

8. **Do NOT commit and do NOT stage.** Run no `git add`, no `git commit`, no branch creation. Leave every change as an unstaged working-tree modification — I will stage and commit it myself. (Use `/qwe-commit-message` when you want a message.)

9. In step mode, also propose the next unchecked increment as a checklist, without implementing it.
