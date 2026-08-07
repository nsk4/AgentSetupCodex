<!-- Findings log contract. Single source of truth for ~/.codex/logs/qwe-findings.md — edit here, not in the agents/skills. Append-only; never delete entries. -->

One line per entry, pipe-separated. Three line shapes:

**Critic finding** (returned by qwe-critic, one per table row):
`<date> | <repo> | critic | <log-tag> | <finding #> | <sev: high|med|low> | <category> | <terse finding>`

**Reviewer finding** (returned by qwe-reviewer, one per Findings row):
`<date> | <repo> | reviewer | <log-tag> | <finding #> | <✗|⚠> | <dimension> | <terse finding>`

**Verdict** (written by the orchestrating skill, ONE line per pass, covering every finding # of that pass):
`<date> | <repo> | verdict | <log-tag> | 1=accepted, 2=rejected(<terse reason>), …`

Conventions:
- `<log-tag>` = pass identifier handed by the caller (`<increment-slug>-p<pass#>`, `review-p<pass#>`); `-` when none (standalone `$qwe-review`).
- `<finding #>` = the row number from the agent's own findings table — the verdict line joins on `log-tag` + `#`.
- `<category>` ∈ churn | duplication | placement | docstring | complexity | consistency | scope | other.
- Terse: one clause, no file dumps; the log is for pattern mining, not re-review.
- Nothing to flag = nothing to log.
