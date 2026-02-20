# Team Patterns: Detailed Walkthroughs

## Pattern 1: Parallel Feature Build

### Example Spawn Prompt

```
Create an agent team for implementing the payment processing module.

Team structure:
- Lead (me): Orchestration only, delegate mode
- Teammate "types": Define shared TypeScript interfaces in src/shared/payment.types.ts
- Teammate "api": Implement payment API endpoints in src/api/payments/
- Teammate "processor": Implement payment processor service in src/services/payment/
- Teammate "tests": Write integration tests in tests/payment/

All teammates use Opus.

Task dependencies:
1. "types" defines interfaces first (all others blocked until complete)
2. "api" and "processor" work in parallel after types are defined
3. "tests" writes integration tests after api and processor complete

Require plan approval for "processor" (handles money, high risk).
```

### Task Granularity

Break each module into 5-6 tasks:
```
Teammate "api" tasks:
1. Define route handlers for POST /payments
2. Define route handlers for GET /payments/:id
3. Add input validation middleware
4. Add error response formatting
5. Write unit tests for each handler
```

Each task produces a clear deliverable. The teammate can self-claim the next task when one finishes.

### Model Assignment

| Role | Model | Rationale |
|------|-------|-----------|
| Lead | Opus | Best judgment for decomposition and synthesis |
| Type definitions | Opus | Same quality bar as lead |
| Implementation | Opus | Full reasoning for complex logic |
| Integration tests | Opus | Needs to understand cross-module contracts |

### When Lead Should Implement

Delegate mode is recommended but not absolute. The lead should step in when:
- A cross-cutting concern emerges that spans multiple teammates' domains
- Integration glue code needs context from multiple modules
- A teammate gets stuck and the lead has the full picture

Toggle delegate mode off (Shift+Tab), make the change, toggle back on.

---

## Pattern 2: Multi-Lens Review

### Example Spawn Prompt

```
Create an agent team to review the changes on this branch before PR.

Team structure:
- Lead (me): Synthesize findings, fix issues
- Teammate "quality": Review as code-quality-guardian. Focus on security (OWASP), type safety, complexity, performance. Report findings with P1/P2/P3 severity.
- Teammate "style": Review as style-quality-guardian. Focus on design system compliance, accessibility (WCAG), responsive design, UX. Report findings with P1/P2/P3 severity.
- Teammate "security": Deep security review. Check dependencies for CVEs, review auth flows, check for injection vectors, validate input sanitization. Report findings with P1/P2/P3 severity.

All teammates use Opus.
All teammates: report only, do NOT fix. I will fix based on synthesized priorities.
```

### Synthesis Process

After all three reviewers report:

1. Lead collects all findings
2. Deduplicates (e.g., both quality and security flag the same SQL injection)
3. Assigns final priority:
   - **P1**: Security vulnerabilities, broken functionality, accessibility failures -> fix before PR
   - **P2**: Performance issues, missing tests, design system violations -> fix before PR
   - **P3**: Code style, minor UX improvements, optional refactoring -> fix or document as follow-up
4. Lead fixes P1 and P2 items
5. Lead creates PR with P3 items listed in description

---

## Pattern 3: Competing Hypotheses

### Example Spawn Prompt

```
Create an agent team to debug the intermittent 502 errors in production.

Hypotheses to investigate:
1. Memory leak in the WebSocket connection pool
2. Race condition in the session middleware
3. Upstream service timeout not handled correctly
4. Database connection pool exhaustion under load

Team structure:
- Lead (me): Evaluate evidence, implement fix
- Teammate "memory": Investigate hypothesis 1. Check connection pool lifecycle, look for unclosed connections, review memory profiles.
- Teammate "race": Investigate hypothesis 2. Review middleware ordering, check for shared mutable state, trace concurrent request paths.
- Teammate "timeout": Investigate hypothesis 3. Check timeout configurations, review error handling in HTTP clients, look for missing retry logic.
- Teammate "db": Investigate hypothesis 4. Check pool size config, review connection release patterns, look for long-running queries.

All teammates use Opus.
Teammates MUST challenge each other's theories via messaging. If you find evidence that contradicts another teammate's hypothesis, message them directly.
```

### Debate Structure

The adversarial structure is the key mechanism:
- Sequential investigation anchors on the first plausible explanation
- Parallel investigators with explicit instruction to challenge each other produce the theory that survives scrutiny
- The surviving hypothesis is far more likely to be the actual root cause

### Convergence

Lead watches for:
- Two or more teammates converging on the same root cause from different angles (strong signal)
- One teammate finding evidence that eliminates other hypotheses
- A teammate requesting help from another to test a specific theory

When consensus emerges, lead implements the fix and assigns verification tasks.
