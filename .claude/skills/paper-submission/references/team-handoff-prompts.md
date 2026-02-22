# Team Handoff Prompts

Spawn prompts for each agent role per phase. Replace bracketed placeholders before spawning.

## Phase 1: Literature Review

### Researcher — Literature Review

```
Read the research brief at [BRIEF_PATH].

Your task:
1. Search for related work on the topic described in the brief. Use WebSearch and WebFetch to find recent papers (last 3 years prioritized, seminal older work included).
2. Organize findings into thematic groups (not chronological). For each group:
   - Summarize the line of work (2-3 sentences)
   - List 3-7 key papers with: citation, core idea, methodology, key results
   - Explain how this group relates to the research question
3. Identify the specific research gap:
   - What has been tried and what hasn't
   - Where existing methods fall short
   - What assumptions in prior work can be challenged
4. Propose 2-3 methodological approaches to address the gap:
   - For each: brief description, expected strengths, expected weaknesses, feasibility given the constraints in the brief
   - State which approach you recommend and why
5. List all references in BibTeX format at the end

Write output to [WORKSPACE]/literature-review.md

Be thorough but concise. Prioritize depth on the most relevant papers over breadth on tangential work.
```

## Phase 2: Paper Draft

### Researcher — First Draft

```
Read the research brief at [BRIEF_PATH].
Read the literature review at [WORKSPACE]/literature-review.md.
The user selected this approach: [SELECTED_APPROACH]

Your task: Write a complete first draft of the paper.

Structure (follow the standard structure from your agent definition):
1. Title — specific, informative, states the contribution
2. Abstract — problem, approach, results, significance (max 250 words)
3. Introduction — context, problem, contribution (numbered), outline
4. Related Work — thematic, compare not just list, identify gap
5. Methodology — formal notation, architecture/algorithm, design justifications
6. Experimental Setup — datasets, baselines, metrics, implementation details, reproducibility
7. Results — tables with bolded best, error bars, ablations, statistical tests
8. Analysis and Discussion — qualitative examples, error analysis, computational cost, limitations
9. Conclusion — contributions, limitations, concrete future work
10. References — verified citations, published versions preferred

Guidelines:
- Every claim must be supported by evidence, citation, or explicit qualification
- Design experiments that directly test the research question from the brief
- Include at least one ablation study
- Report computational cost
- Be honest about limitations — do not hide weaknesses
- Define every symbol on first use
- Figures and tables must have self-contained captions

Write the paper to [WORKSPACE]/drafts/draft-v[N].md
Write the bibliography to [WORKSPACE]/drafts/references-v[N].bib
Save any figures to [WORKSPACE]/figures/

Run your quality checklist before finishing. Flag any items you cannot satisfy and explain why.
```

## Phase 3: Review

### Research-Reviewer — Paper Review

```
Read the paper draft at [WORKSPACE]/drafts/draft-v[N].md.
Read the bibliography at [WORKSPACE]/drafts/references-v[N].bib.
[If round > 1: Read your previous review at [REVIEWS_DIR]/review-round-[N-1].md]
[If round > 1: Read the author response at [WORKSPACE]/responses/response-round-[N-1].md]

This is review round [N].

Your task:
1. Read the entire paper carefully — every section, every figure, every equation, every reference
2. [If round > 1: Re-read your previous review. Check whether each comment was genuinely addressed in the revision. Verify claims in the response letter against the actual paper — authors sometimes claim changes they did not make.]
3. Evaluate across all six dimensions:
   - Novelty and Contribution
   - Technical Soundness
   - Experimental Rigor
   - Writing and Presentation
   - Reproducibility
   - Ethics and Broader Impact
4. Issue your verdict:
   - Round 1: REJECT or MAJOR REVISION only (never ACCEPT or MINOR REVISION on first review)
   - Round 2+: REJECT, MAJOR REVISION, MINOR REVISION, or ACCEPT
   - ACCEPT requires that ALL previous comments are satisfactorily addressed and no new critical/major issues exist
5. Write your review using the full review output format from your agent definition
6. Include specific questions the authors must answer
7. List missing references that should be cited
8. Note all minor issues (typos, formatting, notation)

Be thorough, specific, and fair. Reference exact sections, equations, figures, and tables. Every weakness must include an actionable suggestion for improvement.

Write your review to [REVIEWS_DIR]/review-round-[N].md
```

## Phase 4: Revision

### Researcher — Paper Revision

```
Read the research brief at [BRIEF_PATH].
Read your latest draft at [WORKSPACE]/drafts/draft-v[N-1].md.
Read the reviewer's feedback at [REVIEWS_DIR]/review-round-[N-1].md.
[If round > 2: Read the full review history in [REVIEWS_DIR]/ and your previous responses in [WORKSPACE]/responses/ to understand the conversation arc.]

The reviewer issued: [VERDICT]

Your task:
1. Read every comment in the review carefully. Assume the reviewer is right until you can demonstrate otherwise with evidence.
2. Write a detailed response letter:
   - Quote each reviewer comment verbatim
   - State exactly what you changed (with section/page references in the revised draft)
   - If you disagree with a comment, explain why with evidence — do not dismiss it
   - If a requested experiment is infeasible, explain the constraint and propose an alternative
3. Revise the paper:
   - Address every critical and major issue — no exceptions
   - Address minor issues where feasible
   - Do NOT introduce new content that was not requested — scope creep weakens revisions
   - Ensure changes are consistent throughout the paper (e.g., updating a table also updates the text that references it)
4. Verify your revision:
   - Re-read the review and check each comment against your changes
   - Run your quality checklist
   - Confirm the response letter accurately describes what changed

Write the response letter to [WORKSPACE]/responses/response-round-[N-1].md
Write the revised paper to [WORKSPACE]/drafts/draft-v[N].md
Write the updated bibliography to [WORKSPACE]/drafts/references-v[N].bib

Do NOT overwrite previous drafts or responses. Each version is preserved.
```

## Phase 6: Camera-Ready

### Researcher — Camera-Ready Preparation

```
Read the research brief at [BRIEF_PATH].
Read the accepted draft at [WORKSPACE]/drafts/draft-v[N].md.
Read the final review at [REVIEWS_DIR]/review-round-[FINAL].md.
[If there were minor revision notes in the final ACCEPT review, address them.]

Your task:
1. Apply any remaining minor fixes from the final review
2. Format the paper for [TARGET_VENUE] (if specified in the brief):
   - Apply venue-specific formatting (page limits, section naming, citation style)
   - Ensure all figures meet resolution and format requirements
   - Verify reference format matches venue style
3. Final quality pass:
   - Every claim is supported
   - Every figure and table is referenced in the text
   - No orphaned references (cited but not in bibliography, or in bibliography but not cited)
   - Abstract is under the word limit
   - Acknowledgments section (if needed)
4. Produce the final deliverables

Write the camera-ready paper to [FINAL_DIR]/paper.md
Write the final bibliography to [FINAL_DIR]/references.bib
Copy final figures to [FINAL_DIR]/figures/

This is the version that goes to the venue. Triple-check everything.
```
