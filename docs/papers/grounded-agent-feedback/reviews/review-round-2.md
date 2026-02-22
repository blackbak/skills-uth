# Paper Review

**Paper title:** Skill Architecture Matters: How Autonomous Feedback Loops Transform LLM Agent Design Quality
**Venue:** ACM CHI 2027 (Conference on Human Factors in Computing Systems) -- Case Study track
**Review round:** Resubmission #1

**Verdict: MINOR REVISION**

**Confidence:** 4/5 (Strong familiarity with multi-agent LLM systems, HCI evaluation methodology, and web design quality assessment. Not an expert on specific CHI Case Study track norms.)

## Summary

This paper presents a controlled case study comparing three LLM agent skill architectures -- methodology injection, workflow pipeline, and creative studio with persona-grounded feedback loops -- for autonomous web design. All three receive the same prompt, model (Claude Opus 4), design system, and reference documents; only the architectural scaffolding varies. The paper finds that the creative studio, at 10x token cost, produces fundamentally richer output because a customer evaluation agent adopting specific user personas identifies content gaps that single-agent approaches cannot surface. The key evidence is that the creative studio's pre-feedback output (R1) exhibited the same content gaps as the single-agent approaches; content improvements emerged only after persona-grounded evaluation. The revision addresses the majority of Round 1 feedback substantively: "controlled experiment" is now "controlled case study," a Creative Studio R1 column is added to Table 1 isolating the feedback loop's contribution, evaluation criteria asymmetry is acknowledged, implementation metrics are reported, an ethics statement is added, and all eight missing references are incorporated.

## Strengths

1. **The R1 comparison is now the paper's strongest evidence (Section 5.5, Table 1).** The addition of the "Creative Studio R1" column to Table 1 directly addresses the most critical analytical gap from Round 1. The comparison shows that the creative studio's pre-feedback build had placeholder names, fake phone numbers, dead-end CTAs, no header/footer, no location, and no testimonials -- nearly identical to the skill and workflow outputs (1/12 persona needs vs. 1/12 and 0/12). The jump from 1/12 to 10/12 between R1 and R2 is compelling evidence that the feedback loop, not multi-agent generation alone, produced the content completeness gains. I verified this against the actual Round 1 customer review document (`/Users/knitlybak/GitHub/skills-uth/docs/studio/customer-review-round-1.md`) and confirm the claims are accurate.

2. **Honest acknowledgment of limitations and confounds (Sections 3.3, 6.6, 6.7).** The paper now explicitly acknowledges: evaluation criteria asymmetry (Section 3.3), the inability to distinguish architectural effects from stochastic variation with N=1 (Section 6.6), the confounded independent variable (Section 6.7), the absence of human evaluation (Section 6.6 paragraph 2), and the ICP richness dependency (Section 6.6). The causal language has been appropriately softened throughout -- "the critical differentiator was" instead of "is." The four ablation conditions proposed in Section 6.7 are well-specified and demonstrate the authors understand the methodological gap.

3. **Implementation metrics offset the evaluation asymmetry (Section 5.8, Table 5).** The new Table 5 reports dimensions where the creative studio does not have a structural advantage (code volume, file size, CSS custom properties, JavaScript complexity), and the accompanying discussion acknowledges that the workflow produces the leanest code while the creative studio's advantages are concentrated in content-oriented dimensions. The acknowledgment in Section 6.7 that the ordering of approaches would differ under implementation-quality criteria is intellectually honest and strengthens the paper's credibility.

4. **Complete response to all suggested references (Section 2).** All eight missing references have been incorporated meaningfully. Self-Refine [15] and Reflexion [17] are properly discussed in Section 2.2 as lighter-weight alternatives, with the honest caveat that "whether this multi-agent separation produces inherently better feedback than single-agent self-refinement with persona instructions is an open question." ChatEval [20], Constitutional AI [16], Park et al. [14], and Salminen et al. [22] are each placed in relevant subsections with substantive discussion, not perfunctory citations.

5. **Grounded feedback framework remains the paper's strongest novel contribution (Section 4).** The three-component framework -- persona grounding, five-dimension rubric, and behavioral severity classification -- continues to be genuinely novel and well-articulated. The verified customer review documents demonstrate that persona adoption produces qualitatively different, more actionable feedback than generic critique.

## Weaknesses

