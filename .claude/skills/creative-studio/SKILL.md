---
name: creative-studio
description: "Brand-designer and copywriter brainstorm a creative direction together, then design, write copy, build, and ship. The brand-designer leads the brainstorm by asking questions to the copywriter until they converge on a direction. Use for landing pages, product pages, UI components, or any customer-facing web deliverable."
---

# Creative Studio

Brand-designer and copywriter brainstorm a creative direction together. The brand-designer leads -- proposing visual and structural ideas, asking the copywriter targeted questions about messaging, tone, and audience framing. The copywriter responds with copy perspective, challenges assumptions, and pushes the direction. They iterate until they converge on a single creative direction. Then the team designs, writes, builds, and ships.

## Input

$ARGUMENTS - Creative brief description (e.g., "landing page for our product launch", "pricing page for enterprise customers") OR `from-docs` to generate a brief autonomously from existing product/marketing/design docs.

## Workflow

```
BRIEF -> BRAINSTORM (designer <-> copywriter) -> DESIGN -> COPY -> BUILD -> CUSTOMER REVIEW -> ITERATE -> SHIP
```

### Phase 0: Prepare the Brief

**From user arguments:**

1. Parse `$ARGUMENTS` into a structured brief
2. Read project context:
   - `docs/PRODUCT/REFERENCE.md` -- product identity, flows
   - `docs/PRODUCT_MARKETING/REFERENCE.md` -- positioning, competitors
   - `docs/DESIGN/DESIGN_SYSTEM.md` -- brand tokens (if exists)
3. Write the brief to `docs/studio/<timestamp>-brief.md` following the template in [references/brief-template.md](references/brief-template.md)
4. Create workspace directory: `docs/studio/workspace/`

**From docs (autonomous mode -- when $ARGUMENTS is `from-docs`):**

1. Read all 3 reference docs above
2. Identify the most impactful missing customer-facing deliverable
3. Draft a proposed brief
4. Present the brief to the user for approval before proceeding
5. On approval, write and create workspace as above

### Phase 1: Brainstorm (Designer <-> Copywriter)

The orchestrator mediates a back-and-forth conversation between brand-designer and copywriter. The brand-designer leads, the copywriter responds. They converge on a creative direction.

**Round structure (max 4 rounds):**

1. **Designer opens.** Spawn `brand-designer` with the brainstorm-open prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md). The designer reads context, proposes 2-3 creative directions, and asks the copywriter 1-2 targeted questions about messaging approach.
   - Output: `docs/studio/workspace/brainstorm/round-1-designer.md`

2. **Copywriter responds.** Spawn `copywriter` with the brainstorm-respond prompt. The copywriter reads the designer's proposal, answers questions, pushes back where needed, and asks 1-2 questions of their own about visual or structural choices.
   - Output: `docs/studio/workspace/brainstorm/round-1-copywriter.md`

3. **Repeat.** Pass the copywriter's response back to the designer. The designer refines the direction based on the copywriter's input, resolves open questions, and either converges or asks a follow-up.

4. **Converge.** When both agents agree on a direction (or after 4 rounds), the designer writes a final creative direction document.
   - Output: `docs/studio/workspace/brainstorm/creative-direction.md`

**Convergence signals (stop brainstorming when any is true):**
- Designer's response contains no new questions and explicitly states the direction is set
- Both agents agree on the same approach for 2 consecutive rounds
- 4 rounds completed -- designer writes final direction from best consensus

**Agent types:** `brand-designer` (leads), `copywriter` (responds)
**Final output:** `docs/studio/workspace/brainstorm/creative-direction.md`

The creative direction document must contain:
- **Visual direction** -- mood, palette emphasis, typography feel, layout approach
- **Messaging direction** -- tone, hook strategy, proof structure, CTA approach
- **Page structure** -- section order and purpose (agreed by both agents)
- **Key decisions** -- what was debated and why the chosen direction won

### Phase 2: Design

Spawn 1 `brand-designer` subagent with the designer spawn prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

The designer:
- Reads the brief and the creative direction from Phase 1
- Reads `docs/DESIGN/DESIGN_SYSTEM.md` for token constraints
- Produces a markdown design specification with layout, hierarchy, components, and responsive behavior
- Creates Mermaid diagrams for page structure (use `beautiful-mermaid` skill)
- Generates visual mockups using the `nano-banana-image-gen` skill
- Uses placeholder text for copy -- does NOT write final words

**Agent type:** `brand-designer`
**Output:** `docs/studio/workspace/design-spec.md` + `docs/studio/workspace/mockups/`

