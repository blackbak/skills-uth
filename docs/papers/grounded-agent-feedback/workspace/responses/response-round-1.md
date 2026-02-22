# Response to Review: Round 1

**Paper:** Skill Architecture Matters: How Autonomous Feedback Loops Transform LLM Agent Design Quality
**Review round:** 1
**Verdict received:** MAJOR REVISION
**Revision date:** 2026-02-22

---

We thank the reviewer for a thorough and constructive review. The detailed artifact verification, specific weaknesses with actionable suggestions, and missing references have materially improved the paper. Below we address every comment.

---

## Response to Weaknesses

### W1: N=1 experiment with no replication (Critical)

> "The entire paper rests on a single experiment: one prompt, one domain (healthcare), one model (Claude Opus), one execution per approach. There are zero replications."

**Response:** The reviewer is correct. We cannot claim experimental generalizability from a single instance. In the revision, we have:

1. Replaced "controlled experiment" with "controlled case study" throughout the paper (Abstract, Section 1, Section 3 header, Section 6, Section 7). This is the most honest framing for the CHI Case Study track. (See W6 below for the full list of changes.)
2. Added explicit discussion of what N=1 means for the claims: we can demonstrate that the quality difference *occurred* under controlled conditions, but cannot establish *reliability* without replication (Section 6.6, paragraph 1).
3. Added a concrete replication protocol in Section 7 (Future Work): run each architecture 5 times with different seeds, report mean and variance on persona coverage, and replicate across at least two additional domains (e-commerce, restaurant).
4. Softened causal language throughout. "The critical differentiator is" becomes "In this case study, the critical differentiator was." Claims are now consistently scoped to the observed instance.

We agree with the reviewer that multiple runs are necessary before the central claim can be stated as a general finding. The revised paper frames the contribution as a documented instance with a proposed mechanism, not a proven law.

### W2: No human evaluation validates the framework's predictions (Major)

> "The evaluation criteria in Tables 1 and 2 are assessed entirely by the authors, not by independent evaluators, UX professionals, or actual patients."

**Response:** The reviewer is correct, and this is the paper's most significant limitation. We cannot conduct a human evaluation study within this revision cycle. In the revision, we have:

1. Elevated this to the first item in Section 6.6 (Limitations), with explicit acknowledgment of the circularity concern the reviewer identifies (Section 6.6, paragraph 2).
2. Added a detailed human evaluation protocol in Section 7 (Future Work) specifying: (a) blinded presentation of all three HTML outputs in randomized order, (b) 3-5 practicing UX designers rating content completeness, conversion path quality, and design system compliance, (c) 5-10 participants matching the target patient personas performing a task-based evaluation ("find and use the booking mechanism"), and (d) semi-structured interviews asking which page they would use to book an appointment and why.
3. Added an explicit note that author-assessed evaluation cannot substitute for independent human judgment, particularly at a venue centered on human factors (Section 6.6, paragraph 2).

### W3: Confounded independent variable: architecture vs. content specification (Major)

> "The creative studio does not merely add feedback loops -- it also adds a copywriter agent, a designer agent, and a brainstorm phase that generates a creative direction document."

**Response:** The reviewer identifies a real confound. We cannot fully disentangle the feedback loop from multi-agent generation in the current experiment. However, the Round 1 customer review provides partial evidence. In the revision, we have:

1. Added a new comparison in Section 5.5 (now titled "Isolating the Feedback Loop's Contribution") that directly compares the creative studio's Round 1 output (before any customer feedback) with the skill and workflow outputs. The Round 1 customer review document (`docs/studio/customer-review-round-1.md`) reveals that the creative studio's initial build had: placeholder surgeon name (`Dr. [First] [Last], MD`), fake phone number `(555) 123-4567`, a self-referencing CTA dead-end (`#booking` pointing to itself), no header, no footer, no practice name visible, no location, no testimonials, no insurance information, and no urgent care messaging. This is strikingly similar to the skill and workflow outputs (Section 5.5, Table 3 now includes a "Creative Studio (R1)" column).
2. Added a "Creative Studio (R1)" column to Table 1 showing the pre-feedback state. This is the most actionable change in the revision and directly addresses W5 as well.
3. Added explicit discussion of the confound in Section 6.7 (new subsection: "Confounded Variables and the Need for Ablation"). We acknowledge that the multi-agent generation process (designer + copywriter brainstorm) produced the creative direction and copy quality advantages *before* any feedback, while the feedback loop produced the content completeness advantages *after* evaluation. Both mechanisms contribute, but to different quality dimensions.
4. Proposed the missing ablation condition (creative studio without customer evaluation agent) as priority future work in Section 7.