1. **Factual discrepancy between paper and customer review on booking form status (Section 5.4 vs. Round 2 customer review).** -- Severity: **Major**

   The paper states in Section 5.4: "The hero CTA links to #contact, scrolling to a section with a three-field appointment request form (name, phone, reason for visit) with a submit handler that provides feedback ('Request Sent -- We Will Call You'). [...] Two functional conversion paths (form + phone)."

   However, the Round 2 customer review document (`/Users/knitlybak/GitHub/skills-uth/docs/studio/customer-review-round-2.md`) identifies the booking mechanism as a **P1 issue that remains partially unresolved**: "But there is still no actual booking mechanism: no form, no Calendly link, no external scheduling URL. The conversion path terminates at a button that does nothing."

   I verified the actual HTML (`/Users/knitlybak/GitHub/skills-uth/presentation/experiment/creative-studio/index.html`, lines 1487-1509) and a booking form IS present in the final file. This means the form was added AFTER the Round 2 customer review was written but BEFORE the file was finalized. The paper does not clarify this timeline. It presents the R2 customer review scores (Table 3) as the evaluation of the final output, but those scores were assigned to a version WITHOUT the form. The actual final output (with the form) was never evaluated by the customer agent.

   This matters because: (a) the Flow scores in Table 3 and Appendix B likely reflect the formless version, not the version the paper describes as "final"; (b) the claim of "Two functional conversion paths" was never validated by the customer agent; and (c) the form's submit handler (`action="#"` with `e.preventDefault()`) does not actually send data anywhere -- it simulates a submission by changing button text for 3 seconds and resetting. Calling this a "functional conversion path" is generous.

   **Actionable suggestion:** Clarify the timeline explicitly. State that the booking form was added in response to the Round 2 customer review's P1 finding and that the form was not included in the R2 evaluation scores. Either re-run the customer evaluation on the truly final output, or adjust the paper's language to note that the R2 scores reflect a pre-form state. Additionally, qualify the "functional conversion path" claim: the form captures intent (name, phone, reason) but does not transmit data to any backend -- it is a prototype interaction, not a deployed booking mechanism.

2. **N=1 with no replication remains (Section 6.6).** -- Severity: **Major (reduced from Critical)**

   The revision appropriately reframes the contribution as a case study and softens causal language. However, the fundamental N=1 limitation persists: each architecture was run exactly once. The authors acknowledge this but do not attempt even a minimal replication (e.g., running one architecture twice to demonstrate variance). The replication protocol in Section 7 is well-specified but not executed. At CHI, case studies are valued, but the strength of a case study depends on the depth of its analysis, and the absence of any variance data leaves the central finding vulnerable to a stochastic variation objection.

   **Actionable suggestion:** If a full replication study is infeasible for this submission cycle, consider running the skill approach (the cheapest at ~50K tokens, 3 minutes) two additional times. If those runs also produce 0-1/12 persona needs, report this as supplementary evidence that the content gap is not a single-run fluke. Even two additional data points for the cheapest condition would meaningfully strengthen the case.

3. **No human evaluation (Section 6.6, paragraph 2).** -- Severity: **Major (unchanged)**

   The revision acknowledges this gap prominently and proposes a detailed protocol in Section 7 (Future Work). However, the evaluation remains entirely author-assessed. For a CHI submission -- a venue where user-centered evaluation is foundational -- this remains the most significant methodological gap. The acknowledgment is appropriate, but acknowledgment alone does not resolve the gap.

   **Actionable suggestion:** This is a hard requirement for many CHI reviewers. If a formal user study is infeasible, consider a lightweight expert evaluation: share the three HTML outputs (unlabeled, randomized) with 2-3 UX professionals not involved in the research and collect their assessments. Even informal expert opinions would partially address the circularity concern.

4. **Score progression interpretation requires caveats (Table 3, Appendix B).** -- Severity: **Minor**

   Table 3 shows the creative studio's score progression from R1 (5.7 average) to R2 (7.2 average), with the largest gains in Conviction (+2.3) and Persuasion (+2.3). These scores are assigned by the same customer agent that identified the deficiencies -- it is both the evaluator and the standard-setter. The paper does not discuss potential bias in self-referential scoring: an agent that flags "no testimonials" as a P1 finding and then re-evaluates after testimonials are added has a built-in confirmation bias toward scoring the addition positively.

   Additionally, per Weakness 1, the R2 scores were assigned to the version WITHOUT the booking form, yet the paper presents them alongside the final output description (which includes the form). The Flow dimension scores (Active Adult: 6/10, Older Adult: 7/10, Acute Injury: 7/10) specifically reflect the dead-end CTA state, not the form-equipped state.

   **Actionable suggestion:** Add a note to Table 3 and Section 5.5 clarifying that the R2 scores reflect the customer agent's evaluation of the pre-form build. Note that the scoring agent is the same agent that set the criteria, creating a self-referential dynamic. Consider briefly discussing whether this circular scoring inflates or deflates the reported improvements.

