<!-- Findings log contract. Single source of truth for the findings log (`<logs>/qwe-findings.md`, `<logs>` resolved through qwe-layout.md) — edit here, not in the agents/skills. Append-only; never delete entries. -->

One line per entry, pipe-separated. Three line shapes:

Agents RETURN findings; the INVOKING SKILL is the only writer. Create the log only when findings exist.

**Critic finding** (one per returned table row):
`<date> | <repo> | critic | <log-tag> | <finding #> | <sev: high|med|low> | <category> | <terse finding>`

**Reviewer finding** (one per returned Findings row):
`<date> | <repo> | reviewer | <log-tag> | <finding #> | <✗|⚠> | <dimension> | <terse finding>`

**Verdict** (written by the orchestrating command, ONE line per pass, covering every finding # of that pass):
`<date> | <repo> | verdict | <log-tag> | 1=accepted, 2=rejected(<terse reason>), …`

Conventions:
- `<log-tag>` = pass identifier handed by the caller (`<increment-slug>-p<pass#>`, `review-p<pass#>`); `-` when none (standalone $qwe-review).
- `<finding #>` = the row number from the agent's own findings table — the verdict line joins on `log-tag` + `#`.
- `<category>` ∈ churn | duplication | placement | docstring | complexity | consistency | scope | other.
- Terse: one clause, no file dumps; the log is for pattern mining, not re-review.
- Nothing to flag = nothing to log.
