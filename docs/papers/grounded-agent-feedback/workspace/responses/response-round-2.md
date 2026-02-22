# Response to Review: Round 2

**Paper:** Skill Architecture Matters: How Autonomous Feedback Loops Transform LLM Agent Design Quality
**Review round:** 2
**Verdict received:** MINOR REVISION
**Revision date:** 2026-02-22

---

We thank the reviewer for a thorough and careful re-evaluation. The artifact verification, timeline analysis of the booking form, and precise minor issue list have each led to targeted improvements. Below we address every comment.

---

## Response to Weaknesses

### W1: Factual discrepancy between paper and customer review on booking form status (Major)

> "The paper states in Section 5.4: 'The hero CTA links to #contact, scrolling to a section with a three-field appointment request form...' However, the Round 2 customer review document identifies the booking mechanism as a P1 issue that remains partially unresolved: 'But there is still no actual booking mechanism: no form, no Calendly link, no external scheduling URL.' I verified the actual HTML and a booking form IS present in the final file. This means the form was added AFTER the Round 2 customer review was written but BEFORE the file was finalized."

**Response:** The reviewer's timeline reconstruction is correct. We investigated the artifact sequence and confirmed:

1. The Round 2 customer review evaluated the build *before* the booking form was added. The R2 scores in Table 3 and Appendix B reflect this pre-form state.
2. The booking form was added as a post-evaluation fix directly addressing the R2 customer review's top P1 finding ("no actual booking mechanism").
3. The customer agent never re-scored the output after the form was added. The form-equipped version was never evaluated.

In the revision, we have:

- Added an explicit timeline clarification in Section 5.4 (paragraph 5, new) stating that the appointment request form was added in response to the R2 customer review's P1 finding and was not present when R2 scores were assigned.
- Added a footnote to Table 3 clarifying that R2 scores reflect the pre-form build.
- Updated the Appendix B Active Adult Flow entry driver text to be consistent with the main text timeline (see Minor Issue 7 below).
- Revised Section 5.5 to note that the Flow scores specifically reflect the dead-end CTA state, and the form was a post-evaluation addition.
- Revised the "Booking mechanism" row description in Table 1 to note that the form is client-side only (see W2 and Minor Issue 2 below).

### W2: The "functional conversion path" claim is overstated (Minor)

> "The booking form has `action='#'` and the JavaScript handler calls `e.preventDefault()`, changes the button text for 3 seconds, then resets the form. No data is transmitted. [...] Calling it 'functional' alongside the `tel:` link (which does initiate a real phone call) conflates two very different levels of functionality."

**Response:** The reviewer is correct. The form and the phone link operate at fundamentally different levels of functionality. In the revision, we have:

- Revised Section 5.4 to distinguish between "interactive" and "functional" conversion paths. The form is now described as "an interactive appointment request form (client-side only; captures name, phone, and reason for visit but transmits no data to any backend)" and the phone `tel:` link as "a functional phone conversion path (initiates a real phone call)."
- Updated Table 1's "Booking mechanism" row for Creative Studio R2 to read: "Appointment request form (client-side only, no backend) + phone `tel:` link"
- Updated the conversion path count in Section 5.4 to: "one interactive conversion path (the appointment request form) and one functional conversion path (the phone `tel:` link), plus a secondary phone path via the header."
- Updated Table 4 to reflect the revised count: "1 interactive + 1 functional" rather than "2."
- Applied the same distinction consistently in the abstract, Section 5.7, and Section 6.5.

### W3: N=1 with no replication remains (Major, reduced from Critical)

> "The revision appropriately reframes the contribution as a case study and softens causal language. However, the fundamental N=1 limitation persists [...] Consider running the skill approach (the cheapest at ~50K tokens, 3 minutes) two additional times."

**Response:** We agree that even two additional runs of the cheapest approach would strengthen the case. We cannot conduct these additional runs within this revision cycle due to resource constraints (the API billing account used for the original experiment is not available for follow-up runs within this submission window). In the revision, we have:

- Added an explicit acknowledgment in Section 6.6 that we were unable to run additional replications for this revision and that this remains the study's primary methodological limitation.
- Strengthened the replication protocol in Section 7 (Future Work) to specifically include the reviewer's suggestion: "As a minimal first step, run the skill approach (the cheapest condition at ~50K tokens, 3 minutes) two additional times. If those runs also produce 0-1/12 persona needs, report this as supplementary evidence that the content gap is not a single-run artifact."
- The replication protocol already specifies 5 runs per architecture across at least two additional domains, which subsumes the reviewer's suggestion.