### Phase 3: Copy

Spawn 1 `copywriter` subagent with the copywriter spawn prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

The copywriter:
- Reads the brief, the creative direction, and the design spec
- Writes all copy for every section defined in the design spec
- Includes headlines, body, CTAs, microcopy, social proof, navigation labels
- Follows the messaging direction established during brainstorming

**Agent type:** `copywriter`
**Output:** `docs/studio/workspace/copy.md`

### Phase 4: Build

Spawn 1 `expert-developer` subagent with the developer spawn prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

The developer:
- Reads the brief, creative direction, design spec, copy, and mockups
- Implements as production-ready code using the tech stack specified in the brief
- Uses exact copy from `copy.md` -- does not rewrite
- References design system tokens where available
- Ensures responsive, accessible, performant output
- Output must be runnable (open `index.html` or `npm start`)

**Agent type:** `expert-developer`
**Output:** `docs/studio/workspace/build/`

**Browser verification (orchestrator):** After the build completes, attempt to open it in browser using `agent-browser` skill and capture screenshots to `docs/studio/workspace/screenshots/`.

### Phase 5: Customer Review

Spawn 1 `customer` subagent with the customer review spawn prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

The customer agent:
- Reads the brief and all workspace outputs (creative direction, design spec, copy, build, screenshots)
- Evaluates using the 5-dimension framework (Visual, Copy, Flow, Conviction, Persuasion)
- Scores across all dimensions
- Provides specific, actionable feedback for the next iteration

**Agent type:** `customer`
**Output:** `docs/studio/customer-review-round-N.md`

### Phase 6: Iterate or Ship

**Check loop conditions:**

| Condition | Action |
|-----------|--------|
| Customer average score < 8 AND round < 3 | ITERATE |
| Customer average score >= 8 | SHIP (ask user to confirm) |
| Round = 3 (max iterations reached) | SHIP best result |
| User requests another iteration | ITERATE |
| User requests ship | SHIP |

**ITERATE:** Loop back to Phase 2 with customer feedback. Prepend the iteration feedback prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md) to each agent's spawn prompt. The creative direction from Phase 1 remains the foundation -- iterations refine execution, not direction.

**SHIP:**
1. Copy `workspace/build/` contents to the project's target directory
2. Spawn both quality guardians simultaneously as parallel subagents:
   - `code-quality-guardian` -- code quality, security, performance
   - `style-quality-guardian` -- design system compliance, accessibility, responsive, UX
3. Fix all FAIL and P1 findings. Re-run until PASS or REVIEW.
4. Commit and create PR using `github-cli` skill

## Artifact Workspace

```
docs/studio/
+-- <timestamp>-brief.md
+-- workspace/
|   +-- brainstorm/
|   |   +-- round-1-designer.md
|   |   +-- round-1-copywriter.md
|   |   +-- round-2-designer.md
|   |   +-- round-2-copywriter.md
|   |   +-- creative-direction.md
|   +-- design-spec.md
|   +-- mockups/
|   +-- copy.md
|   +-- build/
|   +-- screenshots/
+-- customer-review-round-1.md
+-- customer-review-round-2.md
```

## Loop Control

- **Brainstorm max rounds:** 4. After 4 rounds, designer writes final direction from best consensus.
- **Iteration max rounds:** 3. After 3 rounds, ship the best result regardless of score.
- **Auto-ship threshold:** Customer scores average 8+ across all 5 dimensions.
- **User override:** The user can force another iteration or force ship at any point during the loop check.

## Rules

- Design system check is mandatory -- if `docs/DESIGN/DESIGN_SYSTEM.md` does not exist, flag this to the user and ask whether to generate one first using the `design-system` skill
- Brand-designer leads the brainstorm -- copywriter responds, challenges, and refines
- The creative direction document is the contract between brainstorming and execution
- All agents write ONLY to the workspace directory
- Designers leave copy as placeholders -- copywriters own all words
- Developers use exact copy from `copy.md` -- no paraphrasing
- Browser verification after Phase 4 is best-effort -- proceed to customer review even if browser capture fails
- Customer agent always issues REVIEW (never PASS) -- iteration decision is based on scores and user preference
- Iterations refine execution against the established creative direction -- they do not restart the brainstorm
- Quality gates (code + style guardians) are mandatory before shipping

## References

- [references/brief-template.md](references/brief-template.md) -- template for the creative brief file
- [references/team-handoff-prompts.md](references/team-handoff-prompts.md) -- spawn prompts for each agent per phase
