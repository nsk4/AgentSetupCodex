# DB migrations — create, don't apply

Migrations must never STALL development and are NEVER a plan blocker: if the work needs a schema change, write the migration file as part of the increment like any other code and keep implementing. Never tag plan items `⛔ blocked` over migrations — generating one is normal work; only APPLYING it is deferred.

What's deferred is APPLYING it: never run migrations against any database by default (assume the target branch runs on a different DB state) — apply only when I explicitly ask. If unapplied migrations leave DB-dependent tests failing or unrunnable, don't force them: report that clearly at the end (which migration, what it blocks) instead of applying.
