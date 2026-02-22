# Paper Review

**Paper title:** Skill Architecture Matters: How Autonomous Feedback Loops Transform LLM Agent Design Quality
**Venue:** ACM CHI 2027 (Case Study track)
**Review round:** First review

**Verdict: MAJOR REVISION**

**Confidence:** 4/5 (Strong familiarity with multi-agent LLM systems, HCI evaluation methodology, and web design quality assessment. Not an expert on the specific CHI Case Study track norms.)

## Summary

This paper presents a controlled experiment comparing three LLM agent architectures for autonomous web design: (1) methodology injection (single agent with design principles in context), (2) workflow pipeline (single agent with structured brainstorm-then-build phases), and (3) a creative studio (multi-agent system with designer, copywriter, developer, and customer evaluator roles plus iterative feedback loops). All three receive the same prompt, model, design system, and reference documents; only the architectural scaffolding varies. The paper finds that the creative studio, at 10x the token cost, produces fundamentally richer output -- with named surgeons, real locations, functional booking forms, and persona-matched testimonials -- because a customer evaluation agent adopting specific user personas identifies content gaps that single-agent approaches cannot surface. The central claim is that grounded evaluation (persona-based, dimensionally scored, behaviorally anchored feedback) is the critical differentiator, not agent count or token volume.

## Strengths

1. **Exceptional artifact transparency (Sections 3-5, Tables 1-4).** The experiment artifacts are fully available in the repository. I verified every factual claim in the paper against the actual HTML files, customer review documents, and brainstorm transcripts. The line counts match (1,218 / 821 / 1,649 vs. claimed 1,217 / 820 / 1,648 -- off by 1 each, acceptable). The CTA dead-end behavior is exactly as described. The creative studio's testimonials, urgent banner, empathy line, and booking form are all present in the final HTML. This level of verifiability is rare and commendable.

2. **Well-controlled experimental design (Section 3.1).** Holding the model, prompt, design system, brand guidelines, and ICP constant while varying only the skill architecture is a clean experimental setup. The control variable table is explicit. The prompt's deliberate minimalism ("3-section homepage") is a smart design choice that avoids confounding prompt specificity with architectural capability.

3. **Grounded feedback framework is genuinely novel (Section 4).** The three-component framework -- persona grounding, five-dimension rubric, and behavioral severity classification -- is a meaningful contribution to the LLM-as-judge literature. The customer review documents (verified in the repository) demonstrate that persona adoption produces qualitatively different feedback than generic critique. The first-person evaluation voice ("I am sitting in an ER with a broken wrist...") generates findings with behavioral consequences that are directly actionable. This is more than a prompting trick -- it is a structured evaluation methodology.

4. **Honest cost-quality analysis (Section 5.7, Table 4).** The paper does not hide the 10x token cost or 32-minute wall-clock time. The cost-quality tradeoff is presented straightforwardly, and the discussion (Section 6.5) provides practical heuristics for when each architecture level is appropriate. This intellectual honesty strengthens the paper.

5. **Strong qualitative analysis with verified provenance (Sections 5.5-5.6, Appendix C).** The creative direction document ("Steady Hands") and the copywriter's brainstorm response are available in the repository. The claim that "pain compresses attention" was a copywriter argument is verified in `docs/studio/workspace/brainstorm/round-1-copywriter.md`. The traced decision path from brainstorm disagreement to final headline choice is convincing evidence of multi-perspective value.

## Weaknesses

1. **N=1 experiment with no replication (Section 6.6).** -- Severity: **Critical**

   The entire paper rests on a single experiment: one prompt, one domain (healthcare), one model (Claude Opus), one execution per approach. There are zero replications. The authors acknowledge this in limitations (Section 6.6) but the severity is understated. With N=1, we cannot distinguish between (a) the creative studio architecture being inherently superior, (b) stochastic variation in model output (a different random seed might produce a skill output with a surgeon name), and (c) the creative studio's ICP document providing richer context that a single agent could have exploited with a better prompt. The paper's central claim -- "skill architecture is the primary determinant of output quality" -- requires at minimum multiple runs per architecture to establish reliability.

   **Actionable suggestion:** Run each architecture at least 3 times (ideally 5) with different random seeds. Report mean and variance across runs for the persona coverage metric (Table 2). If the skill approach produces 0-2/12 persona needs across all runs while the creative studio consistently produces 8-12/12, the claim is supported. If there is high variance, the claim must be qualified. Additionally, run the experiment on at least one additional domain (e.g., a restaurant website or an e-commerce product page) to establish cross-domain generalizability.