### Score self-referentiality (Minor, from Detailed Comments)

> "The customer agent that assigns scores in Table 3 is the same agent that identified the deficiencies in R1. Has any consideration been given to whether this creates a scoring bias?"

**Response:** The reviewer identifies a real concern. In the revision, we have:

- Added a note in Section 5.5 (paragraph following Table 3) acknowledging the self-referential scoring dynamic: the customer agent both sets the evaluation criteria (by flagging deficiencies) and then re-evaluates whether those deficiencies were addressed, creating a built-in confirmation bias toward scoring additions positively.
- Added a brief discussion noting that this dynamic likely inflates the delta magnitudes but does not invalidate the directional finding (content was absent, then present). The scores should be interpreted as evidence that the flagged gaps were addressed, not as independent quality assessments.

---

## Response to Questions for Authors

### Q1: Booking form timeline

> "Was the form added after the R2 customer evaluation? If so, do the scores in Table 3 and Appendix B reflect the pre-form or post-form state?"

**Response:** Yes. The form was added after the R2 customer evaluation, in direct response to the R2 review's top P1 finding. The scores in Table 3 and Appendix B reflect the pre-form state. The revised paper states this explicitly in Section 5.4, Table 3 footnote, and Section 5.5. See W1 above for full details.

### Q2: Form functionality

> "In what sense is this a 'functional conversion path'? Would you be willing to distinguish between 'interactive' (UI prototype) and 'functional' (data-transmitting) conversion paths?"

**Response:** Yes. The revised paper makes this distinction throughout. See W2 above for full details.

### Q3: Score self-referentiality

> "Has any consideration been given to whether this creates a scoring bias?"

**Response:** Yes. The revised paper acknowledges this explicitly. See the "Score self-referentiality" response above.

### Q4: Minimal replication

> "Running the skill approach two additional times would cost approximately 100K tokens (about 6 minutes). Would you be willing to do this?"

**Response:** We would be willing but cannot execute within this revision cycle. See W3 above for details.

---

## Response to Missing References

### Si et al. (2024). "Design2Code." ICML 2024.

**Response:** Added as reference [23]. Cited in Section 2.4 (Code Generation Quality) as a directly relevant benchmark for evaluating LLM-generated web design quality, complementing HumanEval's focus on functional correctness with visual fidelity and implementation accuracy metrics.

### Yang et al. (2024). "InterCode." ICLR 2024.

**Response:** Added as reference [24]. Cited in Section 2.4 alongside Design2Code, noting the parallel between InterCode's execution feedback improving code generation and our grounded evaluation feedback improving design generation.

---

## Response to Minor Issues

### M1: Phone `tel:` link functionality distinction

> "The skill approach's `tel:` link to `(555) 123-4567` is equally dialable. The difference is plausibility, not functionality."

**Response:** The reviewer is correct. In the revised Section 5.4, we now state: "While the `tel:` link is technically functional (the call would dial), the obviously fictitious 555 number cannot reach a real practice." We apply the same framing to the creative studio's `tel:` link: "The phone `tel:` link initiates a real phone call, though the `(512) 555-0147` number uses the reserved 555 exchange and cannot reach a real practice." The distinction between the skill and creative studio phone paths is plausibility (local area code vs. obvious 555), not technical functionality. Both are equally dialable; neither reaches anyone. This is now stated explicitly.

### M2: Table 1 booking mechanism row -- note client-side only

> "The 'Booking mechanism' row for Creative Studio R2 says 'Appointment request form (name, phone, reason)' but does not note that the form is client-side only with no backend."

**Response:** Revised. The row now reads: "Appointment request form (client-side only, no backend) + phone `tel:` link." See W2 above.

### M3: Table 2 "Surgeon name and face" -- acknowledge face as hard constraint

> "If the creative studio cannot provide a face (because no photo exists), this is a hard constraint shared by all approaches and should not be counted against or for any of them."

**Response:** The reviewer makes a fair point. In the revised Table 2, we have added a footnote to the "Surgeon name and face" row: "No approach can provide a surgeon photograph because no photograph exists in the reference documents. This is a hard constraint shared by all approaches. The creative studio's partial coverage (name yes, face no) reflects this constraint, not a design failure." The 10/12 count for Creative Studio R2 remains unchanged because the row was already scored as partial ("Name yes, face no"), not as fully addressed.

### M4: Section 6.2 quote attribution verified

> "The quote in the paper uses a period after 'I am closing this tab' while the actual customer review document uses the same phrasing. Minor consistency verified."

**Response:** No change needed. The reviewer confirms the attribution is accurate.

