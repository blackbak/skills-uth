---
name: feature-frontend
description: "Design-first frontend feature workflow. Chains: brainstorm with design intent, frontend-design exploration, worktree, TDD, live verification with browser, style quality review, commit, PR. Use for UI components, pages, or design system work."
---

# Frontend Feature Workflow

Design-first orchestrator for frontend features. Emphasizes visual design quality, browser verification, and style review alongside code quality.

## Input

$ARGUMENTS - Feature description (e.g., "user profile page", "dashboard with charts", "onboarding flow")

## Workflow

### Step 0: Design System Check

Before any design work, verify a design system exists:

1. Read `docs/DESIGN/DESIGN_SYSTEM.md`
2. **If populated:** Use its tokens, palette, typography, spacing, and patterns as constraints for all subsequent steps. The design system is the law -- creativity lives within it.
3. **If empty or missing:** Ask the user: "No design system found. Should I generate one first using the `design-system` skill, or proceed with ad-hoc design choices?" If they choose to generate, invoke the `design-system` skill and wait for completion before continuing.

### Step 1: Design Intent

Invoke the `brainstorming` skill with the feature description.

Focus on design-specific questions:
- What is the user trying to accomplish?
- What is the visual hierarchy?
- What are the interaction states (loading, empty, error, success)?
- What devices/breakpoints must be supported?
- How does this feature use the design system tokens?

Read project docs:
- `docs/DESIGN/DESIGN_SYSTEM.md` — brand tokens, color palette, typography, patterns
- `docs/DESIGN/SCREENS.md` — screen descriptions, layouts, component usage, interaction states
- `docs/PRODUCT/PRODUCT_DOCUMENT.md` — flows, UX principles
- `docs/ARCHITECTURE/SYSTEM_ARCHITECTURE.md` — component architecture

Write design to `docs/plans/YYYY-MM-DD-<topic>-design.md`.

### Step 2: Design Exploration

Invoke the `frontend-design` skill.

Explore the design space:
- Domain-appropriate aesthetics (not generic "AI slop")
- Typography, color, spacing decisions
- Motion and interaction patterns
- Component composition strategy

Key outputs:
- Component hierarchy
- Props and state design
- CSS/styling approach (Tailwind classes, CSS modules, etc.)
- Responsive breakpoints

### Step 3: Create Worktree

Invoke the `git-worktree` skill.

```bash
BRANCH="feat/<topic>"
git worktree add -b "$BRANCH" "../$REPO.$BRANCH" "$BASE"
```

### Step 4: TDD Cycle

Invoke the `test-driven-development` skill.

Frontend-specific testing:
- **Component rendering** — does it render without errors
- **Interaction tests** — click handlers, form submission, navigation
- **State transitions** — loading → data → error flows
- **Accessibility** — keyboard navigation, ARIA attributes, screen reader
- **Edge cases** — empty data, long strings, missing images

### Step 5: Implement

Follow the design from Steps 1-2. Build components bottom-up:
1. Atoms (buttons, inputs, labels)
2. Molecules (form groups, cards, list items)
3. Organisms (forms, navigation, content sections)
4. Pages (compose organisms into full views)

### Step 6: Live Verification (Browser-Heavy)

Invoke the `live-verification` skill with emphasis on browser verification.

1. **Build** — must compile with zero errors
2. **Start** — app boots, serves the new page/component
3. **Browser verification** (MANDATORY for frontend):
   ```
   agent-browser open http://localhost:${PORT}/<route>
   agent-browser snapshot -i
   ```
   Verify for each breakpoint (mobile, tablet, desktop):
   - Page renders without JS errors
   - Visual hierarchy matches design intent
   - Interactive elements respond correctly
   - Loading/empty/error states display properly
   - Animations and transitions work
   - No layout shifts or overflow issues
4. **Accessibility check**:
   ```
   agent-browser snapshot -a    # accessibility tree
   ```
   - All interactive elements are keyboard-accessible
   - ARIA labels are present and meaningful
   - Color contrast meets WCAG AA
   - Focus order is logical
5. **Teardown**

### Step 7: Dual Quality Review (Parallel)

**Spawn both guardians simultaneously** as parallel subagents in a single message:

1. **Subagent** (`code-quality-guardian` agent) — type safety, error handling, performance, complexity, bloat
2. **Subagent** (`style-quality-guardian` agent) — design system compliance, WCAG accessibility, responsive design, CSS quality, UX patterns, component architecture

Both run in parallel. Collect verdicts from both. Fix all FAIL and P1 findings. Re-run until both reach PASS or REVIEW.

### Step 8: Sync Living Docs

Invoke the `sync-docs` skill to auto-detect affected docs and spawn owning agents. If any docs are updated, stage and commit the doc changes before proceeding.

### Step 9: Commit and PR

```bash
git add <files>
git commit -m "feat: <description>"
git push -u origin "$BRANCH"
gh pr create --base "$BASE" --title "feat: <description>" --body "..."
```

Include browser screenshots in the PR description when useful.

---

## Team Route (3+ UI components)

Invoke the `agent-team` skill — **Pattern 1: Parallel Feature Build** (frontend variant).

Follow the agent-team skill's prerequisites, rules, and setup. Use [team-patterns.md](../agent-team/references/team-patterns.md) for spawn prompt templates and [conflict-avoidance.md](../agent-team/references/conflict-avoidance.md) for file ownership.

1. **Steps 1-3** same as above (design, explore, worktree)
2. Lead enters delegate mode. Defines component contracts (props, events, shared state) and commits them
3. **Wave 1** — Spawn all `qa-developer` agents simultaneously (one per component): interaction + accessibility tests
4. **Wave 2** — Spawn all `expert-developer` agents simultaneously (one per component): builds against QA tests
5. **Step 6** (browser verification): Lead runs after all components integrate
6. **Step 7** (dual review): Both guardians spawn as parallel subagents
7. **Step 8** (sync living docs): Invoke `sync-docs` skill
8. **Step 9** (commit and PR)

---

## Checkpoint Summary

```
DESIGN SYSTEM CHECK → DESIGN INTENT → DESIGN EXPLORE → WORKTREE → TDD → IMPLEMENT → BROWSER VERIFY → DUAL REVIEW → SYNC DOCS → PR
```

## Rules

- Design system check is Step 0 — if no design system exists, flag it before proceeding
- Design exploration is mandatory — don't skip straight to code
- All visual choices must conform to `docs/DESIGN/DESIGN_SYSTEM.md` when it exists
- Browser verification is mandatory — if you didn't see it render, it doesn't work
- Both quality guardians run — code quality AND style quality
- Accessibility is not optional — WCAG AA is the minimum bar
- Test interaction states — loading, error, empty are as important as the happy path
- Responsive is not an afterthought — verify at mobile, tablet, and desktop breakpoints
