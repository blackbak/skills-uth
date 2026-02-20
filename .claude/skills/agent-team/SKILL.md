---
name: agent-team
description: Coordinate multiple Claude Code sessions as a team for complex, parallelizable tasks. Use when a task has 3+ independent work streams, needs multi-perspective review, or requires parallel debugging.
---

# Agent Teams

Coordinate multiple independent Claude Code sessions that share a task list and communicate directly. The lead session orchestrates; teammates execute in their own context windows.

## When to Use

| Scenario | Approach | Why |
|----------|----------|-----|
| Single file change | Solo session | No parallelism benefit |
| 2-3 related changes | Subagents | Lower overhead, results report back |
| 3+ independent modules | **Agent team** | True parallelism, direct communication |
| Multi-perspective review | **Agent team** | Competing viewpoints surface more issues |
| Debugging unclear root cause | **Agent team** | Parallel hypothesis investigation |
| Sequential dependent steps | Solo session | Teams can't pipeline serial work |
| Same-file edits | Solo session | Merge conflicts between teammates |

## Cost Awareness

Teams cost ~4x a single session. Plan first (~10k tokens), then decide if team execution (500k+ tokens) is justified by parallelism.

**Model strategy**: All agents use Opus. Lead and teammates run the same model for maximum quality.

## Prerequisites

1. **Brainstorm first** -- design the feature/investigation before spawning a team
2. **Create worktree** -- teams operate within a single worktree branched from dev
3. **Define shared contracts** -- interfaces, types, API boundaries BEFORE teammates start

## Patterns

### Pattern 1: Parallel Feature Build

Lead decomposes a feature into independent modules. Each teammate implements one module with its own tests. Lead synthesizes, runs integration tests, creates PR.

**Structure**:
- Lead: Delegate mode (Shift+Tab). Plans, decomposes, reviews, synthesizes. Never writes code.
- Teammate per module: Implements + writes unit tests for assigned files only.
- Final: Lead runs live verification, quality review, creates PR.

**Spawn in parallel waves** — each wave is a single message with multiple Task calls:

```
Lead defines shared types/interfaces
    |
    Wave 1: Spawn ALL QA agents simultaneously
    +-> QA-A  \
    +-> QA-B   } all parallel (single message, multiple Task calls)
    +-> QA-C  /
    |
    Wave 2: Spawn ALL impl agents simultaneously
    +-> Impl-A  \
    +-> Impl-B   } all parallel (single message, multiple Task calls)
    +-> Impl-C  /
    |
    Wave 3: Lead runs sequential gates
    +-> LIVE VERIFICATION (build -> run -> API -> browser -> teardown)
    +-> QUALITY REVIEW (spawn both guardians as parallel subagents)
    +-> COMMIT + PR
```

**Live verification phase** (after all modules complete):
1. Build the full project — all modules must compile together
2. Start the app — verify it boots with all new modules integrated
3. API smoke tests — hit affected endpoints from each module
4. Browser verification — if UI changed, verify rendering and interactions
5. Integration smoke — run a user flow that exercises cross-module paths
6. Teardown — stop app, clean up

See the `live-verification` skill for detailed workflow.

**When to use**: New features spanning 3+ files/modules with clear boundaries.

**Used by**: `/feature` (team route), `/feature-frontend` (team route), `/contribute` (EXECUTE phase)

See [references/team-patterns.md](references/team-patterns.md) for spawn prompts and [references/conflict-avoidance.md](references/conflict-avoidance.md) for file ownership.

### Pattern 2: Multi-Lens Review

Three teammates review the same code simultaneously from different perspectives. Lead synthesizes findings and prioritizes fixes.

**Structure**:
- Teammate 1: `code-quality-guardian` (security, types, complexity, performance)
- Teammate 2: `style-quality-guardian` (design system, accessibility, UX)
- Teammate 3: `devops-engineer` (OWASP, CVEs, deployment impact, ops)
- Lead: Aggregates findings into P1 (blocks merge) / P2 (important) / P3 (nice-to-have), fixes all.

**When to use**: Pre-PR review of substantial changes (10+ files, cross-layer).

**Used by**: `/review`

See [references/team-patterns.md](references/team-patterns.md) for spawn prompts and synthesis process.

### Pattern 3: Competing Hypotheses

For hard-to-diagnose bugs, spawn teammates each investigating a different theory. They challenge each other via direct messaging.

**Structure**:
- Lead: Formulates 2-5 hypotheses from symptoms
- Teammate per hypothesis: Investigates, reports evidence for/against
- Teammates: Challenge each other's findings via messaging
- Lead: Evaluates surviving hypothesis, implements fix

**When to use**: Bugs where the root cause is unclear and multiple theories are plausible.

**Used by**: `/investigate-fix` (investigation phase)

See [references/team-patterns.md](references/team-patterns.md) for spawn prompts and debate structure.

## Integration with Existing Workflow

```
brainstorm -> git-worktree -> [DECISION POINT] -> LIVE VERIFY -> quality gates -> PR
                                   |
                    Simple? -> solo + TDD -> live verify -> quality gates -> PR
                    Complex? -> agent team -> live verify -> quality gates -> PR
```

Teams slot between worktree creation and quality gates. Live verification runs after all parallel implementation completes and before static quality review. The existing hooks (branch protection, TDD enforcement, auto-formatting, cortex capture) all work in team sessions -- teammates inherit CLAUDE.md, skills, and project context automatically.

## Rules

- **One teammate per file/module** -- never assign overlapping file ownership
- **5-6 tasks per teammate** -- fewer wastes coordination overhead, more risks context exhaustion
- **Delegate mode for lead** -- prevents lead from implementing instead of coordinating
- **Plan approval for risky changes** -- require teammates to plan before modifying critical paths
- **Define contracts first** -- shared types, interfaces, API boundaries before any teammate starts

See [references/conflict-avoidance.md](references/conflict-avoidance.md) for file ownership strategy.

## Setup

**Display modes**:
- In-process (default): All teammates in one terminal. Shift+Up/Down to switch.
- Split-pane: Requires tmux or iTerm2. Each teammate gets its own pane.

**Delegate mode**: Shift+Tab to toggle. Restricts lead to coordination-only tools.

**Plan approval**: Tell the lead to require plan approval for specific teammates:
```
Spawn a teammate to refactor the auth module. Require plan approval before changes.
```