5. **The "functional conversion path" claim is overstated (Section 5.4).** -- Severity: **Minor**

   The booking form has `action="#"` and the JavaScript handler calls `e.preventDefault()`, changes the button text for 3 seconds, then resets the form. No data is transmitted. No email is sent. No backend receives the submission. This is a UI prototype of a booking interaction, not a functional conversion path in any meaningful product sense. Calling it "functional" alongside the `tel:` link (which does initiate a real phone call) conflates two very different levels of functionality.

   **Actionable suggestion:** Distinguish between "interactive" and "functional" conversion paths. The form provides an interactive booking experience (the user can fill fields and receive visual feedback) but does not complete a conversion (no data is transmitted). The `tel:` link is a genuinely functional conversion path. Revise Section 5.4 to say something like: "one interactive booking form (client-side only, no backend submission) and one functional phone conversion path."

## Dimension Scores

| Dimension | Score | Summary |
|-----------|-------|---------|
| Novelty | 7/10 | Grounded feedback framework is genuinely novel; multi-agent comparison is well-executed incremental work; unchanged from Round 1 |
| Technical Soundness | 6.5/10 | Significantly improved: confound acknowledged, R1 comparison added, causal language softened; factual discrepancy on booking form timeline needs resolution |
| Experimental Rigor | 5/10 | Improved from 4/10: R1 comparison and implementation metrics strengthen the analysis, but N=1, no replication, and no human evaluation remain |
| Writing and Presentation | 8.5/10 | Improved from 8/10: clearer structure, better separation of quantitative/qualitative, abstract tightened, consistent spelling, good cross-referencing |
| Reproducibility | 8/10 | Improved from 7/10: model version specified, hardware documented, token estimation methodology clarified, skill definitions referenced |
| Ethics and Broader Impact | 8/10 | Improved from 6/10: comprehensive ethics statement added, fabricated content risks discussed, environmental cost acknowledged |

**Overall Score: 7/10**

## Detailed Comments

### Novelty

The novelty assessment remains unchanged from Round 1. The grounded feedback framework (Section 4) is the paper's strongest novel contribution, and the revised paper foregrounds this distinction more clearly -- the introduction now explicitly states that "the novelty is not in multi-agent orchestration per se, but in the specific evaluation methodology." The related work section properly situates this against Self-Refine [15], Reflexion [17], ChatEval [20], and Constitutional AI [16], and honestly acknowledges that whether multi-agent separation is necessary for the feedback benefit is an open question. This intellectual honesty strengthens rather than weakens the contribution.

### Technical Soundness

The revision substantially improves technical soundness. The R1 comparison (Section 5.5) provides partial ablation evidence by showing that multi-agent generation without the feedback loop produces content completeness comparable to single-agent approaches (1/12 vs. 1/12 and 0/12). The confounded variable discussion (Section 6.7) is thorough and proposes the right ablation conditions. The causal language is appropriately scoped to the observed instance.

The primary remaining technical issue is the factual discrepancy between the paper's description of the "final" R2 output (which includes a booking form) and the R2 customer review scores (which were assigned to a version without the form). This creates an inconsistency in the evidence chain: the paper claims the feedback loop produced "two functional conversion paths," but the customer agent never evaluated the form-equipped version. The scores in Table 3 and Appendix B reflect a different artifact than the one described in Sections 5.1 and 5.4. This must be clarified.

### Experimental Rigor

This dimension improved from Round 1 but remains the paper's weakest area. The R1 comparison is a meaningful addition that partially substitutes for a formal ablation study. The implementation metrics (Table 5) provide a fairer comparison by including dimensions where the creative studio does not have a structural advantage. The evaluation criteria asymmetry acknowledgment (Section 3.3) and the confounded variable discussion (Section 6.7) demonstrate awareness of the methodological limitations.