2. **No human evaluation validates the framework's predictions (Sections 5.1-5.4).** -- Severity: **Major**

   The evaluation criteria in Tables 1 and 2 are assessed entirely by the authors, not by independent evaluators, UX professionals, or actual patients. The paper evaluates LLM output using LLM-generated criteria (the ICP document) assessed by paper authors. This creates a circularity concern: the creative studio was designed to optimize for the ICP, the evaluation criteria are derived from the ICP, and the authors who designed both the system and the criteria are also the evaluators. At no point does an independent human judge enter the loop. For a paper at CHI -- a venue centered on human factors -- this is a significant gap.

   **Actionable suggestion:** Conduct a blinded evaluation study. Present all three HTML outputs (unlabeled, randomized order) to (a) 3-5 practicing UX designers and (b) 5-10 people matching the target patient personas. Ask UX designers to rate content completeness, conversion path quality, and design system compliance. Ask patients which page they would use to book an appointment and why. This does not need to be a large-scale study -- even qualitative interview data from 5 patients would substantially strengthen the claims.

3. **Confounded independent variable: architecture vs. content specification (Section 3.2).** -- Severity: **Major**

   The creative studio does not merely add feedback loops -- it also adds a copywriter agent, a designer agent, and a brainstorm phase that generates a creative direction document. The skill and workflow approaches have none of these. The paper attributes the quality difference to "grounded evaluation" (the customer agent's feedback loop), but the creative direction document, the dedicated copywriter, and the designer agent all contribute content decisions that precede any evaluation. The "Steady Hands" creative direction (Appendix C) establishes the "reassurance over aspiration" framing before the customer agent ever evaluates anything. The copywriter argues for "pain compresses attention" before any feedback loop fires. The paper cannot cleanly attribute the quality gains to the feedback loop alone when the creative studio also has fundamentally different generation capabilities.

   **Actionable suggestion:** Add a fourth condition: the creative studio pipeline without the customer evaluation agent (i.e., designer + copywriter + developer, same brainstorm, same creative direction, but no customer review loop). If this condition produces output similar to the full creative studio, the critical differentiator is multi-perspective generation, not grounded evaluation. If it produces output similar to the workflow, the feedback loop claim is supported. Without this ablation, the paper's central thesis is unfalsifiable within the experiment.

4. **Evaluation criteria favor the creative studio by design (Section 3.3).** -- Severity: **Major**

   The five evaluation dimensions (content completeness, persona coverage, conversion path functionality, design system compliance, accessibility) are derived from the ICP document that the creative studio's customer agent explicitly loads and evaluates against. The creative studio is architecturally designed to optimize for exactly these criteria. The skill and workflow approaches never see the ICP as evaluation criteria -- they see it only as reference documentation. This is not a level playing field: it is like testing a student on a take-home exam and comparing them to students who took the same exam in-class without knowing which questions would be asked.

   **Actionable suggestion:** Acknowledge this asymmetry explicitly in the paper. Consider adding evaluation dimensions where the creative studio does not have a structural advantage -- for example, page load performance, code quality metrics (Lighthouse scores, HTML validation, CSS efficiency), time-to-interactive, or visual design quality assessed by independent designers who do not see the ICP. If the skill approach wins on code quality and performance while losing on content completeness, the tradeoff analysis becomes richer and more honest.

5. **Missing ablation: feedback loop contribution is not isolated (Section 5.5).** -- Severity: **Major**

   Section 5.5 shows score progression from Round 1 to Round 2 of the creative studio's feedback loop (Table 3). This is valuable. However, the paper never compares the creative studio's Round 1 output (before any feedback) to the skill and workflow outputs. If the creative studio's Round 1 build already has a surgeon name, location, and testimonials, then the multi-agent generation (not the feedback loop) is the primary differentiator. The Round 1 customer review document (verified in the repository) actually shows that the Round 1 build had placeholder names, fake phone numbers, no header, no footer, and a dead-end CTA -- very similar to the skill and workflow outputs. This is strong evidence for the feedback loop's importance, but the paper does not make this comparison explicitly.

   **Actionable suggestion:** Add a direct comparison between the creative studio's Round 1 output (before customer feedback) and the skill/workflow outputs. Table 1 should include a "Creative Studio (R1)" column showing the state before feedback. This would demonstrate that even with multi-agent generation, the output without feedback is comparable to single-agent approaches -- isolating the feedback loop's contribution. The customer review round 1 document already contains this data.

6. **The paper overclaims "controlled experiment" status (Sections 1, 3).** -- Severity: **Major**

   The paper repeatedly uses the phrase "controlled experiment" (abstract, introduction, Section 3 header, conclusion). A controlled experiment requires (a) randomization, (b) replication, (c) blinding, and (d) statistical analysis. This study has none of these. It is a structured case comparison or a single-instance comparative analysis. Calling it a "controlled experiment" overstates the methodological rigor and may draw criticism from CHI reviewers familiar with experimental methodology.

   **Actionable suggestion:** Replace "controlled experiment" with "controlled case study" or "structured comparative analysis." The CHI Case Study track is appropriate for this work, and framing it honestly as a case study with controlled variables (rather than a controlled experiment) aligns better with the track's expectations and avoids methodological overclaiming.

## Dimension Scores

| Dimension | Score | Summary |
|-----------|-------|---------|
| Novelty | 7/10 | The grounded feedback framework is genuinely novel; the multi-agent comparison is incremental but well-executed |
| Technical Soundness | 5/10 | Confounded independent variable, no ablation, N=1 with no replication, overclaimed experimental status |
| Experimental Rigor | 4/10 | Single run per condition, no human evaluation, no statistical analysis, evaluation criteria favor the creative studio |
| Writing and Presentation | 8/10 | Clear, well-structured, honest about costs, strong tables and concrete examples |
| Reproducibility | 7/10 | Full artifacts available but no documented seeds, no execution logs, model version unspecified |
| Ethics and Broader Impact | 6/10 | Fabricated medical content (fake surgeon, fake phone number) is not discussed as an ethical concern |

**Overall Score: 5.5/10**

## Detailed Comments

### Novelty

The grounded feedback framework (Section 4) is the paper's strongest novel contribution. The idea of requiring an LLM evaluator to adopt a specific persona, score across behaviorally-anchored dimensions, and classify findings by user behavior consequence (bounce, hesitation, confidence erosion) is a meaningful advance over generic LLM-as-judge approaches. The existing LLM-as-judge literature (Zheng et al. [5], Liu et al. [6]) evaluates text quality in isolation; this framework evaluates experiential quality through simulated user perspectives. This is a genuine contribution to both the multi-agent systems and HCI evaluation literatures.

The multi-agent architecture comparison itself is less novel. MetaGPT [1], ChatDev [2], and AutoGen [3] have established the value of role-based multi-agent systems. The paper's contribution is not the architecture but the specific role (customer evaluator) and the specific methodology (persona-grounded evaluation). The paper should foreground this distinction more clearly -- the novelty is in the evaluation framework, not in having multiple agents.

### Technical Soundness

The experimental design has a fundamental confounding problem. The independent variable is labeled "skill architecture" but actually bundles three changes: (a) number of agents, (b) presence of specialized creative roles (copywriter, designer), and (c) presence of a feedback loop with grounded evaluation. The paper's thesis is that (c) is the critical differentiator, but the experiment cannot isolate (c) from (a) and (b). The creative studio's copywriter argued for "reassurance over aspiration" during brainstorming -- a content decision that occurred before any feedback loop. Would a single agent with the creative direction document pre-loaded produce similar output to the full creative studio? We do not know, because that condition was never tested.

The overclaiming of "controlled experiment" status is a technical soundness issue. The study controls input variables (prompt, model, design system) but does not control for stochastic variation (no repeated runs), does not randomize (conditions are predetermined), does not blind evaluators (authors assessed their own outputs), and does not perform statistical analysis. These are necessary conditions for claiming experimental status in any empirical venue.

### Experimental Rigor

This is the paper's weakest dimension. Specific gaps:

- **No replication.** Each architecture was run exactly once. LLM outputs are stochastic. A single run cannot establish reliability.
- **No human evaluation.** At CHI, where user-centered evaluation is foundational, relying entirely on author assessment of LLM-generated artifacts is insufficient.
- **No statistical analysis.** Table 3 shows score deltas but no significance tests, no confidence intervals, no effect sizes.
- **Asymmetric evaluation criteria.** The creative studio is designed to optimize for the ICP; the evaluation criteria are derived from the ICP. This circularity is not acknowledged.
- **No ablation.** The feedback loop's contribution is not isolated from multi-agent generation, dedicated creative roles, or the brainstorm phase.
- **Missing baseline.** What happens with a more detailed prompt? The paper acknowledges this in Section 6.6 but does not test it. If the prompt specified "include surgeon name Dr. Sarah Mitchell, location Austin TX, phone number (512) 555-0147, office hours Mon-Fri 8-5," would the skill approach produce comparable content? This is the most obvious objection and it is left unaddressed.

Table 2 presents persona coverage as a clean fraction (1/12, 0/12, 10/12) but the denominator is itself a judgment call. Why 12 needs and not 15 or 8? The "Walk-in information" need is counted separately from "Same-day availability above fold" and "Saturday hours" -- these could reasonably be collapsed into one need or expanded into five. The granularity of the denominator affects the magnitude of the reported difference.

### Writing and Presentation

The paper is well-written. The prose is clear, specific, and avoids hype. The tables are well-structured and the feature comparison (Table 1) is particularly effective -- it lets the reader see the differences without interpretation. The quotes from the customer agent's evaluations (Section 6.2) are vivid and concrete. The cost-quality tradeoff discussion (Section 6.5) is pragmatic and honest.

Minor presentation issues:

- The paper is written in Markdown, not in CHI proceedings format. For submission, it must be formatted in the ACM two-column template with proper citation formatting.
- The abstract is 280 words, which is long for CHI (typically 150 words). It should be tightened.
- Some claims in the abstract are repeated nearly verbatim in the introduction, creating redundancy.
- The paper uses American spelling ("behavior," "color") in some places and British spelling ("orthopaedic," "specialised") in others. Pick one and be consistent.
- Section 5 is titled "Results" but mixes quantitative comparison (Tables 1-4) with qualitative analysis (Sections 5.5-5.6). Consider splitting into "Quantitative Results" and "Qualitative Analysis."
- The appendices are valuable but Appendix B's per-persona score table should be referenced from the main text discussion of Table 3.

### Reproducibility

Strengths: All three HTML artifacts are available. The creative studio's intermediate artifacts (brief, brainstorm, creative direction, design spec, copy doc, customer reviews) are all in the repository. The ICP, design system, brand guidelines, and product documentation are available. This is unusually complete.

Gaps:
- The model version is specified only as "Claude Opus" -- no version number, no API date, no snapshot identifier. Model behavior changes across versions.
- No random seeds are reported.
- No execution logs or token counts are provided -- the "~50K / ~100K / ~500K+" estimates are approximate with no methodology for estimation.
- The skill and workflow agent configurations (system prompts, tool definitions) are not included in the paper or appendices. How the methodology was "loaded into context" for the skill approach is not specified with enough detail to reproduce.
- Wall-clock times (3 min / 4 min / 32 min) are reported without hardware specification.

### Ethics and Broader Impact

The paper does not discuss the ethics of generating fabricated medical content. The creative studio produces a page for "Dr. Sarah Mitchell, MD" at "St. David's Medical Center" in "Austin, TX" -- a fictional surgeon at a real hospital (St. David's Medical Center is a real Austin hospital). If this page were deployed or indexed by search engines, it could mislead patients searching for orthopaedic care in Austin. The phone number (512) 555-0147 uses a real area code with a reserved exchange, but the practice address (4200 Medical Parkway, Suite 310, Austin, TX 78756) could correspond to a real address. The paper should acknowledge the risks of LLM-generated medical content that blends real and fictional entities.

The environmental cost of the creative studio (500K+ tokens per page) is mentioned as a tradeoff but not discussed as an ethical concern. If this approach were adopted at scale for every page of a website, the cumulative compute cost is substantial.

## Questions for the Authors

1. **Ablation:** Would you be willing to run the creative studio pipeline without the customer evaluation agent (multi-agent generation without feedback loops) and compare the output to the full pipeline? This is the single most important experiment missing from the paper. Without it, the feedback loop's contribution cannot be isolated from multi-agent generation.

2. **Prompt sensitivity:** If the prompt were changed to "Build a 3-section homepage for Dr. Sarah Mitchell's orthopaedic surgery practice at St. David's Medical Center in Austin, TX. Include office hours, insurance information, patient testimonials, and an appointment booking form," would the skill approach produce output comparable to the creative studio? The paper's central claim depends on the answer.

3. **Replication:** Have you run any of the three approaches more than once? If so, how much variance did you observe? If a second run of the skill approach happened to include a surgeon name and location, would it change the paper's conclusions?

4. **Creative studio Round 1 vs. skill/workflow:** The Round 1 customer review (verified in the repository) shows the creative studio's initial build had placeholder names, no header/footer, and dead-end CTAs -- remarkably similar to the skill and workflow outputs. Why is this comparison not in the paper? It would substantially strengthen the feedback loop argument.

5. **Evaluation criteria derivation:** How were the 12 persona needs in Table 2 selected? Were they defined before or after seeing the outputs? If after, there is a risk of post-hoc rationalization (selecting criteria that favor the creative studio's output).

6. **Real-world validation:** Do you have any plans to deploy any of these three pages and measure actual patient behavior (click-through rates, form submissions, phone calls)? Even a short A/B test would transform this case study into an empirical contribution.

7. **Generalizability beyond healthcare:** The ICP document is unusually detailed for this experiment. Many real-world projects have thinner persona documentation. Does the creative studio's advantage depend on the richness of the ICP, or does it emerge even with minimal persona descriptions?

## Missing References

- **Park et al. (2023). "Generative Agents: Interactive Simulacra of Human Behavior."** UIST 2023. Directly relevant to persona-based agent evaluation -- this work demonstrates LLMs adopting persistent personas for behavioral simulation, which is closely related to the customer agent's persona adoption in this paper.

- **Bai et al. (2022). "Constitutional AI: Harmlessness from AI Feedback."** Anthropic technical report. Relevant to the concept of AI self-evaluation and feedback loops improving output quality, which is the paper's core mechanism.

- **Madaan et al. (2023). "Self-Refine: Iterative Refinement with Self-Feedback."** NeurIPS 2023. Directly relevant baseline -- single-agent self-refinement through iterative feedback. The paper should compare its multi-agent feedback loop to single-agent self-refinement approaches.

- **Shinn et al. (2023). "Reflexion: Language Agents with Verbal Reinforcement Learning."** NeurIPS 2023. Another self-refinement approach that uses verbal feedback for improvement. Relevant as a baseline for understanding when multi-agent feedback outperforms single-agent reflection.

- **Huang et al. (2023). "Benchmarking LLMs as AI Research Agents."** (MLAgentBench). Relevant to the broader question of evaluating LLM agent architectures on complex tasks.

- **Chan et al. (2023). "ChatEval: Towards Better LLM-based Evaluators through Multi-Agent Debate."** Relevant to multi-agent evaluation methodology.

- **Design Sprint methodology (Knapp, 2016). "Sprint: How to Solve Big Problems."** The creative studio's phased pipeline mirrors the design sprint methodology. This connection should be acknowledged in related work.

- **Nielsen Norman Group research on medical website design.** There is substantial practitioner literature on what patients need from healthcare websites that could ground the evaluation criteria in established UX research rather than the authors' ICP document alone.

## Minor Issues

1. **Abstract, line 10:** "persona-grounded feedback loops" -- define "grounded" briefly on first use, or readers may interpret it differently (grounded in data? grounded in theory? grounded in personas?).

2. **Section 1, line 22:** "brainstorm-then-build pipeline" -- this is Section 3's terminology; in Section 1 it should be introduced with slightly more context.

3. **Section 3.1, Table:** The "Model" row says "Claude Opus (identical for all agents across all approaches)" but does not specify the model version, API date, or whether it was a specific snapshot. Model behavior varies across versions.

4. **Section 3.2, Approach 2:** "call the `brainstorming` skill" -- backtick formatting for a skill name should be consistent. Sometimes it is backtick-quoted, sometimes not.

5. **Section 5.1, Table 1:** The "Estimated tokens" row uses approximate values (~50K, ~100K, ~500K+). The methodology for estimation is not described. Were these measured from API responses or estimated from context window usage?

6. **Section 5.3, Table 2:** The scoring (Yes/No/Partial) is not defined. What constitutes "Partial" vs. "No"? The skill approach gets "Partial" for "Surgeon credentials visible" via an eyebrow text -- how is this different from "No"?

7. **Section 5.4:** "Zero functional conversion paths" is stated for both the skill and workflow approaches. The skill approach has a `tel:` link to a fake number -- is this a "functional" path with bad data, or a non-functional path? The distinction matters for the counting methodology.

8. **Section 5.5, Table 3:** The round 1 and round 2 scores are averages across three personas, but Appendix B shows significant per-persona variance (e.g., Conviction ranges from 4 to 5 in Round 1). Reporting only averages obscures this variance. Consider adding standard deviations or ranges.

9. **Section 5.7, Table 4:** "Personas addressed (of 12 needs)" uses 12 as the denominator, but the ICP document (verified in the repository) actually has four segments, not three -- Youth Athletes and Parents is the fourth. The paper only evaluates against three segments. This should be acknowledged.

10. **Section 6.2:** The blockquote about the broken CTA is attributed to the customer agent but appears in the Round 1 review under "Why I Would Walk Away" for the Active Adult persona. The paper should cite the specific artifact for transparency.

11. **Section 6.3:** "a single agent operating as a builder has no mechanism to adopt the patient's viewpoint" -- this is asserted but not tested. A single agent could be prompted to "evaluate your output from the perspective of a 68-year-old patient." Self-Refine (Madaan et al., 2023) demonstrates this capability. The claim requires comparison to single-agent self-evaluation, not just single-agent generation.

12. **Mixed spelling throughout:** "behaviour" vs. "behavior," "organised" vs. "organized," "specialised" vs. "specialized." Choose one convention (American for ACM proceedings) and apply consistently.

13. **Section 2.4:** "A page that passes all accessibility checks but provides no booking mechanism is functionally correct yet experientially worthless." -- This is a strong claim. "Worthless" is hyperbolic. A page with correct accessibility but no booking form still has informational value.

14. **References:** Several references use "arXiv preprint" format but some of these papers have since been published at conferences (e.g., MetaGPT at ICLR 2024, ChatDev at ACL 2024). Update to published versions.

15. **References [7-12]:** The persona literature is dated (1999-2019). More recent work on computational personas and LLM-generated personas should be cited.

## Recommendation Summary

The paper presents a genuinely interesting finding -- that persona-grounded evaluation loops in multi-agent LLM systems produce qualitatively different web design output -- and supports it with unusually transparent artifact documentation. The grounded feedback framework (Section 4) is the paper's strongest novel contribution and deserves publication. However, the paper suffers from three critical methodological gaps: (1) N=1 with no replication, making it impossible to distinguish architectural effects from stochastic variation; (2) no ablation isolating the feedback loop's contribution from multi-agent generation; and (3) no human evaluation, which is particularly problematic for a CHI submission. The experimental design also conflates multiple architectural changes (agent count, creative roles, feedback loops) under a single independent variable, preventing clean causal attribution.

The path to publication requires: (a) running each architecture multiple times to establish reliability, (b) adding a fourth condition (multi-agent without feedback) to isolate the feedback loop's contribution, (c) conducting at minimum a small human evaluation study, and (d) reframing from "controlled experiment" to "controlled case study." The contribution is worth pursuing -- the feedback framework is novel and the practical implications are clear -- but the evidence must be strengthened before the claims can be accepted.
