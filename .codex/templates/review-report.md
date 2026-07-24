<!-- Review report format. Single source of truth for the reviewer's output — edit here, not in the agent. -->

**Verdict** — one line: `READY FOR PR` only if there are NO ✗ in the status table; otherwise `NOT READY`. (⚠ warnings don't block, but list them.)

**Status** — one row per dimension (all nine, never skip one). `✓` = pass, `⚠` = minor / non-blocking, `✗` = must fix. The Documentation row carries the docstring verdict (a missing docstring on new public API = ✗ there). Note is `—` when ✓, else a terse phrase:

| # | Dimension | Status | Note |
|---|-----------|:------:|------|
| 1 | Completeness | ✓/⚠/✗ | — |
| 2 | Correctness | ✓/⚠/✗ | — |
| 3 | Security | ✓/⚠/✗ | — |
| 4 | Regressions | ✓/⚠/✗ | — |
| 5 | Consistency | ✓/⚠/✗ | — |
| 6 | Documentation | ✓/⚠/✗ | — |
| 7 | Tests | ✓/⚠/✗ | — |
| 8 | Leftovers | ✓/⚠/✗ | — |
| 9 | Impact | ✓/⚠/✗ | — |

**Findings** — numbered, worst severity first (blocking ✗ before ⚠), so items are referenceable. Non-blocking follow-ups from the impact sweep go here marked ⚠ follow-up. "No findings." if none:

| # | Sev | Location | Problem | Fix |
|---|:---:|----------|---------|-----|
| 1 | ✗/⚠ | path:line | what's wrong | how to fix |

**Docstring audit** — every new public interface in the diff, each `✓` (has a docstring) or `✗` (missing); `none` if the diff adds no public interfaces.