However, three gaps persist: (a) N=1 with no replication -- even running the cheapest approach (skill, ~50K tokens, 3 minutes) two more times would provide valuable variance data; (b) no human evaluation -- this is particularly significant for CHI and cannot be fully mitigated by acknowledgment alone; (c) the customer agent's scores are self-referential (it evaluates against criteria it set, creating a confirmation-bias dynamic).

The Table 2 persona coverage metric (1/12, 0/12, 1/12, 10/12) is now properly footnoted with the derivation methodology and acknowledgment that different granularity would change the magnitude. The footnote confirming that criteria were derived from the ICP before examining outputs addresses the post-hoc rationalization concern from Round 1.

### Writing and Presentation

The writing quality has improved. The structural split between "Quantitative Results" (Section 5) and "Qualitative Analysis" (Section 6) is effective. The abstract has been tightened to approximately the right length. Spelling is now consistently American English throughout, with the justified exception of "orthopaedic." The section cross-referencing is stronger -- Appendix B is referenced from Section 5.5, the confound discussion (Section 6.7) references the ablation protocol in Section 7, and Table 3 includes ranges alongside averages.

The paper reads well as a CHI Case Study submission. The concrete examples (customer agent quotes, brainstorm decisions, CTA dead-end descriptions) make the contribution tangible. The cost-quality heuristic in Section 6.5 is practical and well-argued. The limitations section (Section 6.6) is admirably thorough -- seven distinct limitations, each with specific implications.

One remaining structural issue: the paper's Section 8 is titled "Conclusion" but Section 8.1 is "Ethics Statement." Ethics statements should be standalone sections, not subsections of the conclusion. Consider promoting 8.1 to a top-level section or integrating its key points into the main text.

### Reproducibility

Significantly improved. The model is now specified as "Claude Opus 4 (claude-opus-4-20250514)," hardware is documented (MacBook Pro, Apple M-series, 36GB RAM), token estimation methodology is clarified (API billing data), and skill definitions are referenced with repository paths. The acknowledgment that random seeds are not controllable via the API is appropriate.

Remaining gaps are minor: execution logs are not provided, and the token estimates remain order-of-magnitude approximations. These are acceptable for a case study.

### Ethics and Broader Impact

The ethics statement (Section 8.1) comprehensively addresses the concerns raised in Round 1: the fictional surgeon at a real hospital, the reserved 555 phone number, the fictional address, the non-deployment of generated pages, and the recommendation for human verification of LLM-generated medical content. The environmental cost acknowledgment is brief but appropriate.

One additional consideration: the paper uses "St. David's Medical Center" -- a real Austin hospital -- in a fictional context. The ethics statement notes this but does not discuss the potential trademark or reputational implications if this paper were widely read. This is a minor concern for an academic paper but worth a sentence.

## Questions for the Authors

1. **Booking form timeline:** The Round 2 customer review identifies the missing booking mechanism as a P1 issue, but the final HTML file contains a booking form. Was the form added after the R2 customer evaluation? If so, do the scores in Table 3 and Appendix B reflect the pre-form or post-form state? This distinction affects the interpretation of Flow scores across all three personas.

2. **Form functionality:** The booking form has `action="#"` and the JavaScript handler calls `e.preventDefault()`, displays "Request Sent" for 3 seconds, and resets. In what sense is this a "functional conversion path"? Would you be willing to distinguish between "interactive" (UI prototype) and "functional" (data-transmitting) conversion paths?

3. **Score self-referentiality:** The customer agent that assigns scores in Table 3 is the same agent that identified the deficiencies in R1. Has any consideration been given to whether this creates a scoring bias? For example, if the agent identifies "no testimonials" as a P1 bounce trigger, it is predisposed to score the addition of testimonials positively -- regardless of the testimonials' quality or persuasive effectiveness for a real patient.

4. **Minimal replication:** Running the skill approach two additional times would cost approximately 100K tokens (about 6 minutes). Would you be willing to do this and report whether the persona coverage (Table 2) is consistent across runs? Even two additional data points would substantially strengthen the case against stochastic variation.

## Missing References

- **Si et al. (2024). "Design2Code: How Far Are We From Automating Front-End Engineering?"** ICML 2024. Directly relevant benchmark for evaluating LLM-generated web design quality, including visual fidelity and implementation accuracy.

- **Yang et al. (2024). "InterCode: Standardizing and Benchmarking Interactive Coding with Execution Feedback."** ICLR 2024. Relevant to the general question of how execution feedback improves LLM code generation quality -- a parallel to the paper's grounded evaluation feedback.