### W4: Evaluation criteria favor the creative studio by design (Major)

> "The five evaluation dimensions are derived from the ICP document that the creative studio's customer agent explicitly loads and evaluates against."

**Response:** The reviewer is correct that there is an asymmetry. In the revision, we have:

1. Added an explicit acknowledgment of this asymmetry in Section 3.3 (Evaluation Criteria), noting that the creative studio's customer agent is architecturally designed to optimize for these criteria (Section 3.3, final paragraph).
2. Added a new Table 5 (Section 5.8, "Implementation Metrics") reporting dimensions where the creative studio does *not* have a structural advantage:

   | Metric | Skill | Workflow | Creative Studio |
   |--------|-------|----------|-----------------|
   | Code volume (lines) | 1,217 | 820 | 1,648 |
   | File size (bytes) | 39,124 | 26,125 | 53,869 |
   | CSS custom properties defined | 13 | 12 | 18 |
   | Inline JavaScript (lines) | ~40 | ~20 | ~80 |

   The skill approach produces the most concise code relative to its visual complexity. The workflow approach is the leanest implementation. The creative studio's additional content comes at the cost of a 35% larger file and roughly double the JavaScript. These are legitimate tradeoffs that the original paper did not present.

3. Added discussion noting that if the evaluation criteria were restricted to code quality, implementation efficiency, and page load implications, the ordering would differ (Section 6.7).

### W5: Missing ablation: feedback loop contribution is not isolated (Major)

> "The paper never compares the creative studio's Round 1 output (before any feedback) to the skill and workflow outputs."

**Response:** This is the most actionable item in the review, and the reviewer correctly identifies that the evidence already exists in the repository. In the revision, we have:

1. Added a "Creative Studio (R1)" column to Table 1 showing the pre-feedback state of the creative studio's output. Key findings from this comparison (Section 5.5):
   - The Creative Studio (R1) build had placeholder surgeon name, fake phone number, dead-end CTA, no header/footer, no location, no testimonials, no insurance, and no urgent care messaging -- nearly identical to the skill and workflow outputs.
   - The Creative Studio (R1) customer review scores averaged 5.7/10 across the three personas (Visual: 6.3, Copy: 7.3, Flow: 5.7, Conviction: 4.7, Persuasion: 4.7).
   - Copy quality was slightly higher in the R1 build (7.3 vs. generic copy in skill/workflow) due to the dedicated copywriter agent, confirming the reviewer's observation that multi-agent generation contributes to copy quality independently of feedback.
   - Content completeness was *not* higher in the R1 build, confirming that the feedback loop is responsible for content additions (testimonials, hospital affiliation, insurance, urgent banner, empathy line, office hours, real address).

2. Revised Table 3 to show a four-way comparison: Skill, Workflow, Creative Studio (R1), Creative Studio (R2). This makes the feedback loop's contribution visible as the delta between R1 and R2.

3. Added persona coverage counts for the R1 build: 1/12 documented needs addressed (compared to Skill: 1/12, Workflow: 0/12, Creative Studio R2: 10/12). This demonstrates that multi-agent generation without feedback produces persona coverage comparable to single-agent approaches.

This comparison is the strongest evidence in the paper for the feedback loop's importance, and we agree with the reviewer that its omission from v1 was a significant gap.

### W6: The paper overclaims "controlled experiment" status (Major)

> "A controlled experiment requires (a) randomization, (b) replication, (c) blinding, and (d) statistical analysis. This study has none of these."

**Response:** The reviewer is correct. In the revision, we have replaced "controlled experiment" with "controlled case study" in the following locations:

- Abstract: "We present a controlled case study" (was "controlled experiment")
- Section 1, paragraph 1: "Our case study challenges this assumption" (was "Our experiment challenges")
- Section 3 header: "Case Study Design" (was "Experiment Design")
- Section 6.1 heading: updated to reference "case study"
- Section 7 (Conclusion): "We presented a controlled case study" (was "controlled experiment")
- All other instances throughout

We have also added a note in Section 3 acknowledging what the study design lacks relative to a full experiment: randomization, replication, blinding, and statistical analysis (Section 3, opening paragraph).

---

## Response to Detailed Comments

### Novelty

> "The paper should foreground this distinction more clearly -- the novelty is in the evaluation framework, not in having multiple agents."

