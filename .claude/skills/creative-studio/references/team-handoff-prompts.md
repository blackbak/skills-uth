# Team Handoff Prompts

Spawn prompts for each agent role per phase. Customize the bracketed placeholders before spawning.

## Phase 1: Designer Spawn Prompt

```
Read the creative brief at [BRIEF_PATH].

Your creative angle is: [ANGLE_NAME] -- [ANGLE_DESCRIPTION]

Your task:
1. Read the design system at docs/DESIGN/DESIGN_SYSTEM.md (if it exists). Use its tokens as constraints.
2. Read docs/PRODUCT/REFERENCE.md and docs/PRODUCT_MARKETING/REFERENCE.md for product context.
3. Create a design specification for [DELIVERABLE_TYPE] following your creative angle.
4. Write the spec to [TEAM_DIR]/design-spec.md with:
   - Page structure (sections, hierarchy, layout grid)
   - Component inventory (what UI elements appear, where, what state)
   - Color and typography choices (referencing design system tokens)
   - Responsive behavior (breakpoints, mobile adaptations)
   - Interaction states (hover, active, loading, empty, error)
5. Create Mermaid diagrams showing the layout structure and user flow.
   Use the beautiful-mermaid skill for rendering if available.
6. Generate visual mockups using the nano-banana-image-gen skill:
   - Generate 1-2 images showing the key visual concept
   - Save to [TEAM_DIR]/mockups/
   - Focus on conveying the mood, hierarchy, and visual style -- not pixel-perfect accuracy
7. Do NOT write copy -- leave placeholder text like [HEADLINE], [SUBHEADLINE], [CTA_TEXT].
   The copywriter handles all words.

Write all output files to [TEAM_DIR]/. Do not modify files outside this directory.
```

## Phase 2: Copywriter Spawn Prompt

```
Read the creative brief at [BRIEF_PATH].
Read the design specification at [TEAM_DIR]/design-spec.md.
Review the mockups in [TEAM_DIR]/mockups/ for visual context.

Your creative angle is: [ANGLE_NAME] -- [ANGLE_DESCRIPTION]

Your task:
1. Read docs/PRODUCT/REFERENCE.md and docs/PRODUCT_MARKETING/REFERENCE.md for product context.
2. Write all copy for every section defined in the design spec.
3. Write output to [TEAM_DIR]/copy.md structured by section:

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
5. Every word must serve the creative angle. Bold angle = aggressive copy. Minimal angle = precise copy. Unconventional angle = surprising copy.
6. Do NOT modify the design spec. Write copy that fits into the design structure.

Write all output to [TEAM_DIR]/copy.md. Do not modify files outside this directory.
```

## Phase 3: Developer Spawn Prompt

```
Read the creative brief at [BRIEF_PATH].
Read the design specification at [TEAM_DIR]/design-spec.md.
Read the copy at [TEAM_DIR]/copy.md.
Review the mockups in [TEAM_DIR]/mockups/ for visual reference.

Your task:
1. Read the design system at docs/DESIGN/DESIGN_SYSTEM.md (if it exists). Use its tokens.
2. Implement the design as production-ready [TECH_STACK] code.
3. Write implementation files to [TEAM_DIR]/build/:
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

Write all output to [TEAM_DIR]/build/. Do not modify files outside this directory.
```

## Phase 4: Customer Review Spawn Prompt

```
Read the creative brief at [BRIEF_PATH].

Evaluate ALL THREE team outputs:

**Team A ([ANGLE_A_NAME]):**
- Design spec: docs/studio/team-a/design-spec.md
- Copy: docs/studio/team-a/copy.md
- Build: docs/studio/team-a/build/
[- Screenshots: docs/studio/team-a/screenshots/ (if available)]

**Team B ([ANGLE_B_NAME]):**
- Design spec: docs/studio/team-b/design-spec.md
- Copy: docs/studio/team-b/copy.md
- Build: docs/studio/team-b/build/
[- Screenshots: docs/studio/team-b/screenshots/ (if available)]

**Team C ([ANGLE_C_NAME]):**
- Design spec: docs/studio/team-c/design-spec.md
- Copy: docs/studio/team-c/copy.md
- Build: docs/studio/team-c/build/
[- Screenshots: docs/studio/team-c/screenshots/ (if available)]

Your task:
1. Load context: docs/PRODUCT/REFERENCE.md, docs/PRODUCT_MARKETING/REFERENCE.md, docs/DESIGN/REFERENCE.md
2. Evaluate each team's output using your 5-dimension framework (Visual, Copy, Flow, Conviction, Persuasion)
3. Score each team independently
4. Pick a WINNER -- the team whose output would convert best for the target audience
5. Explain WHY the winner beats the others in 2-3 sentences
6. Provide specific, actionable feedback for the winning team's next iteration
7. Write your full evaluation to [REVIEW_PATH]

Use the evaluation output format from your agent definition. Add a ## Winner section at the end with the team name and rationale.
```

## Iteration: Single-Team Feedback Prompt (prepend to each agent's spawn prompt)

```
This is iteration round [N]. The customer reviewed the previous round and selected your team as the winner.

Customer feedback from round [N-1]:
[PASTE CUSTOMER FEEDBACK HERE]

Previous customer review: [PREVIOUS_REVIEW_PATH]

Incorporate the feedback into your work. Address all P1 findings. Address P2 findings where feasible. Note any P3 findings you chose not to address and why.
```