## Minor Issues

1. **Section 5.4, paragraph 4:** "The phone number (512) 555-0147 uses the reserved 555 exchange" -- this is noted correctly, but the paper does not mention that the `tel:` link IS technically functional (it would attempt to dial). The distinction between "technically dialable but reaches no one" and "non-functional" could be clearer. The skill approach's `tel:` link to `(555) 123-4567` is equally dialable. The difference is plausibility, not functionality.

2. **Section 5.1, Table 1:** The "Booking mechanism" row for Creative Studio R2 says "Appointment request form (name, phone, reason)" but does not note that the form is client-side only with no backend. This omission makes the comparison with the dead-end CTAs of other approaches appear more dramatic than it is.

3. **Section 5.3, Table 2:** "Surgeon name and face" is one row. The creative studio R2 gets "Name yes, face no." This is counted as a partial success, but the row title includes "face" and the creative studio does not provide one. The ICP document presumably specifies both. If the creative studio cannot provide a face (because no photo exists), this is a hard constraint shared by all approaches and should not be counted against or for any of them.

4. **Section 6.2:** The blockquote attribution now includes the artifact path -- good. However, the quote in the paper uses a period after "I am closing this tab" while the actual customer review document uses the same phrasing. Minor consistency verified.

5. **Section 6.3:** The revised text "our observation is that the separation of generation and evaluation into distinct agents with distinct roles produced more targeted findings in this instance" is appropriately hedged. The follow-up sentence referencing Self-Refine [15] and the ablation in Section 8 is well-placed. However, Section 8 is now the Conclusion, not Future Work (which is Section 7). The reference should say "Section 7" not "Section 8."

6. **Section 8.1 placement:** Ethics statements in CHI papers are typically standalone sections, not subsections of the conclusion. Consider promoting this to a top-level section.

7. **Appendix B, Active Adult Flow:** R1 = 6, R2 = 6, Delta = 0. The driver column says "Booking CTA still dead-end (form added but section CTA persists)." This description matches the Round 2 customer review's finding but contradicts the paper's main text claim that a booking form provides a conversion path. The appendix and main text tell different stories about the same artifact.

8. **Table 3:** The R2 average of 7.2 is below the stated threshold of 8/10 that triggers re-iteration (Section 3.2 states "If the average score falls below 8/10 and the round count is below 3, the pipeline loops back"). The paper does not explain why a third iteration was not triggered. Was the round count at 3 already? Or was the threshold not enforced?

9. **Section 2.3:** "Salminen et al. [22] investigated LLM-generated personas at CHI 2024, finding that while such personas are informative and believable, they exhibit biases in demographics and pain points" -- this is a useful addition but the connection to the paper's own approach could be stronger. The creative studio's personas are not LLM-generated; they are human-authored ICP documents. This distinction should be stated explicitly to differentiate from Salminen et al.'s concern.

10. **References:** Reference [19] (Nielsen Norman Group, 2021) is cited in the bibliography but I could not find where it is cited in the paper text. If it is not cited in the body, remove it from the bibliography.

## Recommendation Summary

The revision substantively addresses the majority of Round 1 feedback. The most impactful change -- adding the Creative Studio R1 column to Table 1 -- transforms the paper from a three-way comparison into a partial ablation that isolates the feedback loop's contribution. The confound acknowledgments, implementation metrics, ethics statement, and reference additions all strengthen the paper. The writing is clearer, the claims are more carefully scoped, and the limitations are honestly presented.

Three issues remain. First, the factual discrepancy between the paper's description of the "final" R2 output (with booking form) and the R2 customer evaluation scores (assigned to a version without the form) must be resolved with a timeline clarification and appropriate caveats on the reported scores. Second, the claim of "two functional conversion paths" should be revised to distinguish between the interactive-but-non-transmitting form and the genuinely functional phone link. Third, the N=1 and no-human-evaluation limitations persist, but they are now adequately acknowledged and scoped.

None of these remaining issues are fundamental flaws that require rethinking the contribution. They are resolvable with targeted revisions: clarifying the booking form timeline (1-2 paragraphs), qualifying the "functional" claim (word-level edit), and optionally running two additional skill-approach iterations for variance data. The grounded feedback framework is a genuine contribution, the evidence is unusually transparent and verifiable, and the paper is honest about its limitations. A minor revision addressing the three issues above would bring this paper to a publishable state for the CHI Case Study track.
