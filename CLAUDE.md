# Development Standards

## Project

Orthopaedic surgery practice website. Restore movement and quality of life through expert, compassionate care.

| Doc | Purpose |
|-----|---------|
| [ICP](docs/BUSINESS/ICP.md) | Patient segments and personas |
| [Product](docs/BUSINESS/PRODUCT.md) | Services and delivery model |
| [Brand](docs/DESIGN/BRAND.md) | Voice, tone, visual direction |
| [Design System](docs/DESIGN/DESIGN_SYSTEM.md) | Tokens, components, layout specs |

## Philosophy

- No backwards compatibility. No legacy code. Rewrite, build, test, deploy, run.
- No re-exports. Especially from shared. Shared is the main contract between services.
- No remapping data with minimal change. Reuse the same structures.
- No bloat. Every line of code must be meaningful. If it isn't, refactor something existing.
- Strict typed code. No `any`, no untyped boundaries.
- All issues are issues. There are no minor issues. There is no fixing later.
- No hardcoded values. Use env vars or solve it properly.
- No speculative features. Build what's needed now, not what might be needed later.
- No premature abstraction. Don't create utilities until you've written the same code three times.
- Replace, don't deprecate. Delete the old thing. No shims, no re-exports, no `_deprecated` suffixes.
- Verify at every level. Automated guardrails first. Prefer structure-aware tools over text pattern matching.
- Finish the job. Handle edge cases you can see. Clean up what you touched. Don't invent new scope.
- Zero warnings policy. Fix every warning. If truly unfixable, add inline ignore with justification.

## Dependencies

- GitHub dependencies use git specifiers only. No `npm:`, no tarballs, no GitHub shorthand.
- Always pin to a branch (`#dev`, `#main`). Never use tags, commit SHAs, or bare URLs.

## Code Quality Hard Limits

- 100 lines max per function
- Cyclomatic complexity max 8
- 5 positional parameters max
- 100-char line width
- Absolute imports only (no relative `..` paths)

## Error Handling

- Fail fast with clear, actionable messages
- Never swallow exceptions silently
- Include context: what operation, what input, suggested fix
- Use structured error types (not raw strings)

## Testing

- Test behavior, not implementation (if a refactor breaks tests but not code, the tests were wrong)
- Test edges and errors (empty inputs, boundaries, malformed data, missing files)
- Mock boundaries, not logic (only mock slow, non-deterministic, or external things)
- Verify tests catch failures (break the code, confirm the test fails)
- Property-based testing for parsers, serialization, algorithms

## CLI Tool Preferences

| Purpose | Tool | Replaces |
|---------|------|----------|
| Linting (JS/TS) | `oxlint` | eslint |
| Formatting (JS/TS) | `oxfmt` | prettier |
| Testing (JS/TS) | `vitest` | jest |
| File search | `fd` | find |
| Code search | `rg` (ripgrep) | grep |
| Structural code search | `ast-grep` | regex hacks |
| Deletion | `trash` | rm -rf |

## Commits and PRs

- Imperative mood, 72-char subject line, one logical change per commit
- Never amend/rebase pushed commits
- Never push directly to main or dev
- Never commit secrets (use .env files, gitignored)
- PR descriptions: describe what the code does now. Plain language. No hype words.

## Code Review Order

Evaluate in order: architecture -> code quality -> tests -> performance

## Completion Protocol (MANDATORY)

Before stopping, declaring work done, or saying "the task is complete":

1. `git diff --stat` — confirm all intended changes are present
2. Run tests — all must pass
3. **Build the project** — must compile with zero errors
4. **Start the application** — must boot and pass health check
5. **Verify live** — API smoke tests + browser verification (UI changes)
6. **Teardown** — stop the app, clean up test data
7. Run the `code-quality-guardian` skill on changed files
8. Fix every FAIL and P1 finding — no exceptions
9. Re-run quality guardian until verdict is PASS or REVIEW (P2/P3 only)
10. Commit only code that passes all gates

Skip steps 3-6 for: documentation-only, config-only, test-only, or CI pipeline changes.

You are NOT done if:
- Quality review returned FAIL and you haven't fixed the findings
- Tests are failing
- The project doesn't build
- You didn't run the app to verify it works
- You listed problems but didn't fix them
- You claimed issues are "pre-existing" without checking `git diff` to verify
- You deferred P1 work to a "follow-up" the user didn't request
- You skipped a success criterion from the task/design doc

If the quality guardian finds issues, fix them and re-run. Do not stop until clean.

## Extended Standards

See [agent_docs/workflow-standards.md](agent_docs/workflow-standards.md) for: Context Management, Agent Teams, Sandboxing.
