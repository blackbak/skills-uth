# Team Handoff Prompts

Spawn prompts for each agent role per phase. Customize the bracketed placeholders before spawning.

## Phase 1: Brainstorm

### Designer Brainstorm Open (Round 1)

```
Read the creative brief at [BRIEF_PATH].

Load context:
1. docs/DESIGN/DESIGN_SYSTEM.md (if it exists) -- brand tokens, visual language
2. docs/PRODUCT/REFERENCE.md -- product identity
3. docs/PRODUCT_MARKETING/REFERENCE.md -- positioning, audience

You are starting a brainstorm with a copywriter to find the right creative direction for this deliverable. You lead.

Your task:
1. Analyze the brief, audience, and brand constraints
2. Propose 2-3 creative directions. For each direction, describe:
   - Visual approach (mood, palette emphasis, layout style, typography feel)
   - Page structure (section order and purpose)
   - What makes this direction distinctive
3. State which direction you recommend and why
4. Ask the copywriter 1-2 targeted questions:
   - What messaging angle fits best for this audience?
   - How aggressive or restrained should the tone be?
   - What's the single most important thing the copy needs to accomplish?
   - (Choose questions relevant to THIS brief -- don't ask all of these)

Keep it concise. No more than 500 words total. This is a conversation, not a presentation.

Write output to [WORKSPACE]/brainstorm/round-[N]-designer.md
```

### Copywriter Brainstorm Response

```
Read the creative brief at [BRIEF_PATH].
Read the designer's proposal at [WORKSPACE]/brainstorm/round-[N]-designer.md.
[If round > 1: Read the full brainstorm history in [WORKSPACE]/brainstorm/ to understand the conversation so far.]

Load context:
1. docs/PRODUCT/REFERENCE.md -- product identity
2. docs/PRODUCT_MARKETING/REFERENCE.md -- positioning, audience
3. docs/DESIGN/REFERENCE.md -- brand voice, tone

The designer has proposed creative directions and asked you questions. Respond as a collaborator, not a service provider.

Your task:
1. Answer the designer's questions directly
2. React to the proposed directions from a copy perspective:
   - Which direction gives copy the best platform to persuade?
   - Which direction risks undermining the message?
   - What messaging opportunities does each direction create or close?
3. Push back where needed -- if a visual choice conflicts with messaging goals, say so
4. Ask the designer 1-2 questions of your own:
   - How does this layout handle the proof section? (if relevant)
   - Is there room for a secondary narrative or is this single-track?
   - Does the visual hierarchy support the CTA progression I need?
   - (Choose questions relevant to THIS conversation -- don't ask all of these)

Keep it concise. No more than 500 words total.

Write output to [WORKSPACE]/brainstorm/round-[N]-copywriter.md
```

### Designer Brainstorm Follow-up (Round 2+)

```
Read the creative brief at [BRIEF_PATH].
Read the full brainstorm history in [WORKSPACE]/brainstorm/ to understand the conversation so far.

The copywriter has responded to your proposal. Continue the conversation.

Your task:
1. Answer the copywriter's questions directly
2. Refine your direction based on the copywriter's input
3. Either:
   a. CONVERGE: If you have enough alignment, state the final direction clearly and write the creative direction document (see format below)
   b. CONTINUE: If there are unresolved tensions, address them and ask 1 follow-up question

If converging, write the creative direction document to [WORKSPACE]/brainstorm/creative-direction.md:

## Creative Direction: [Name]

### Visual Direction
[Mood, palette emphasis, typography feel, layout approach, responsive strategy]

### Messaging Direction
[Tone, hook strategy, proof structure, CTA approach, audience framing]

### Page Structure
[Ordered list of sections with purpose -- agreed by both designer and copywriter]

### Key Decisions
[What was debated and why the chosen direction won -- 3-5 bullet points]

If not converging, write to [WORKSPACE]/brainstorm/round-[N]-designer.md
Keep follow-ups under 300 words. Drive toward convergence.
```

## Phase 2: Designer Spawn Prompt

```
Read the creative brief at [BRIEF_PATH].
Read the creative direction at [WORKSPACE]/brainstorm/creative-direction.md.

Your task:
1. Read the design system at docs/DESIGN/DESIGN_SYSTEM.md (if it exists). Use its tokens as constraints.
2. Read docs/PRODUCT/REFERENCE.md and docs/PRODUCT_MARKETING/REFERENCE.md for product context.
3. Create a design specification for [DELIVERABLE_TYPE] following the creative direction.
4. Write the spec to [WORKSPACE]/design-spec.md with:
   - Page structure (sections, hierarchy, layout grid) -- must match the structure agreed in the creative direction
   - Component inventory (what UI elements appear, where, what state)
   - Color and typography choices (referencing design system tokens)
   - Responsive behavior (breakpoints, mobile adaptations)
   - Interaction states (hover, active, loading, empty, error)
5. Create Mermaid diagrams showing the layout structure and user flow.
   Use the beautiful-mermaid skill for rendering if available.
6. Generate visual mockups using the nano-banana-image-gen skill:
   - Generate 1-2 images showing the key visual concept
   - Save to [WORKSPACE]/mockups/
   - Focus on conveying the mood, hierarchy, and visual style -- not pixel-perfect accuracy
7. Do NOT write copy -- leave placeholder text like [HEADLINE], [SUBHEADLINE], [CTA_TEXT].
   The copywriter handles all words.

Write all output files to [WORKSPACE]/. Do not modify files outside this directory.
```