### M5: Section 6.3 section reference should say "Section 7" not "Section 8"

> "Section 8 is now the Conclusion, not Future Work (which is Section 7). The reference should say 'Section 7' not 'Section 8.'"

**Response:** Corrected. The reference in Section 6.3 now reads "requiring the ablation proposed in Section 7" (was "Section 8").

### M6: Section 8.1 ethics -- promote to standalone section

> "Ethics statements in CHI papers are typically standalone sections, not subsections of the conclusion. Consider promoting this to a top-level section."

**Response:** Promoted. The ethics statement is now Section 9 ("Ethics Statement"), a standalone top-level section following the Conclusion (Section 8). Subsequent numbering is adjusted accordingly.

### M7: Appendix B Active Adult Flow contradiction with main text

> "R1 = 6, R2 = 6, Delta = 0. The driver column says 'Booking CTA still dead-end (form added but section CTA persists).' This description matches the Round 2 customer review's finding but contradicts the paper's main text claim that a booking form provides a conversion path."

**Response:** The driver text was written when the paper described the R2 build as having a form, but the scores reflect the pre-form build where the CTA was indeed still a dead end. In the revision, we have:

- Updated the Appendix B Active Adult Flow driver to: "Booking CTA remains dead-end in evaluated build; form added post-evaluation (see Section 5.4)."
- This is now consistent with the main text, which clarifies that R2 scores reflect the pre-form state.

### M8: Table 3 R2 average 7.2 below 8/10 threshold -- explain why no third iteration

> "The paper does not explain why a third iteration was not triggered."

**Response:** The creative studio skill's iteration logic specifies: "If the average score falls below 8/10 and the round count is below 3, the pipeline loops back." The R2 average of 7.2 is below 8/10 and the round count was 2 (below 3), so a third iteration should have been triggered by the skill's own logic. In practice, the orchestrating agent addressed the R2 review's top P1 finding (the missing booking form) as a targeted post-evaluation fix rather than re-entering the full design-copy-build loop. This was a pragmatic deviation from the skill's specified iteration protocol. In the revision, we have added a footnote to Table 3 explaining this: "The R2 average of 7.2 falls below the 8/10 re-iteration threshold. The orchestrator addressed the R2 review's top P1 finding (missing booking form) as a targeted post-evaluation fix rather than triggering a full third iteration. The customer agent did not re-score after this fix."

### M9: Section 2.3 Salminen distinction -- personas are human-authored

> "The creative studio's personas are not LLM-generated; they are human-authored ICP documents. This distinction should be stated explicitly."

**Response:** Revised. Section 2.3 now includes: "Unlike Salminen et al.'s LLM-generated personas, our customer agent evaluates through human-authored ICP documents with documented user research foundations. The personas are not generated by the LLM; they are loaded as evaluation contracts that the LLM must adopt." This directly addresses the reviewer's concern.

### M10: Reference [19] Nielsen Norman Group -- verify citation in body or remove

> "Reference [19] is cited in the bibliography but I could not find where it is cited in the paper text. If it is not cited in the body, remove it from the bibliography."

**Response:** Confirmed. Reference [19] appears only in the bibliography, not in the body text. It has been removed from the bibliography in the revised paper. References previously numbered [20]-[25] have been renumbered accordingly.

---

## Summary of Changes

| Change | Location in v3 |
|--------|---------------|
| Booking form timeline clarified | Section 5.4 (new paragraph 5), Table 3 footnote, Section 5.5 |
| "Functional" vs. "interactive" conversion paths distinguished | Section 5.4, Table 1, Table 4, Abstract, Section 5.7, Section 6.5 |
| N=1 replication infeasibility acknowledged | Section 6.6, Section 7 |
| Score self-referentiality discussed | Section 5.5 (new paragraph after Table 3) |
| Section 6.3 reference corrected (Section 8 -> Section 7) | Section 6.3 |
| Ethics statement promoted to standalone Section 9 | Section 9 (was Section 8.1) |
| Appendix B Active Adult Flow driver text corrected | Appendix B |
| Table 3 R2 threshold deviation explained | Table 3 footnote |
| Salminen distinction (human-authored vs. LLM-generated personas) | Section 2.3 |
| Reference [19] removed (not cited in body) | Bibliography |
| Table 2 "Surgeon name and face" footnote added | Table 2 footnote |
| Table 1 booking mechanism row updated (client-side only) | Table 1 |
| Phone `tel:` link plausibility distinction clarified | Section 5.4 |
| Design2Code [23] and InterCode [24] references added | Section 2.4, Bibliography |
| Table 3 R2 average below threshold explained | Table 3 footnote |
