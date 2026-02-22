# Research Brief: Skill Architecture Matters — How Autonomous Feedback Loops Transform LLM Agent Design Quality

**Date:** 2026-02-22
**Paper slug:** grounded-agent-feedback
**Target venue:** ACM CHI 2027 (Conference on Human Factors in Computing Systems) — Case Study track
**Preprint:** arXiv (cs.HC / cs.AI cross-list)
**Status:** active

## Research Question

Does the structural scaffolding (skill architecture) around an LLM agent — not model capability, prompt engineering, or design system completeness — determine the quality of autonomous web design output? Specifically, does persona-grounded evaluation feedback produce qualitatively different (not just incrementally better) design artifacts compared to methodology injection or workflow pipelines?

## Motivation

LLM agents can generate functional web pages, but practitioners lack guidance on how to structure agent workflows for quality outcomes. The prevailing assumption is that model capability is the primary quality driver. This paper challenges that assumption with a controlled experiment showing that architectural scaffolding — particularly grounded evaluation feedback loops — is the critical differentiator. This matters for practitioners building agent-powered design tools and for researchers studying multi-agent collaboration.

## Scope

**In scope:**
- Controlled comparison of three skill architectures (methodology injection, workflow pipeline, creative studio with feedback loops)
- Single domain: orthopaedic surgery practice homepage
- Evaluation across content completeness, persona coverage, conversion paths, design compliance, accessibility
- Cost-quality tradeoff analysis

**Out of scope:**
- Cross-domain generalization (acknowledged as future work)
- Human evaluation studies (acknowledged as limitation)
- A/B testing of deployed pages
- Cross-model comparisons

## Hypothesized Contribution

Skill architecture, not model capability, is the primary determinant of autonomous design quality. The critical mechanism is grounded evaluation — persona-specific, dimensionally scored, behaviorally anchored feedback loops that surface content gaps no amount of methodology or brainstorming alone can identify.

**Contribution type:** Empirical study

## Key Constraints

- **Compute budget:** All experiments completed; token costs documented (50K, 100K, 500K+)
- **Data access:** All artifacts available in repository (three HTML outputs, creative studio process artifacts)
- **Timeline:** ACM CHI 2027 submission
- **Collaborators:** Solo
- **Ethical considerations:** No human subjects; fictional patient data used in experiment outputs

## Initial References

1. Hong et al., 2023. "MetaGPT." arXiv. — Multi-agent role specialization baseline
2. Zheng et al., 2023. "Judging LLM-as-a-judge." NeurIPS. — LLM evaluation methodology
3. Matthews et al., 2012. "Personas in practice." CHI. — Persona effectiveness in design
4. Cooper, 1999. "The inmates are running the asylum." — Goal-directed personas foundation
5. Chen et al., 2021. "Evaluating LLMs trained on code." — Code generation evaluation baseline

## Success Criteria

- [x] Research question is answered with evidence
- [x] Experiments are reproducible (all artifacts in repo)
- [x] Baselines are strong and fairly compared (same prompt, model, design system)
- [ ] Ablations isolate each component's contribution
- [x] Writing is clear to a knowledgeable non-specialist
- [x] Limitations are honestly stated
