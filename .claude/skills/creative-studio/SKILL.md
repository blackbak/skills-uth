---
name: creative-studio
description: "Orchestrates 3 parallel creative teams (brand-designer + copywriter + expert-developer) competing on the same brief, with a customer agent reviewing all results and picking a winner for iterative refinement. This skill should be used when building landing pages, product pages, UI components, or any customer-facing web deliverable where creative exploration and multi-angle competition produce better outcomes than a single linear pass."
---

# Creative Studio

Orchestrate 3 parallel creative teams competing on the same brief. Each team consists of a brand-designer, copywriter, and expert-developer working a different creative angle. A customer agent reviews all 3 outputs, picks the winner, and the winning team iterates until the customer approves.

## Input

$ARGUMENTS - Creative brief description (e.g., "landing page for our product launch", "pricing page for enterprise customers") OR `from-docs` to generate a brief autonomously from existing product/marketing/design docs.

## Workflow

```
BRIEF -> 3 PARALLEL TEAMS -> CUSTOMER REVIEW -> PICK WINNER -> ITERATE -> SHIP
```

### Phase 0: Prepare the Brief

**From user arguments:**

1. Parse `$ARGUMENTS` into a structured brief
2. Read project context:
   - `docs/PRODUCT/REFERENCE.md` -- product identity, flows
   - `docs/PRODUCT_MARKETING/REFERENCE.md` -- positioning, competitors
   - `docs/DESIGN/DESIGN_SYSTEM.md` -- brand tokens (if exists)
3. Select creative angles from [references/creative-angles.md](references/creative-angles.md) -- choose the set matching the brief's category, or generate custom angles
4. Write the brief to `docs/studio/<timestamp>-brief.md` following the template in [references/brief-template.md](references/brief-template.md)
5. Create workspace directories: `docs/studio/team-a/`, `docs/studio/team-b/`, `docs/studio/team-c/`

**From docs (autonomous mode -- when $ARGUMENTS is `from-docs`):**

1. Read all 3 reference docs above
2. Identify the most impactful missing customer-facing deliverable
3. Draft a proposed brief
4. Present the brief to the user for approval before proceeding
5. On approval, write and create workspace as above

### Phase 1: Design (3 Teams in Parallel)

Spawn 3 `brand-designer` subagents simultaneously in a single message with 3 Task calls. Use the designer spawn prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

Each designer:
- Reads the brief and their assigned creative angle
- Reads `docs/DESIGN/DESIGN_SYSTEM.md` for token constraints
- Produces a markdown design specification with layout, hierarchy, components, and responsive behavior
- Creates Mermaid diagrams for page structure (use `beautiful-mermaid` skill)
- Generates visual mockups using the `nano-banana-image-gen` skill
- Writes all output to their team directory (`docs/studio/team-{a,b,c}/`)
- Uses placeholder text for copy -- does NOT write final words

**Agent type:** `brand-designer`
**Output per team:** `design-spec.md` + `mockups/` directory

### Phase 2: Copy (3 Teams in Parallel)

Spawn 3 `copywriter` subagents simultaneously in a single message with 3 Task calls. Use the copywriter spawn prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

Each copywriter:
- Reads the brief, their team's design spec, and mockups
- Writes all copy for every section defined in the design spec
- Includes headlines, body, CTAs, microcopy, social proof, navigation labels
- Follows the creative angle: bold = aggressive, minimal = precise, unconventional = surprising

**Agent type:** `copywriter`
**Output per team:** `copy.md`

### Phase 3: Build (3 Teams in Parallel)

Spawn 3 `expert-developer` subagents simultaneously in a single message with 3 Task calls. Use the developer spawn prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

Each developer:
- Reads the brief, design spec, copy, and mockups
- Implements as production-ready code using the tech stack specified in the brief
- Uses exact copy from `copy.md` -- does not rewrite
- References design system tokens where available
- Ensures responsive, accessible, performant output
- Output must be runnable (open `index.html` or `npm start`)

**Agent type:** `expert-developer`
**Output per team:** `build/` directory with implementation files

**Browser verification (orchestrator):** After all 3 builds complete, attempt to open each build in browser using `agent-browser` skill and capture screenshots to `docs/studio/team-{a,b,c}/screenshots/`.

### Phase 4: Customer Review

Spawn 1 `customer` subagent. Use the customer review spawn prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

The customer agent:
- Reads the brief and all 3 team outputs (specs, copy, builds, screenshots)
- Evaluates each team using the 5-dimension framework (Visual, Copy, Flow, Conviction, Persuasion)
- Scores each team independently
- Picks a winner with rationale
- Provides specific, actionable feedback for the winning team's next iteration

**Agent type:** `customer`
**Output:** `docs/studio/customer-review-round-N.md`

### Phase 5: Iterate or Ship

**Check loop conditions:**

| Condition | Action |
|-----------|--------|
| Customer average score < 8 AND round < 3 | ITERATE winning team |
| Customer average score >= 8 | SHIP (ask user to confirm) |
| Round = 3 (max iterations reached) | SHIP best result |
| User requests another iteration | ITERATE |
| User requests ship | SHIP |

**ITERATE:** Loop back to Phase 1 with ONLY the winning team. Prepend the iteration feedback prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md) to each agent's spawn prompt. Phases 1-4 repeat as single-team (1 designer, 1 copywriter, 1 developer, 1 customer review).

**SHIP:**
1. Copy winning team's `build/` contents to the project's target directory
2. Spawn both quality guardians simultaneously as parallel subagents:
   - `code-quality-guardian` -- code quality, security, performance
   - `style-quality-guardian` -- design system compliance, accessibility, responsive, UX
3. Fix all FAIL and P1 findings. Re-run until PASS or REVIEW.
4. Commit and create PR using `github-cli` skill

## Artifact Workspace

```
docs/studio/
+-- <timestamp>-brief.md
+-- team-a/
|   +-- design-spec.md
|   +-- mockups/
|   +-- copy.md
|   +-- build/
|   +-- screenshots/
+-- team-b/
|   +-- (same structure)
+-- team-c/
|   +-- (same structure)
+-- customer-review-round-1.md
+-- customer-review-round-2.md
+-- winner/
```

## Loop Control

- **Max iterations:** 3. After 3 rounds, ship the best result regardless of score.
- **Auto-ship threshold:** Customer scores average 8+ across all 5 dimensions.
- **User override:** The user can force another iteration or force ship at any point during the loop check.

## Rules

- Design system check is mandatory -- if `docs/DESIGN/DESIGN_SYSTEM.md` does not exist, flag this to the user and ask whether to generate one first using the `design-system` skill
- All 3 teams get the same brief -- angles are the only differentiator
- Each agent writes ONLY to their team directory -- no cross-team file modification
- Designers leave copy as placeholders -- copywriters own all words
- Developers use exact copy from `copy.md` -- no paraphrasing
- Browser verification after Phase 3 is best-effort -- proceed to customer review even if browser capture fails
- Customer agent always issues REVIEW (never PASS) -- iteration decision is based on scores and user preference
- After round 1, only the winning team iterates -- losing teams are done
- Quality gates (code + style guardians) are mandatory before shipping

## References

- [references/creative-angles.md](references/creative-angles.md) -- default angle sets and custom angle generation
- [references/brief-template.md](references/brief-template.md) -- template for the creative brief file
- [references/team-handoff-prompts.md](references/team-handoff-prompts.md) -- spawn prompts for each agent per phase
