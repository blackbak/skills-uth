# Research Brief Template

Write the brief to `docs/papers/<paper-slug>/brief.md` using this structure.

---

```markdown
# Research Brief: [Title]

**Date:** YYYY-MM-DD
**Paper slug:** [lowercase-hyphenated-identifier]
**Target venue:** [NeurIPS | ICML | ICLR | AAAI | ACL | CVPR | EMNLP | KDD | JMLR | TMLR | other]
**Status:** active

## Research Question

[1-3 sentences stating the specific question this paper answers. Must be falsifiable or empirically testable. Not a topic area -- a question.]

## Motivation

[Why does this question matter? What practical or theoretical gap exists? Who benefits from the answer? 3-5 sentences.]

## Scope

**In scope:**
- [Specific problem, dataset domain, method family]
- [Specific comparison or evaluation]

**Out of scope:**
- [What this paper deliberately does NOT address]
- [Adjacent problems that are tempting but dilute the contribution]

## Hypothesized Contribution

[What do you expect the paper to contribute? Be honest -- this is a hypothesis, not a claim. 2-3 sentences.]

**Contribution type:** [New method | New benchmark | Empirical study | Survey | Theoretical analysis | Reproduction study]

## Key Constraints

- **Compute budget:** [Available hardware, max training time, cloud budget]
- **Data access:** [Public datasets only | Private data available | Synthetic data needed]
- **Timeline:** [Target submission deadline, if any]
- **Collaborators:** [Solo | Team -- relevant for workload distribution]
- **Ethical considerations:** [Any sensitive data, dual-use concerns, or IRB requirements]

## Initial References

[3-5 most relevant papers that frame the research space. The literature review will expand this.]

1. [Author et al., Year. "Title." Venue.] -- [Why it matters to this work]
2. [Author et al., Year. "Title." Venue.] -- [Why it matters to this work]
3. ...

## Success Criteria

[How will you know the paper is done and good? Be specific.]

- [ ] Research question is answered with evidence
- [ ] Experiments are reproducible (seeds, hyperparameters, code documented)
- [ ] Baselines are strong and fairly compared
- [ ] Ablations isolate each component's contribution
- [ ] Writing is clear to a knowledgeable non-specialist
- [ ] Limitations are honestly stated
```
