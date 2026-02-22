# Paper Review

**Paper title:** Skill Architecture Matters: How Autonomous Feedback Loops Transform LLM Agent Design Quality
**Venue:** ACM CHI 2027 (Conference on Human Factors in Computing Systems) -- Case Study track
**Review round:** Resubmission #2 (Round 3)

**Verdict: ACCEPT**

**Confidence:** 4/5 (Strong familiarity with multi-agent LLM systems, HCI evaluation methodology, and web design quality assessment. Not an expert on specific CHI Case Study track norms.)

## Summary

This paper presents a controlled case study comparing three LLM agent skill architectures -- methodology injection, workflow pipeline, and creative studio with persona-grounded feedback loops -- for autonomous web design. All three receive the same prompt, model (Claude Opus 4), design system, and reference documents; only the architectural scaffolding varies. The key finding is that the creative studio, at 10x token cost, produces fundamentally richer output -- not because of multi-agent generation alone (the creative studio's pre-feedback R1 build had the same content gaps as single-agent approaches, scoring 1/12 persona needs), but because a customer evaluation agent adopting specific user personas identified content absences as bounce triggers, driving content additions between R1 and R2. The paper proposes grounded evaluation -- persona-anchored, dimensionally scored, behaviorally classified feedback -- as the mechanism explaining this difference, while honestly acknowledging that the attribution remains a supported hypothesis pending ablation.

## Strengths

1. **Every Round 2 comment has been substantively addressed (Sections 5.4, 5.5, Table 3, Appendix B).** The booking form timeline is now explicitly clarified with a dedicated "Timeline note" paragraph in Section 5.4, a detailed footnote on Table 3, and corrected driver text in Appendix B (Active Adult Flow: "Booking CTA remains dead-end in evaluated build; form added post-evaluation"). The "functional" vs. "interactive" conversion path distinction is applied consistently across the abstract, Section 5.4, Table 1, Table 4, and Section 5.7. The self-referential scoring dynamic is acknowledged in the Table 3 footnote with appropriate interpretive caveats. The threshold deviation (R2 average 7.2 below 8/10 threshold) is explained in the same footnote. I verified each of these changes against the actual paper text.

2. **The timeline transparency is now a strength, not a weakness (Section 5.4, Table 3 footnote).** The paper now explicitly states that the appointment request form was added after the R2 customer evaluation as a post-evaluation fix, that the R2 scores reflect the pre-form build, and that the customer agent never re-scored the form-equipped version. The Table 3 footnote further explains the threshold deviation and the self-referential scoring dynamic. This level of transparency about what was evaluated versus what was delivered is unusual and commendable -- most papers would obscure this gap rather than highlight it.

3. **The grounded feedback framework remains the paper's genuinely novel contribution (Section 4).** Across three review rounds, this assessment has not changed. The three-component framework -- persona grounding (Section 4.1), five-dimension rubric (Section 4.2), and behavioral severity classification (Section 4.3) -- is a meaningful advance over generic LLM-as-judge approaches. The verified customer review documents (`/Users/knitlybak/GitHub/skills-uth/docs/studio/customer-review-round-1.md`, `/Users/knitlybak/GitHub/skills-uth/docs/studio/customer-review-round-2.md`) demonstrate that persona adoption produces qualitatively different, more actionable feedback. The first-person evaluations -- "I clicked 'Book an Appointment' and it scrolled me down to a section that says 'Book an Appointment' again. Now what?" -- are not generic critique; they are situated user experience simulation with behavioral consequences.

4. **The R1 comparison continues to be the paper's strongest empirical evidence (Section 5.5, Table 1).** The Creative Studio R1 column in Table 1 shows that multi-agent generation without the feedback loop's corrective influence produced content completeness comparable to single-agent approaches (1/12 persona needs vs. 1/12 and 0/12). The jump from 1/12 to 10/12 occurred entirely between R1 and R2, and each content addition is traceable to a specific customer agent finding. This partial ablation is the most compelling evidence that the feedback loop, not multi-agent generation alone, drove the content completeness gains.

5. **The limitations section is among the most thorough I have reviewed (Section 6.6, 6.7).** Seven distinct limitations are enumerated with specific implications: single instance (6.6 paragraph 1), no human evaluation (6.6 paragraph 2), same model (6.6 paragraph 3), no A/B testing (6.6 paragraph 4), prompt specificity (6.6 paragraph 5), ICP richness dependency (6.6 paragraph 6), and no controllable random seeds (6.6 paragraph 7). The confounded variable discussion (Section 6.7) properly identifies the four ablation conditions needed and honestly states that attribution to the feedback loop remains "a supported hypothesis, not a proven mechanism." The acknowledgment that replication was infeasible for this revision cycle is stated directly.

## Weaknesses

1. **N=1 with no replication persists (Section 6.6).** -- Severity: **Major (acknowledged, not resolvable in this submission)**

   The fundamental N=1 limitation remains. Each architecture was run exactly once. The authors explain that the API billing account used for the original experiment was not available for follow-up runs within this submission window. The paper now acknowledges this as "the study's primary methodological limitation" and the Future Work section (Section 7) includes the reviewer's suggestion to run the skill approach two additional times as a minimal first step. This is the correct framing: the limitation is honestly stated, its implications are discussed, and a concrete remediation protocol is specified. The paper does not claim more than the evidence supports.

   This remains a Major weakness because N=1 means we cannot rule out stochastic variation as an alternative explanation. However, the R1 comparison (Section 5.5) provides partial mitigation: the creative studio was effectively run "twice" (R1 and R2), and both runs started from the same content-poor baseline before the feedback loop intervened. This does not substitute for replication, but it does provide directional evidence.

2. **No human evaluation (Section 6.6, paragraph 2).** -- Severity: **Major (acknowledged, not resolvable in this submission)**

   The evaluation remains entirely author-assessed. For a CHI submission, this is a significant gap. The paper now explicitly states: "Author-assessed evaluation cannot substitute for independent human judgment." The Future Work section proposes a detailed human evaluation protocol (3-5 UX designers + 5-10 persona-matched participants with task-based evaluation and semi-structured interviews). This is well-specified and would meaningfully strengthen a future version.

   As with the N=1 issue, this is a real limitation that the paper handles with appropriate honesty. The question for the program committee is whether the CHI Case Study track's standards accommodate a case study with this level of methodological transparency about its limitations. I believe they do, given the novelty of the contribution and the unusual artifact transparency.

## Dimension Scores

| Dimension | Score | Summary |
|-----------|-------|---------|
| Novelty | 7/10 | Grounded feedback framework is genuinely novel; unchanged across three review rounds |
| Technical Soundness | 7/10 | Improved from 6.5: timeline clarified, threshold deviation explained, self-referential scoring acknowledged, conversion path terminology corrected |
| Experimental Rigor | 5.5/10 | Improved from 5: all requested clarifications made; N=1 and no human evaluation remain but are honestly acknowledged as primary limitations |
| Writing and Presentation | 9/10 | Improved from 8.5: ethics promoted to standalone section, all cross-references corrected, consistent terminology throughout |
| Reproducibility | 8/10 | Unchanged: model version specified, hardware documented, all artifacts available, skill definitions referenced |
| Ethics and Broader Impact | 8.5/10 | Improved from 8: ethics is now standalone Section 9, all concerns from previous rounds addressed |

**Overall Score: 7.5/10**

## Detailed Comments

### Novelty

The novelty assessment remains unchanged from Rounds 1 and 2. The grounded feedback framework (Section 4) is the paper's primary novel contribution. The related work section now properly positions this against Self-Refine [14], Reflexion [16], ChatEval [18], Constitutional AI [15], Park et al. [13], Salminen et al. [20], Design2Code [23], and InterCode [24]. The distinction between Salminen et al.'s LLM-generated personas and this paper's human-authored ICP documents is now stated explicitly (Section 2.3): "The personas are not generated by the LLM; they are loaded as evaluation contracts that the LLM must adopt." This is a meaningful methodological distinction that properly differentiates the contribution.

The connection to design sprint methodology [19] (Section 2.1) is appropriate. The paper correctly identifies that the novelty is not in multi-agent orchestration per se, but in the specific evaluation methodology -- a framing that has been consistent and well-defended across all three rounds.

### Technical Soundness

The revision resolves the remaining technical issues from Round 2. Specifically:

- **Timeline clarification (Section 5.4, Timeline note).** The paper now states explicitly that the appointment request form was added post-evaluation, that R2 scores reflect the pre-form build, and that the customer agent never re-scored. This resolves the factual discrepancy identified in Round 2 Weakness 1.

- **Conversion path terminology (Section 5.4, Table 1, Table 4, Abstract).** The distinction between "interactive" (client-side form, no backend) and "functional" (phone `tel:` link) conversion paths is applied consistently throughout. The skill approach's `tel:` link is correctly characterized: "While the `tel:` link is technically functional (the call would dial), the obviously fictitious number cannot reach a real practice." The creative studio's phone link receives the same treatment. The difference is plausibility, not technical functionality -- now stated explicitly.

- **Threshold deviation (Table 3 footnote).** The footnote explains that the R2 average of 7.2 fell below the 8/10 re-iteration threshold, but the orchestrator addressed the top P1 finding as a targeted fix rather than triggering a full third iteration. This is an honest disclosure of a protocol deviation.

- **Self-referential scoring (Table 3 footnote).** The acknowledgment that the scoring agent is the same agent that identified deficiencies, creating a built-in confirmation bias, is appropriate. The interpretive caveat -- "delta magnitudes should be interpreted as evidence that flagged gaps were addressed, not as independent quality assessments" -- is well-calibrated.

The confounded variable discussion (Section 6.7) and the four proposed ablation conditions remain well-specified. The causal language throughout is appropriately hedged to "in this case study," "in this instance," and "the critical differentiator in this case study was."

### Experimental Rigor

This dimension remains the paper's weakest area, but the revision has addressed every actionable item raised in Rounds 1 and 2. The remaining limitations (N=1, no human evaluation) are acknowledged as such and are accompanied by concrete future work protocols. The key improvements across the three rounds:

- Round 1: Added R1 comparison column to Table 1 (partial ablation), added evaluation criteria asymmetry acknowledgment (Section 3.3), added implementation metrics (Table 5), reframed from "controlled experiment" to "controlled case study"
- Round 2: Added timeline clarification (Section 5.4), distinguished interactive vs. functional conversion paths, added self-referential scoring caveat, explained threshold deviation, added surgeon photo footnote (Table 2)
- Round 3 (this revision): All requested changes verified as implemented

The footnotes on Tables 2, 3, and 4 now collectively provide the interpretive context needed for accurate reading. The Table 2 footnote on persona need derivation ("criteria were derived from the ICP before examining outputs"), the Table 2 footnote on surgeon photo as a hard constraint, the Table 3 footnote on pre-form scoring and self-referentiality, and the Table 4 footnote on segment selection all contribute to methodological transparency.

For the CHI Case Study track specifically, the paper's unusual artifact transparency -- every claim is verifiable against the actual HTML files, customer review documents, and brainstorm transcripts in the repository -- partially compensates for the absence of formal replication and human evaluation. A reviewer can verify Table 1 by examining the three HTML outputs directly. This is not a substitute for replication, but it is a stronger evidentiary basis than most case studies provide.

### Writing and Presentation

The writing quality has improved incrementally across all three rounds and is now at a high level. Specific improvements in this revision:

- Ethics statement promoted to standalone Section 9 (was Section 8.1), consistent with CHI formatting expectations
- Section 6.3 cross-reference corrected from "Section 8" to "Section 7"
- Appendix B Active Adult Flow driver text now consistent with the main text timeline
- "Experientially worthless" (Round 1 minor issue 13) replaced with "fails its primary user-serving purpose" (Section 2.4)
- The abstract uses "interactive appointment request form" consistently
- Spelling is consistently American English throughout, with the justified domain exception of "orthopaedic"

The structural separation between "Quantitative Results" (Section 5) and "Qualitative Analysis" (Section 6) is effective. The cost-quality heuristic (Section 6.5) is practical. The concrete examples (customer agent quotes, brainstorm decisions, CTA dead-end traces) make the contribution tangible.

### Reproducibility

Unchanged from Round 2. The model is specified as "Claude Opus 4 (claude-opus-4-20250514)," hardware is documented (MacBook Pro, Apple M-series, 36GB RAM), and all intermediate artifacts are available in the repository with paths specified. The acknowledgment that random seeds are not controllable via the API is appropriate. Token estimates remain order-of-magnitude approximations, which is acceptable for a case study. Skill definitions are referenced by repository path (`.claude/skills/frontend-design/SKILL.md`, `.claude/skills/feature-frontend/SKILL.md`, `.claude/skills/creative-studio/SKILL.md`).

### Ethics and Broader Impact

The ethics statement (Section 9) is now a standalone top-level section, consistent with CHI formatting. It addresses: the fictional surgeon at a real hospital, the reserved 555 phone number, the fictional address, non-deployment of generated pages, and the recommendation for human verification of LLM-generated medical content. The environmental cost acknowledgment is brief but present.

The real hospital name (St. David's Medical Center) in a fictional context is noted but its trademark implications are not discussed. This is a minor gap -- academic papers routinely reference real institutions in hypothetical scenarios -- but worth noting for the authors' awareness.

## Verification of Response Letter Claims

I verified each claim in the response letter against the actual revised paper:

| Claim | Status | Evidence |
|-------|--------|----------|
| Timeline clarification added to Section 5.4 | Verified | Lines 273-274: explicit "Timeline note" paragraph |
| Table 3 footnote on pre-form scoring | Verified | Lines 290: detailed footnote with threshold deviation and self-referentiality |
| "Interactive" vs. "functional" distinction throughout | Verified | Abstract (line 11), Section 5.4 (line 271), Table 1 (line 203), Table 4 (line 327) |
| Appendix B Active Adult Flow driver corrected | Verified | Line 551: "Booking CTA remains dead-end in evaluated build; form added post-evaluation" |
| N=1 infeasibility acknowledged in Section 6.6 | Verified | Line 405: "We were unable to run additional replications for this revision" |
| Self-referential scoring discussed | Verified | Table 3 footnote (line 290): "creating a self-referential dynamic" |
| Ethics promoted to standalone Section 9 | Verified | Line 464: "## 9. Ethics Statement" |
| Section 6.3 reference corrected to Section 7 | Verified | Line 377: "requiring the ablation proposed in Section 7" |
| Salminen distinction stated explicitly | Verified | Line 61: "Unlike Salminen et al.'s LLM-generated personas, our customer agent evaluates through human-authored ICP documents" |
| Old uncited reference removed | Verified | [19] is now Knapp (Sprint), cited on line 47; Nielsen Norman Group reference is absent |
| Design2Code [23] and InterCode [24] added | Verified | Lines 67, 520, 522: properly cited in Section 2.4 and bibliography |
| Table 2 surgeon photo footnote added | Verified | Line 257: footnote [^2] on hard constraint |
| Phone `tel:` link plausibility distinction | Verified | Line 265: skill's `tel:` link characterized as "technically functional (the call would dial)" with same framing for creative studio |

All 13 claimed changes are present in the revised paper.

## Verification Against Experiment Artifacts

| Artifact Claim | Verified Against | Status |
|----------------|-----------------|--------|
| Booking form present in final HTML | `/Users/knitlybak/GitHub/skills-uth/presentation/experiment/creative-studio/index.html`, lines 1487-1509 | Confirmed: three-field form (name, phone, reason for visit) with client-side submit handler |
| R2 customer review identifies missing form as P1 | `/Users/knitlybak/GitHub/skills-uth/docs/studio/customer-review-round-2.md`, P1 resolution audit item 1 and Active Adult Flow P1 | Confirmed: "there is still no actual booking mechanism: no form, no Calendly link, no external scheduling URL" |
| R2 scores assigned to pre-form build | Customer review document scores vs. paper Table 3 | Confirmed: Active Adult Flow = 6/10 in both sources; consistent with dead-end CTA, not with form presence |
| Form is client-side only | HTML source, lines 1487 (`action="#"`) and associated JavaScript | Confirmed: `action="#"` with `e.preventDefault()`, visual confirmation only, no data transmission |

## Questions for the Authors

No critical questions remain. All questions from Rounds 1 and 2 have been addressed satisfactorily. Two suggestions for the camera-ready version:

1. **Camera-ready formatting:** The paper is written in Markdown. For CHI submission, it must be formatted in the ACM two-column template with proper citation formatting (author-year or numeric, per ACM style). This is a production concern, not a content concern.

2. **Future work prioritization:** Section 7 now contains six future work items. For clarity, consider explicitly ranking them by impact. The ablation study (four conditions from Section 6.7) is correctly identified as "the highest-priority next step." The minimal replication (two additional skill runs) could be labeled as an immediate low-cost action item.

## Missing References

No missing references remain. All references suggested in Rounds 1 and 2 have been incorporated: Self-Refine [14], Constitutional AI [15], Reflexion [16], MLAgentBench [17], ChatEval [18], Sprint [19], Salminen et al. [20], Design2Code [23], InterCode [24]. Park et al. [13] was already present from Round 1.

## Minor Issues

1. **Table 3, footnote [^3]:** The footnote is quite long (4 sentences covering three distinct points: pre-form scoring, threshold deviation, and self-referential scoring). Consider splitting into separate footnotes or moving the self-referentiality discussion to the main text paragraph following Table 3. This is a readability suggestion, not a content concern.

2. **Section 5.4, "Timeline note" paragraph:** The phrase "The customer agent did not re-score after the form was added" appears in both Section 5.4 (line 273) and the Table 3 footnote (line 290). The redundancy is minor but could be consolidated by having the Table 3 footnote reference the timeline note ("see Section 5.4, timeline note") rather than restating the full claim.

3. **Table 4, "Conversion paths" row:** The row reads "1 interactive + 1 functional" for CS R2. A reader unfamiliar with the distinction might benefit from a brief parenthetical: "1 interactive (form) + 1 functional (phone)."

4. **Section 3.1, Table:** "Token estimation" row says "Estimated from API billing data (input + output tokens per session); order-of-magnitude approximations, not per-request logs." This is transparent but could note whether the billing data is still available for verification or has been discarded.

5. **References:** Reference [4] (AgentVerse) and [17] (MLAgentBench) remain as arXiv preprints. If either has been published at a conference venue since the original submission, the reference should be updated for the camera-ready version.

## Recommendation Summary

The revision addresses every comment from Round 2 with verified changes to the paper. The booking form timeline is now transparent, the conversion path terminology is consistent, the self-referential scoring dynamic is acknowledged, the threshold deviation is explained, and all cross-references are correct. The two remaining Major weaknesses (N=1 and no human evaluation) are the same issues identified in Round 2; they persist because they require additional data collection that was infeasible within this revision cycle. The paper now handles both with appropriate honesty: stating them as the study's primary limitations, not overclaiming beyond what the evidence supports, and proposing concrete remediation protocols in Future Work.

The paper's contribution -- the grounded feedback framework and the empirical evidence that skill architecture is a primary determinant of autonomous design quality -- is genuine, well-articulated, and properly scoped to a case study. The artifact transparency is unusual and commendable. The limitations are honestly presented and do not invalidate the contribution for the CHI Case Study track. The paper is publishable.
