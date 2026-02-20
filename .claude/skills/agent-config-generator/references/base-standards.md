# Base Development Standards

These are the core standards that MUST be included in every generated CLAUDE.md.
Adapt the project-specific sections (Stack, Structure, Commands) per repo, but
always include these standards verbatim or near-verbatim.

---

## Philosophy

- No backwards compatibility. No legacy code. Rewrite, build, test, deploy, run.
- No re-exports. Especially from shared. Shared is the main contract between services.
- No remapping data with minimal change. Reuse the same structures.
- No bloat. Every line of code must be meaningful. If it isn't, refactor something existing.
- Strict typed code. No `any`, no untyped boundaries.
- All issues are issues. There are no minor issues. There is no fixing later.
- No hardcoded values. Use env vars or solve it properly.
- No speculative features. Build what's needed now, not what might be needed later.
- No premature abstraction. Don't create utilities until you've written the same code three times. Three similar lines is better than a premature helper.
- Replace, don't deprecate. Delete the old thing. No shims, no re-exports, no `_deprecated` suffixes.
- Verify at every level. Automated guardrails first. Prefer structure-aware tools over text pattern matching.
- Finish the job. Handle edge cases you can see. Clean up what you touched. Don't invent new scope.
- Zero warnings policy. Fix every warning. If truly unfixable, add inline ignore with justification.

## Dependencies

- GitHub dependencies use git specifiers only. No `npm:`, no tarballs, no GitHub shorthand.
- Format (pnpm catalog style):
  ```yaml
  '@scope/package-name':
    specifier: git+https://github.com/Org/repo.git#branch
  ```
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
| Linting (Python) | `ruff check` | pylint, flake8 |
| Formatting (Python) | `ruff format` | black |
| Types (Python) | `ty check` | mypy, pyright |
| Package mgmt (Python) | `uv` | pip, poetry |
| Linting (JS/TS) | `oxlint` | eslint |
| Formatting (JS/TS) | `oxfmt` | prettier |
| Testing (JS/TS) | `vitest` | jest |
| File search | `fd` | find |
| Code search | `rg` (ripgrep) | grep |
| Structural code search | `ast-grep` | regex hacks |
| Shell linting | `shellcheck` | manual review |
| Shell formatting | `shfmt` | manual |
| GitHub Actions linting | `actionlint` | manual |
| GitHub Actions security | `zizmor` | manual |
| Deletion | `trash` | rm -rf |

Only include rows relevant to the target project's stack. A Python-only project
does not need JS/TS rows. A project with no GitHub Actions does not need the
Actions rows. Always include the universal rows (fd, rg, ast-grep, trash).

## Commits and PRs

- Imperative mood, 72-char subject line, one logical change per commit
- Never amend/rebase pushed commits
- Never push directly to main or dev
- Never commit secrets (use .env files, gitignored)
- PR descriptions: describe what the code does now. Plain language. No hype words.

## Code Review Order

Evaluate in order: architecture -> code quality -> tests -> performance

## Context Management

- Scope one feature/bug/investigation per session
- Prefer /clear over /compact (/clear wipes clean, /compact is lossy compression)
- Cut losses after two corrections -- if still wrong, /clear and restart
- Use checkpoints (Esc Esc or /rewind) aggressively
- Offload research to subagents (they have their own context windows)
- Write plans/specs to files, /clear, implement in fresh session
- Anything reusable goes in CLAUDE.md (survives /clear)

## Agent Teams

- Plan first, team second. Wrong decomposition costs 500k+ tokens.
- Use teams for 3+ independent work streams, multi-lens review, or competing hypotheses.
- One teammate per file/module. Never assign overlapping file ownership.
- 5-6 tasks per teammate. Define shared interfaces BEFORE teammates start.
- Lead orchestrates in delegate mode (Shift+Tab). Teammates execute.
- All agents use Opus. Lead and teammates run the same model for quality.
- Always brainstorm before spawning a team.

## Sandboxing

For sensitive projects, enable OS-level isolation:
- /sandbox: Restricts writes to current working directory (macOS Seatbelt / Linux bubblewrap)
- Devcontainer: Full filesystem isolation with only project files mounted
- Remote: Disposable cloud instances for maximum isolation

Permission deny rules (settings.json) enforce tool-level restrictions.
/sandbox enforces OS-level restrictions. Use both.

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

## GitHub Actions

- Pin all actions to full SHA hash with version comment
- Scan workflows with zizmor before committing
- Lint with actionlint
- Use Dependabot with 7-day cooldowns and grouped updates