**Response:** We agree. The revised introduction (Section 1, contribution list) now explicitly states: "The novelty is not in multi-agent orchestration per se, but in the specific evaluation methodology: persona-grounded, dimensionally scored, behaviorally anchored feedback." Section 2.1 (Related Work) now ends with a paragraph making this distinction.

### Technical Soundness

> "Would a single agent with the creative direction document pre-loaded produce similar output to the full creative studio?"

**Response:** We do not know, and we now say so explicitly. Section 6.7 proposes this as one of four ablation conditions needed to isolate each component's contribution: (a) single agent + creative direction document, (b) multi-agent generation without feedback, (c) single agent with self-refine feedback, and (d) full creative studio.

### Experimental Rigor

> "Table 2 presents persona coverage as a clean fraction (1/12, 0/12, 10/12) but the denominator is itself a judgment call."

**Response:** We have added a footnote to Table 2 explaining how the 12 needs were derived (one need per row in the table, each traceable to a specific statement in the ICP document) and acknowledging that different granularity would change the magnitude of the reported difference (Section 5.3, footnote). The criteria were defined before seeing outputs, based on the ICP document's stated needs per segment.

> "Why 12 needs and not 15 or 8?"

**Response:** The 12 needs map to the feature rows in Table 2. We chose this granularity to match the level of specificity in the ICP document. We now note in Section 5.3 that the ICP has four segments (including Youth Athletes & Parents), and we evaluated against only the three segments targeted by the prompt. This is acknowledged in revised Section 5.3 and Table 4 footnote.

### Writing and Presentation

> "The abstract is 280 words, which is long for CHI (typically 150 words). It should be tightened."

**Response:** The revised abstract is 148 words. We removed the detailed per-approach output descriptions and tightened to problem/approach/results/significance.

> "Some claims in the abstract are repeated nearly verbatim in the introduction, creating redundancy."

**Response:** The revised introduction no longer repeats the abstract's phrasing. The abstract states the finding; the introduction provides context and motivation.

> "The paper uses American spelling in some places and British spelling in others."

**Response:** All spelling is now American English throughout (behavior, color, organized, specialized). The one exception is "orthopaedic" which is the standard medical spelling in both American and British English (the American Orthopaedic Association uses this spelling).

> "Section 5 is titled 'Results' but mixes quantitative comparison with qualitative analysis."

**Response:** Section 5 is now split into "5. Quantitative Results" (Tables 1-5) and "6. Qualitative Analysis" (formerly Sections 5.5-5.6). Subsequent sections are renumbered.

> "The appendices are valuable but Appendix B's per-persona score table should be referenced from the main text."

**Response:** Section 5.5 now references Appendix B: "Per-persona breakdowns are provided in Appendix B, showing significant variance (e.g., Conviction ranges from 4 to 5 in Round 1 across personas)."

### Reproducibility

> "The model version is specified only as 'Claude Opus' -- no version number."

**Response:** Section 3.1 now specifies: "Claude Opus 4 (claude-opus-4-20250514), accessed via the Anthropic API between February 20-21, 2026."

> "No random seeds are reported."

**Response:** Acknowledged in Section 6.6 (Limitations). The API does not expose a seed parameter; stochastic variation is a source of uncontrolled variance.

> "The token count estimates are approximate."

**Response:** Section 3.1 now clarifies: "Token counts are estimated from API billing data (input + output tokens per session). Exact counts were not logged per-request; the estimates are order-of-magnitude approximations."

> "The skill and workflow agent configurations are not included."

**Response:** Appendix A now includes the skill names and references to their full definitions in the repository (`/.claude/skills/frontend-design/SKILL.md`, `/.claude/skills/feature-frontend/SKILL.md`, `/.claude/skills/creative-studio/SKILL.md`). The prompts and tool configurations are fully specified in these files.

> "Wall-clock times are reported without hardware specification."

**Response:** Section 3.1 now specifies: "All executions ran on a MacBook Pro (Apple M-series, 36GB RAM) via the Claude Code CLI, with network latency to Anthropic API servers."

### Ethics and Broader Impact

> "The paper does not discuss the ethics of generating fabricated medical content."

