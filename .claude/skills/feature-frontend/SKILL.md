---
name: feature-frontend
description: "Frontend feature workflow. Brainstorm design intent, then implement and ship. Use for UI components, pages, or design system work."
---

# Frontend Feature Workflow

Orchestrator for frontend features. Brainstorm the design, build it, ship it.

## Input

$ARGUMENTS - Feature description (e.g., "user profile page", "dashboard with charts", "onboarding flow")

## Workflow

### Step 0: Design System Check

Before any design work, verify a design system exists:

1. Read `docs/DESIGN/DESIGN_SYSTEM.md`
2. **If populated:** Use its tokens, palette, typography, spacing, and patterns as constraints for all subsequent steps. The design system is the law -- creativity lives within it.
3. **If empty or missing:** Ask the user: "No design system found. Should I generate one first using the `design-system` skill, or proceed with ad-hoc design choices?"

### Step 1: Brainstorm

Invoke the `brainstorming` skill with the feature description.

Focus on:
- What is the user trying to accomplish?
- What is the visual hierarchy?
- What are the interaction states (loading, empty, error, success)?
- What devices/breakpoints must be supported?
- How does this feature use the design system tokens?

Read project docs:
- `docs/DESIGN/DESIGN_SYSTEM.md` -- brand tokens, color palette, typography, patterns
- `docs/DESIGN/SCREENS.md` -- screen descriptions, layouts, component usage
- `docs/PRODUCT/PRODUCT_DOCUMENT.md` -- flows, UX principles

Write design to `docs/plans/YYYY-MM-DD-<topic>-design.md`.

### Step 2: Implement

Build the feature following the brainstorm output. Work bottom-up:
1. Atoms (buttons, inputs, labels)
2. Molecules (form groups, cards, list items)
3. Organisms (forms, navigation, content sections)
4. Pages (compose organisms into full views)

All visual choices must conform to `docs/DESIGN/DESIGN_SYSTEM.md` when it exists.

### Step 3: Commit and PR

```bash
BRANCH="feat/<topic>"
git checkout -b "$BRANCH"
git add <files>
git commit -m "feat: <description>"
git push -u origin "$BRANCH"
gh pr create --base "$BASE" --title "feat: <description>" --body "..."
```

---

## Checkpoint Summary

```
DESIGN SYSTEM CHECK -> BRAINSTORM -> IMPLEMENT -> PR
```

## Rules

- Design system check is Step 0 -- if no design system exists, flag it before proceeding
- Brainstorm is mandatory -- don't skip straight to code
- All visual choices must conform to `docs/DESIGN/DESIGN_SYSTEM.md` when it exists
- Test interaction states -- loading, error, empty are as important as the happy path
- Responsive is not an afterthought -- verify at mobile, tablet, and desktop breakpoints
