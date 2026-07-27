<!-- Plan format. Single source of truth for plan structure — edit here, not in the agents. ALL sections below are ALWAYS present, in this order; write `None` in any that don't apply — never omit a section. -->

# Plan: <feature>

## Repos
<just the repo labels, e.g. `frontend, backend` — or `None` for the current repo only. No descriptions of what goes where (the increments' `[repo]` tags carry that); add a note ONLY when it genuinely matters, e.g. `backend (~90% of the work)` or a niche caveat>

## Tickets
<ticket identifiers this plan addresses (e.g. Linear `YNT-123`); write `None` if none>

## Needs your input
- <a genuinely blocking decision only the human can make — a real fork, not a defaultable detail>
(write `None` if there are none)

## Assumptions
- <a decision made without asking, with the default used — listed so it can be vetoed>
(write `None` if there are none)

## To do
- [ ] <increment — the smallest step that leaves the app working>
  - touches: <modules/folders>
  - mirror: <closest existing code this should follow (pattern + file), or `new pattern`>
  - involves: <key types/interfaces, data or schema changes, assets>
  - delete: <what this step removes, or `nothing`>
- [ ] <increment> ⛔ blocked: <exactly what must land first>
- [ ] <increment> ✎ polish

## Done
- [x] <completed increment — one terse line, filled by /prompts:qwe-implement>

## Out of scope
- <what is deliberately NOT being done>

<!-- Tag legend: untagged = ready now · `⛔ blocked: <reason>` = can't start until something outside this step lands (input / decision / other side) · `✎ polish` = minor, non-blocking. Multi-repo: ONE canonical plan file (never per-repo copies); list the repos in `## Repos`, give every increment exactly one owning repo prefix (`- [ ] [<repo>] …`), and order increments so dependencies are explicit (`⛔ blocked:` naming what it waits on). -->