**Response:** We have added a new Section 8.1 (Ethics Statement) addressing:
1. The fictional surgeon "Dr. Sarah Mitchell" at a real hospital (St. David's Medical Center) is a fabricated entity. The paper explicitly states that none of the generated pages were deployed or indexed.
2. The phone number `(512) 555-0147` uses the reserved 555 exchange specifically to prevent accidental calls to real numbers.
3. The practice address is fictional.
4. The paper now includes a warning that deploying LLM-generated medical content that blends real and fictional entities poses risks of patient deception and should require human verification before publication.
5. The environmental cost of 500K+ tokens per page is acknowledged as a consideration for adoption at scale.

---

## Response to Questions for Authors

### Q1: Ablation (multi-agent without feedback)

> "Would you be willing to run the creative studio pipeline without the customer evaluation agent?"

**Response:** We agree this is the single most important missing experiment. We cannot run it in this revision cycle due to resource constraints. We have proposed it as priority future work with a specific protocol (Section 7, item 1) and added the Round 1 comparison as partial evidence that the feedback loop, not multi-agent generation alone, is responsible for the content completeness gains (Section 5.5).

### Q2: Prompt sensitivity

> "If the prompt were changed to include surgeon name, location, etc., would the skill approach produce comparable output?"

**Response:** We acknowledge this is an important objection. The paper's central claim is not that single agents *cannot* produce this content, but that the feedback loop *identifies which content is needed* without requiring it in the prompt. The revised Section 6.4 (Matching Architecture to Stakes) now discusses this: "A sufficiently detailed prompt could close the content gap, but this shifts the design burden to the prompt author, who must anticipate every persona need in advance -- precisely the work the customer evaluation agent performs autonomously." The prompt specificity experiment is listed in Section 7 as future work.

### Q3: Replication

> "Have you run any of the three approaches more than once?"

**Response:** No. Each approach was run exactly once. The revised paper is explicit about this (Section 3, opening paragraph). We acknowledge that a single run cannot distinguish architectural effects from stochastic variation (Section 6.6, paragraph 1).

### Q4: Creative studio Round 1 vs. skill/workflow

> "Why is this comparison not in the paper?"

**Response:** An oversight. It is now the centerpiece of the revised Section 5.5, with a "Creative Studio (R1)" column added to Table 1. We thank the reviewer for identifying this as the most impactful actionable change.

### Q5: Evaluation criteria derivation

> "How were the 12 persona needs in Table 2 selected? Were they defined before or after seeing the outputs?"

**Response:** The 12 needs were derived from the ICP document before examining outputs. Each row in Table 2 maps to a specific need stated in `docs/BUSINESS/ICP.md` under the corresponding patient segment. The revised paper includes a footnote in Section 5.3 confirming this and noting the mapping.

### Q6: Real-world validation

> "Do you have any plans to deploy any of these three pages and measure actual patient behavior?"

**Response:** No deployment is planned, as noted in the ethics statement. The pages contain fabricated medical content. A/B testing would require a real practice and IRB approval. This is listed as aspirational future work in Section 7 but is beyond the scope of this study.

### Q7: Generalizability beyond healthcare

> "Does the creative studio's advantage depend on the richness of the ICP?"

**Response:** We do not know. The revised Section 6.6 now explicitly discusses this: "The ICP document used in this case study is unusually detailed. Whether the creative studio's advantage persists with thinner persona documentation is an open question. We hypothesize that the feedback loop's contribution is proportional to the richness of the persona documentation, but this requires empirical validation."

---

## Response to Missing References

All eight suggested references have been added:

1. **Park et al. (2023).** "Generative Agents: Interactive Simulacra of Human Behavior." *UIST 2023.* Added to Section 2.3, discussing the connection between persistent persona adoption in generative agents and the customer agent's persona grounding.

2. **Bai et al. (2022).** "Constitutional AI: Harmlessness from AI Feedback." Added to Section 2.2, noting the precedent for AI self-evaluation improving output quality.

3. **Madaan et al. (2023).** "Self-Refine: Iterative Refinement with Self-Feedback." *NeurIPS 2023.* Added to Section 2.2, as the key single-agent self-refinement baseline. Section 6.3 now discusses how the multi-agent feedback loop differs from single-agent self-refinement.

4. **Shinn et al. (2023).** "Reflexion: Language Agents with Verbal Reinforcement Learning." *NeurIPS 2023.* Added to Section 2.2, as another self-refinement approach using verbal feedback.

5. **Huang et al. (2023).** "MLAgentBench." Added to Section 2.4, as a benchmark for evaluating LLM agent architectures.

6. **Chan et al. (2023).** "ChatEval." *ICLR 2024.* Added to Section 2.2, as a multi-agent evaluation framework.

7. **Knapp (2016).** "Sprint." Added to Section 2.1, acknowledging the design sprint methodology parallel.

8. **Salminen et al. (2024).** "Deus Ex Machina and Personas from Large Language Models." *CHI 2024.* Added to Section 2.3 as recent work on LLM-generated personas.

Additionally, references [1] and [2] have been updated from arXiv preprints to their published conference versions (MetaGPT at ICLR 2024, ChatDev at ACL 2024). AutoGen has been updated to COLM 2024.

---

## Response to Minor Issues

### M1: Abstract "grounded" undefined
**Response:** Revised abstract now defines "grounded" on first use: "grounded evaluation -- feedback anchored in specific user personas."

### M2: Section 1 "brainstorm-then-build pipeline" needs context
**Response:** Added brief context: "a sequential pipeline that enforces a brainstorming phase (exploring design intent, hierarchy, and interaction states) before implementation."

### M3: Model version unspecified
**Response:** Section 3.1 now specifies Claude Opus 4 (claude-opus-4-20250514) with API access dates.

### M4: Inconsistent backtick formatting for skill names
**Response:** All skill names are now consistently backtick-quoted throughout the paper.

### M5: Token estimation methodology
**Response:** Added clarification in Section 3.1: estimates from API billing data, not per-request logs.

### M6: "Partial" vs. "No" undefined in Table 2
**Response:** Added a footnote defining: "Partial = feature exists but does not meet the documented need (e.g., an eyebrow badge saying 'Board Certified' partially addresses 'surgeon credentials visible' but does not provide name, training, or specific qualifications)."

### M7: Skill approach `tel:` link counting
**Response:** Section 5.4 now clarifies: "The skill approach includes a `tel:` link to `+15551234567`, which is technically functional (the call would dial) but uses an obviously fictitious number. We count this as zero functional conversion paths because the path cannot reach a real practice."

### M8: Table 3 averages obscure variance
**Response:** Table 3 now includes ranges in parentheses. Main text references Appendix B for per-persona breakdowns.

### M9: ICP has four segments, paper evaluates three
**Response:** Added footnote to Table 4: "The ICP defines four patient segments; Youth Athletes & Parents is the fourth. We evaluate against the three segments most relevant to the minimal prompt ('orthopaedic surgery practice homepage'). The fourth segment is not addressed by any of the three approaches."

### M10: Blockquote attribution
**Response:** Added citation: "as documented in the Round 1 customer review (`docs/studio/customer-review-round-1.md`, Active Adult persona, 'Why I Would Walk Away')."

### M11: Assertion about single-agent persona adoption
**Response:** Revised to: "While a single agent could be prompted to evaluate its own output from a patient's perspective -- as demonstrated by Self-Refine [15] -- our observation is that the separation of generation and evaluation into distinct agents with distinct roles produced more targeted findings. Whether this advantage is inherent to multi-agent separation or an artifact of the specific prompting is an open question requiring the ablation proposed in Section 7."

### M12: Mixed spelling
**Response:** All American English throughout. "Orthopaedic" retained as standard medical terminology.

### M13: "Experientially worthless" is hyperbolic
**Response:** Revised to: "A page that passes all accessibility checks but provides no booking mechanism is functionally correct yet fails its primary user-serving purpose."

### M14: arXiv references should use published versions
**Response:** MetaGPT updated to ICLR 2024, ChatDev updated to ACL 2024, AutoGen updated to COLM 2024.

### M15: Persona literature is dated
**Response:** Added Salminen et al. (2024) on LLM-generated personas (CHI 2024) and Park et al. (2023) on generative agents adopting personas (UIST 2023).

---

## Summary of Changes

| Change | Location in v2 |
|--------|---------------|
| "Controlled experiment" -> "controlled case study" | Throughout |
| Abstract tightened to 148 words | Abstract |
| Round 1 creative studio comparison added | Section 5.5, Table 1 (new column), Table 3 (new column) |
| Implementation metrics table added | Section 5.8, Table 5 |
| Evaluation criteria asymmetry acknowledged | Section 3.3 |
| Confounded variable discussion added | Section 6.7 |
| Human evaluation protocol described | Section 7 |
| Ethics statement added | Section 8.1 |
| 8 missing references added | Sections 2.1-2.4, bibliography |
| 3 references updated to published versions | Bibliography |
| American spelling throughout | Throughout |
| Section 5 split into Quantitative Results + Qualitative Analysis | Sections 5, 6 |
| Model version, hardware, token methodology specified | Section 3.1 |
| All 15 minor issues addressed | Various (see above) |
