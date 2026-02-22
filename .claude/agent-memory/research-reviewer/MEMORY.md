# Research Reviewer Memory

## Project Context
- Paper: "Skill Architecture Matters: How Autonomous Feedback Loops Transform LLM Agent Design Quality"
- Target venue: ACM CHI 2027 Case Study track
- Repository contains full experiment artifacts (HTML outputs, customer reviews, brainstorm docs)
- All HTML outputs are in `/Users/knitlybak/GitHub/skills-uth/presentation/experiment/{skill,workflow,creative-studio}/index.html`
- Creative studio workspace artifacts in `/Users/knitlybak/GitHub/skills-uth/docs/studio/`

## Review Patterns Learned
- Always verify line counts with actual file examination (rg -c counts non-empty lines, wc -l counts all lines including blank)
- Check for timeline discrepancies between customer review documents and final artifacts (R2 review may evaluate an intermediate state, not the final file)
- Form `action="#"` with `e.preventDefault()` is NOT a functional backend submission -- it is a UI prototype
- When authors claim "functional conversion paths," verify whether data actually transmits
- Score progression tables may reflect evaluations of intermediate states, not final outputs
- On resubmission reviews: verify EVERY claim in the response letter against the actual paper (use grep for key phrases)
- Track whether response letter claims map 1:1 to actual changes (create a verification table)
- When reviewing Round 3+, create a running tally of what was addressed vs. what persists -- distinguish between "addressed" and "acknowledged but not resolvable"
- N=1 and no-human-eval are legitimate grounds for Major revision but not rejection at CHI Case Study track, provided they are honestly acknowledged
- Self-referential scoring (same agent flags issues and then scores their resolution) is a real methodological concern worth flagging but not fatal

## Verification Checklist for This Paper
- [x] Line counts verified (off by 1 each, acceptable)
- [x] CTA dead-end behavior verified across all three approaches
- [x] Booking form exists in final creative-studio HTML (lines 1487-1509)
- [x] R2 customer review evaluates pre-form state (P1 issue about missing form)
- [x] Testimonials verified (Marcus T., Linda R., Jennifer P.)
- [x] Skip link: present in creative-studio, absent in skill and workflow
- [x] Insurance carriers named in footer only (BCBS, Aetna, Cigna, UHC)
- [x] "Precision Ortho" in skill, "Orthopaedic Care" in workflow -- verified

## Review History
- Round 1: MAJOR REVISION (6 weaknesses: N=1, no human eval, confounded IV, asymmetric criteria, missing ablation, overclaimed experiment status)
- Round 2: MINOR REVISION (3 weaknesses: booking form timeline discrepancy, N=1 persists, no human eval persists; plus score self-referentiality and conversion path overstatement)
- Round 3: ACCEPT (2 acknowledged Major weaknesses persist: N=1 and no human eval, but both honestly stated as primary limitations with concrete future work protocols; all Round 2 comments verified as addressed)
