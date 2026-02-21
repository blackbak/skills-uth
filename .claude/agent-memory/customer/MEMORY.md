# Customer Agent Memory

## Project Context
- Orthopaedic surgery practice website. NOT a tech/AI company (despite the agent system prompt referencing 4GPTs personas).
- Target audience: patients in pain searching for a surgeon. Three segments: active adults (30-55), older adults (55+), acute injury patients.
- Key context files: `docs/BUSINESS/ICP.md`, `docs/BUSINESS/PRODUCT.md`, `docs/DESIGN/BRAND.md`, `docs/DESIGN/DESIGN_SYSTEM.md`.

## Evaluation Patterns
- For healthcare/medical sites, always check: location info, insurance, hours, real provider name, working booking path, hospital affiliations.
- Placeholder content (bracket names, 555 numbers) is always P1 -- it destroys credibility for medical decisions.
- Dead-end CTAs (self-referencing anchor links) are the highest-severity flow issue.
- Dual CTA (online + phone) is important for older patient segments.
- Acute injury patients need urgency signals above the fold.

## Round 1 Status
- Review written to `docs/studio/customer-review-round-1.md`
- Creative direction adherence was strong; failures were all "last mile" (placeholder content, no real booking path, no nav/footer).
- 5 P1 issues, 5 P2 issues identified across 3 persona evaluations.

## Round 2 Status
- Review written to `docs/studio/customer-review-round-2.md`
- 3 of 5 original P1 issues fully resolved, 1 significantly improved, 1 partially resolved.
- Remaining P1: section 4 "Book an Appointment" CTA still self-references `#contact` (same section it sits in). No actual booking form or external scheduling link exists.
- Major additions: urgent banner, testimonials, header/footer, hospital affiliation, insurance info, empathy line.
- Phone conversion path is now fully functional. Online booking path is not.
- Nothing regressed from round 1. All changes were improvements.
- Page is close to shippable; booking mechanism is the single blocking issue.