## Phase 3: Copywriter Spawn Prompt

```
Read the creative brief at [BRIEF_PATH].
Read the creative direction at [WORKSPACE]/brainstorm/creative-direction.md.
Read the design specification at [WORKSPACE]/design-spec.md.
Review the mockups in [WORKSPACE]/mockups/ for visual context.

Your task:
1. Read docs/PRODUCT/REFERENCE.md and docs/PRODUCT_MARKETING/REFERENCE.md for product context.
2. Write all copy for every section defined in the design spec, following the messaging direction from the creative direction document.
3. Write output to [WORKSPACE]/copy.md structured by section:

   ## Hero Section
   **Headline:** [your headline]
   **Subheadline:** [your subheadline]
   **Body:** [your body copy]
   **CTA:** [your CTA text]

   ## [Next Section]
   ...

4. Include ALL text that appears on the page:
   - Headlines and subheadlines
   - Body copy
   - CTA button text
   - Navigation labels
   - Social proof / testimonial text (generate realistic placeholders if none provided)
   - Footer copy
   - Microcopy (form labels, error messages, tooltips)
5. The messaging direction from the brainstorm is your guide -- every word must serve the agreed direction.
6. Do NOT modify the design spec. Write copy that fits into the design structure.

Write all output to [WORKSPACE]/copy.md. Do not modify files outside this directory.
```

## Phase 4: Developer Spawn Prompt

```
Read the creative brief at [BRIEF_PATH].
Read the creative direction at [WORKSPACE]/brainstorm/creative-direction.md.
Read the design specification at [WORKSPACE]/design-spec.md.
Read the copy at [WORKSPACE]/copy.md.
Review the mockups in [WORKSPACE]/mockups/ for visual reference.

Your task:
1. Read the design system at docs/DESIGN/DESIGN_SYSTEM.md (if it exists). Use its tokens.
2. Implement the design as production-ready [TECH_STACK] code.
3. Write implementation files to [WORKSPACE]/build/:
   - For HTML/CSS/JS: index.html + styles.css + script.js
   - For React: component files matching the design spec's component inventory
   - For Next.js: page files with appropriate routing
4. Implementation requirements:
   - Use the exact copy from copy.md -- do not rewrite or paraphrase
   - Follow the layout and hierarchy from design-spec.md
   - Reference design system tokens where available
   - Responsive: mobile-first, then tablet, then desktop
   - Accessible: semantic HTML, ARIA labels, keyboard navigation, WCAG AA contrast
   - Performance: optimized images, minimal JS, no render-blocking resources
5. Include any necessary build configuration (package.json, tailwind.config, etc.)
6. The output must be runnable -- a user should be able to open index.html or run `npm start` and see the result.

Write all output to [WORKSPACE]/build/. Do not modify files outside this directory.
```

## Phase 5: Customer Review Spawn Prompt

```
Read the creative brief at [BRIEF_PATH].
Read the creative direction at [WORKSPACE]/brainstorm/creative-direction.md.

Evaluate the workspace output:
- Design spec: [WORKSPACE]/design-spec.md
- Copy: [WORKSPACE]/copy.md
- Build: [WORKSPACE]/build/
[- Screenshots: [WORKSPACE]/screenshots/ (if available)]

Your task:
1. Load context: docs/PRODUCT/REFERENCE.md, docs/PRODUCT_MARKETING/REFERENCE.md, docs/DESIGN/REFERENCE.md
2. Evaluate the output using your 5-dimension framework (Visual, Copy, Flow, Conviction, Persuasion)
3. Score across all dimensions
4. Assess whether the execution delivers on the creative direction established in the brainstorm
5. Provide specific, actionable feedback for the next iteration
6. Write your full evaluation to [REVIEW_PATH]

Use the evaluation output format from your agent definition.
```

## Iteration: Feedback Prompt (prepend to designer, copywriter, and developer spawn prompts)

```
This is iteration round [N]. The customer reviewed the previous round.

Customer feedback from round [N-1]:
[PASTE CUSTOMER FEEDBACK HERE]

Previous customer review: [PREVIOUS_REVIEW_PATH]

The creative direction from the brainstorm remains your foundation. Incorporate the customer feedback to refine execution -- not to change direction. Address all P1 findings. Address P2 findings where feasible. Note any P3 findings you chose not to address and why.
```
