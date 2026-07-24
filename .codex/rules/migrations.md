# DB migrations — defer during implementation

When implementing a feature (especially in a worktree), do NOT create or apply database migrations by default — assume the target branch runs against a different DB state, so migrations are handled separately.

If a migration is genuinely needed for tests to pass, don't apply it silently: leave it out and raise it at the end as a deferred item / open question. Create or apply one only when I explicitly ask.
