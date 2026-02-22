# Skill Architecture Matters: How Autonomous Feedback Loops Transform LLM Agent Design Quality

**Venue:** ACM CHI 2027 (Conference on Human Factors in Computing Systems) -- Case Study track
**Preprint:** arXiv (cs.HC / cs.AI cross-list)
**Version:** Camera-ready

---

## Abstract

Large language model agents can generate functional web pages, but output quality depends on the architectural scaffolding around generation. We present a controlled case study comparing three skill architectures -- methodology injection, workflow pipeline, and creative studio with persona-grounded feedback loops -- given identical prompts, model, and design system to build an orthopedic surgery practice homepage. The methodology-injection and workflow approaches produced visually competent templates lacking surgeon identity, location, and conversion paths. The creative studio, at 10x token cost, produced a page with a named surgeon, real location, persona-matched testimonials, and an interactive appointment request form. Critically, the creative studio's pre-feedback output exhibited the same content gaps as single-agent approaches; content additions emerged only after a customer agent evaluated through specific user personas. We propose grounded evaluation -- feedback anchored in user personas, scored across behavioral dimensions, and classified by behavioral consequence -- as the mechanism driving this difference.

**Keywords:** LLM agents, skill architecture, autonomous design, grounded feedback, persona-based evaluation, multi-agent collaboration

---

## 1. Introduction

The rapid adoption of large language model (LLM) agents as autonomous code generators has raised a fundamental question: what determines the quality of their output? The prevailing assumption is that model capability is the primary factor -- a more capable model produces better results. Our case study challenges this assumption by holding the model constant and varying only the **skill architecture** -- the structural scaffolding that shapes how the agent approaches a task.

We define three levels of skill architecture, each adding a layer of process around the same base model:

1. **Methodology injection.** A skill that loads design principles, validation tests, and anti-patterns directly into the agent's context window. The agent builds the deliverable in a single pass, guided by these internalized rules. One agent, one perspective, no external feedback.

2. **Workflow pipeline.** A skill that enforces a multi-phase process -- enforcing a brainstorming phase (exploring design intent, hierarchy, and interaction states) before implementation. The same agent does all the work, but is forced to think before building. One agent, one perspective, structured thinking.

3. **Creative studio with feedback loops.** A skill that orchestrates multiple specialized agents -- a brand designer, a copywriter, an expert developer, and a customer persona evaluator -- through a six-phase pipeline with iterative feedback loops. The customer agent evaluates the output through specific user personas, scores it against a five-dimension rubric, and classifies findings by severity. If scores fall below a threshold, the entire design-copy-build cycle repeats. Multiple agents, multiple perspectives, grounded evaluation.

All three approaches received an identical prompt: "Build a 3-section homepage for our orthopedic surgery practice. Single self-contained index.html file. No stock photo URLs." All three had access to the same design system tokens, brand guidelines, ideal customer profiles, and product documentation. The only independent variable was the skill architecture.

The results are stark. The methodology-injection skill (~50K tokens, 3 minutes) produced a visually polished page with animated gradient orbs, a wave divider, and scroll reveal effects -- but no surgeon name, no practice location, no testimonials, no insurance information, and a booking button that linked to `#contact` with no actual booking mechanism. The workflow skill (~100K tokens, 4 minutes) produced a structurally cleaner page with a documented design rationale -- but identical content gaps. The creative studio (~500K+ tokens, 32 minutes) produced a page with "Dr. Sarah Mitchell, MD" at St. David's Medical Center in Austin, TX, three persona-matched patient testimonials, an urgent care banner, an interactive appointment request form (client-side only), insurance carrier names, office hours, and an empathy line addressing pre-surgical anxiety.

Crucially, the creative studio's Round 1 output -- before any customer feedback -- exhibited the same content gaps as the skill and workflow approaches: placeholder surgeon name, fake phone number, dead-end CTA, no header or footer, no location or insurance information. The content additions that distinguish the final output emerged only after the customer agent evaluated through three patient personas and identified their absence as bounce triggers. The novelty is not in multi-agent orchestration per se, but in the specific evaluation methodology: persona-grounded, dimensionally scored, behaviorally anchored feedback.

This paper makes three contributions:

1. **Empirical evidence** from a controlled case study that skill architecture is a primary determinant of autonomous design quality when model, prompt, and reference documents are held constant.
2. **A grounded feedback framework** that transforms generic LLM critique into persona-specific, dimensionally scored, behaviorally anchored evaluation.
3. **A cost-quality tradeoff analysis** showing that the 10x token cost of multi-agent feedback loops produced non-linear quality gains concentrated in the dimensions that matter most for user conversion: conviction and persuasion.

The remainder of this paper is organized as follows. Section 2 reviews related work on multi-agent LLM systems, LLM-as-judge approaches, persona-based design, and code generation quality. Section 3 describes the case study design, including control variables and evaluation criteria. Section 4 presents the grounded feedback framework. Section 5 reports quantitative results. Section 6 provides qualitative analysis, including limitations and the need for ablation. Section 7 proposes prioritized future work. Section 8 concludes. Section 9 addresses ethical considerations.

---

## 2. Related Work

### 2.1 Multi-Agent LLM Systems

Multi-agent architectures have demonstrated advantages over single-agent approaches across software engineering tasks. MetaGPT [1] assigns agents to product manager, architect, engineer, and QA roles, showing that role specialization reduces hallucination. ChatDev [2] models the software development lifecycle as multi-agent conversation. AutoGen [3] provides a framework for multi-agent cooperation. AgentVerse [4] demonstrates that agent collaboration outperforms individual agents on complex reasoning. The creative studio's phased pipeline -- brief, brainstorm, design, copy, build, evaluate -- mirrors the design sprint methodology [19], adapted for autonomous agent execution.

Our work extends multi-agent paradigms to creative design, where quality is not merely functional correctness but subjective user experience. The architectural novelty is not in having multiple agents, but in adding a critical role absent from prior systems: a **customer evaluator** that never produces deliverables, only grounded critique.

### 2.2 LLM-as-Judge and Self-Refinement

Using LLMs to evaluate LLM output has gained traction for text generation tasks. Zheng et al. [5] show that LLM judges approximate human preferences in open-ended generation. Liu et al. [6] demonstrate GPT-4 evaluation correlates with human judgments on summarization. Chan et al. [18] construct ChatEval, a multi-agent referee team that autonomously debates evaluation quality, showing that diverse role prompts improve evaluation accuracy over single-agent approaches. Bai et al. [15] demonstrate that Constitutional AI can improve output quality through AI self-evaluation without human labels, establishing the precedent that feedback loops between generation and evaluation improve results.

Single-agent self-refinement has shown promise as a lighter-weight alternative to multi-agent systems. Madaan et al. [14] demonstrate Self-Refine, where a single LLM generates, critiques, and refines its own output iteratively, improving across seven tasks by approximately 20%. Shinn et al. [16] introduce Reflexion, using verbal reinforcement learning to help agents learn from trial-and-error through linguistic feedback stored in episodic memory.

However, these approaches evaluate text quality in isolation, without the multi-dimensional assessment required for web design -- visual hierarchy, user flow, trust building, and conversion path integrity. Our framework extends LLM-as-judge by requiring the evaluator to adopt a specific user persona with documented motivations and anxieties before issuing any judgment. This bridges the gap between abstract quality assessment and situated user experience evaluation. Whether this multi-agent separation produces inherently better feedback than single-agent self-refinement with persona instructions is an open question that requires the ablation study proposed in Section 7.

### 2.3 Persona-Based Design

Personas have a long history in HCI [7, 8, 9]. Cooper's goal-directed personas [10] represent archetypal users with specific needs. Pruitt and Adlin [11] demonstrate that personas improve design decisions. However, persona use in practice often degrades to superficial archetypes that do not meaningfully influence design [12]. More recently, Park et al. [13] demonstrated that LLMs can adopt and maintain persistent personas for behavioral simulation, producing emergent social behaviors in a simulated town -- establishing that LLM persona adoption produces qualitatively different outputs than generic prompting. Salminen et al. [20] investigated LLM-generated personas at CHI 2024, finding that while such personas are informative and believable, they exhibit biases in demographics and pain points, underscoring the need for grounding persona evaluations in documented user data rather than relying on LLM-generated archetypes alone. Unlike Salminen et al.'s LLM-generated personas, our customer agent evaluates through human-authored ICP documents with documented user research foundations. The personas are not generated by the LLM; they are loaded as evaluation contracts that the LLM must adopt.

We operationalize personas as **evaluation contracts** -- structured documents defining not just demographics and goals, but specific skepticism points, decision factors, and the language the persona uses to describe their problem. The evaluating agent must load this context, adopt the persona's voice, and ground every finding in the persona's behavioral response.

### 2.4 Code Generation Quality

Prior work on LLM code generation has focused primarily on functional correctness -- pass rates on benchmarks like HumanEval [21] and MBPP [22]. Si et al. [23] benchmark LLM-generated web design quality with Design2Code, evaluating visual fidelity and implementation accuracy -- a dimension closer to our concerns than functional correctness alone. Yang et al. [24] demonstrate with InterCode that execution feedback improves LLM code generation, paralleling our finding that evaluation feedback improves design generation. Huang et al. [17] benchmark LLM agents on machine learning experimentation tasks, evaluating architectural choices for complex multi-step agent workflows. Our work evaluates a different dimension: whether generated code produces artifacts that serve *users*, not just artifacts that compile. A page that passes all accessibility checks but provides no booking mechanism is functionally correct yet fails its primary user-serving purpose.

---

## 3. Case Study Design

This section describes a single-instance controlled case study. We hold constant all factors except skill architecture to observe the resulting differences in output quality. The study design lacks randomization, replication, blinding, and statistical analysis; it is a structured comparative analysis appropriate for the CHI Case Study track, not a controlled experiment in the strict methodological sense.

### 3.1 Control Variables

| Variable | Value |
|----------|-------|
| Prompt | "Build a 3-section homepage for our orthopedic surgery practice. Single self-contained index.html file. No stock photo URLs." |
| Model | Claude Opus 4 (claude-opus-4-20250514), accessed via Anthropic API, February 20-21, 2026 |
| Hardware | MacBook Pro (Apple M-series, 36GB RAM), Claude Code CLI |
| Design system | `docs/DESIGN/DESIGN_SYSTEM.md` -- colors (#1B4D7A primary, #2A9D8F accent, #F7F9FC secondary), Inter typeface, 12-column grid, 24px gutters |
| Brand guidelines | `docs/DESIGN/BRAND.md` -- warm, confident, reassuring voice; deep blue for trust, teal for action |
| Patient segments | `docs/BUSINESS/ICP.md` -- active adults (30-55), older adults (55+), acute injury (all ages), youth athletes & parents |
| Product documentation | `docs/BUSINESS/PRODUCT.md` -- services, delivery channels, differentiators |
| Token estimation | Estimated from API billing data (input + output tokens per session); order-of-magnitude approximations, not per-request logs. The billing data is retained in the API provider's dashboard for verification but was not exported as raw logs. |
| Random seeds | Not controllable via the API; stochastic variation is uncontrolled |

### 3.2 Independent Variable: Skill Architecture

**Approach 1 -- Skill: `frontend-design`** (Methodology injection)

A single agent receives the prompt with design methodology loaded into context: Swap Test (would replacing design choices with defaults feel wrong?), Squint Test (does hierarchy hold when blurred?), Signature Test (is there one memorable detail?), Token Test (do all values trace to design system tokens?), Progressive Disclosure principles, and Platform Test (does it work on mobile?). The agent reads the project documentation and builds the entire page in one pass. Full skill definition: `.claude/skills/frontend-design/SKILL.md`.

- Agents: 1
- Phases: 1 (build)
- Feedback loops: 0
- Artifacts: 1 (`index.html`)

**Approach 2 -- Workflow: `feature-frontend`** (Sequential pipeline)

A single orchestrating agent follows a four-phase pipeline: (0) check whether a design system exists and use its tokens as hard constraints, (1) call the `brainstorming` skill to explore design intent, hierarchy, interaction states, and how the feature uses design tokens -- writing a design document, (2) implement bottom-up (atoms to molecules to organisms to pages) following the brainstorm output, (3) commit and create a PR. The brainstorming phase is the key differentiator -- it forces the agent to articulate intent before writing code. Full skill definition: `.claude/skills/feature-frontend/SKILL.md`.

- Agents: 1 (with sub-skill calls)
- Phases: 4 (check, brainstorm, build, ship)
- Feedback loops: 0 (linear pipeline)
- Artifacts: 2 (`design-doc.md`, `index.html`)

**Approach 3 -- Creative Studio: `creative-studio`** (Multi-agent with feedback loops)

An orchestrator coordinates five or more specialized agents through six phases:

1. **Brief preparation.** The orchestrator reads all project documents and writes a structured creative brief.
2. **Brainstorm.** A brand-designer agent and a copywriter agent engage in multi-round dialogue (up to 4 rounds), debating creative directions until they converge on a single direction document -- the immutable contract for all subsequent phases.
3. **Design.** The brand-designer produces a detailed visual specification (layout, components, responsive behavior, accessibility).
4. **Copy.** The copywriter produces all patient-facing text following the messaging direction.
5. **Build.** The expert-developer implements from the design spec and copy doc, using exact copy (no paraphrasing).
6. **Customer review.** A customer agent evaluates the output through each patient persona, scoring across five dimensions (Visual, Copy, Flow, Conviction, Persuasion) with severity-classified findings (P1 bounce triggers, P2 hesitation points, P3 confidence erosion). If the average score falls below 8/10 and the round count is below 3, the pipeline loops back to Phase 3 with targeted feedback.

Full skill definition: `.claude/skills/creative-studio/SKILL.md`.

- Agents: 5+ (brand-designer, copywriter, expert-developer, customer, quality guardians)
- Phases: 6 + iteration loops
- Feedback loops: up to 3 rounds
- Artifacts: 6+ (brief, creative direction, design spec, copy doc, `index.html`, customer review)

### 3.3 Evaluation Criteria

We evaluate the outputs across five dimensions, designed to capture the aspects of web design quality that matter for a local medical practice:

1. **Content completeness.** Does the page contain the information a real patient needs? Surgeon name, practice location, phone number, office hours, insurance information, services offered.
2. **Persona coverage.** Does the page address the needs of all three documented patient segments? Active adults wanting online booking, older adults wanting to call and see credentials, acute injury patients needing same-day availability.
3. **Conversion path functionality.** Can a patient actually take the intended action (book an appointment, call the office)?
4. **Design system compliance.** Are design tokens used correctly? Colors, typography, spacing, border radii.
5. **Accessibility.** ARIA labels, focus states, reduced motion support, semantic HTML, skip links, touch target sizes.

**Evaluation criteria asymmetry.** We acknowledge that these criteria are derived from the ICP document, which the creative studio's customer agent explicitly loads and evaluates against. The skill and workflow approaches see the ICP only as reference documentation, not as evaluation criteria. This creates a structural advantage for the creative studio on content completeness and persona coverage dimensions. To partially offset this asymmetry, we report implementation metrics (code volume, file size, JavaScript complexity) in Section 5.8 where no such advantage exists.

---

## 4. The Grounded Feedback Framework

The creative studio's customer agent operates under a structured framework that distinguishes it from generic LLM critique. This framework has three components.

### 4.1 Persona Grounding

Before evaluating, the customer agent loads the Ideal Customer Profile (ICP) document and adopts a specific persona:

| Persona | Context | Primary Need | Key Anxiety |
|---------|---------|--------------|-------------|
| Active Adult (30-55) | Sports injury or chronic joint pain; comparing surgeons in browser tabs | Online booking, fast appointments | Wasting time on unqualified surgeon |
| Older Adult (55+) | GP referral for joint replacement; daughter may have searched | Trustworthy surgeon at reputable hospital | Fear of surgery |
| Acute Injury (all ages) | Fresh fracture; in ER or leaving urgent care; on mobile | Same-day walk-in, location, hours | Can I be seen right now? |

The agent writes its entire evaluation in first person as the persona: "I clicked 'Book an Appointment' and it scrolled me down to a section that says 'Book an Appointment' again. Now what? I have three tabs open comparing surgeons, and the other two have online scheduling. I am closing this tab." (Source: Round 1 customer review, `docs/studio/customer-review-round-1.md`, Active Adult persona, "Why I Would Walk Away.")

### 4.2 Five-Dimension Rubric

Each evaluation scores five dimensions that mirror the user's cognitive progression from first impression to action:

1. **Visual** -- What the user sees in the first 2 seconds (hierarchy, trust signals, cognitive load)
2. **Copy / Messaging** -- Whether words connect with what the user cares about (problem recognition, specificity, objection awareness)
3. **Flow** -- The path from landing to desired action (next-step clarity, friction inventory, mobile reality)
4. **Conviction** -- Whether enough belief builds for the user to act (proof structure, credibility, risk perception)
5. **Persuasion** -- Whether the output motivates action, not just agreement (urgency, stakes clarity, CTA strength)

### 4.3 Behavioral Severity Classification

Each finding is classified by the user behavior it would trigger:

- **P1 (Bounce Trigger).** The user leaves. Tab closed. Back button pressed. Competitor chosen.
- **P2 (Hesitation Point).** The user pauses, doubts, or considers alternatives. Conversion probability drops.
- **P3 (Confidence Erosion).** Small signals that reduce trust. No single P3 kills the interaction, but they accumulate.

Every finding must include the behavioral consequence: not "the phone number is fake" but "I see (555) 123-4567 and immediately conclude this website is a template -- I am closing this tab."

---

## 5. Quantitative Results

### 5.1 Output Comparison

Table 1 presents a feature-by-feature comparison of the outputs, including the creative studio's Round 1 build (before customer feedback) to isolate the feedback loop's contribution.

**Table 1.** Content and functionality comparison across three skill architectures plus the creative studio's pre-feedback state. All received the identical prompt, model, and reference documents.

| Feature | Skill (01) | Workflow (02) | Creative Studio R1 | Creative Studio R2 (final) |
|---------|:----------:|:------------:|:------------------:|:-------------------------:|
| **Code volume** | 1,217 lines | 820 lines | -- | 1,648 lines |
| **File size** | 39,124 bytes | 26,125 bytes | -- | 53,869 bytes |
| **Estimated tokens** | ~50K | ~100K | (included in ~500K+) | ~500K+ |
| **Wall-clock time** | 3 min | 4 min | (included in 32 min) | 32 min |
| | | | | |
| **Practice name** | "Precision Ortho" (invented) | "Orthopaedic Care" (generic) | "[Practice Name] Orthopaedics" (placeholder) | "Mitchell Orthopaedics" (specific) |
| **Surgeon name** | None | None | "Dr. [First] [Last], MD" (placeholder brackets) | Dr. Sarah Mitchell, MD |
| **Location / city** | None | None | None | Austin, TX + full address |
| **Phone number** | (555) 123-4567 (obviously fake) | None visible in content | (555) 123-4567 (obviously fake) | (512) 555-0147 in banner, header, CTA, footer |
| **Office hours** | None | None | None | Mon-Fri 8-5, Sat 8-12 (walk-ins) |
| **Hospital affiliation** | None | None | None | St. David's Medical Center |
| **Insurance information** | None | None | None | Named carriers (BCBS, Aetna, Cigna, UHC) |
| **Patient testimonials** | None | None | None | 3 persona-matched with local attribution |
| **Urgent care messaging** | None | None | None | Dismissible banner with phone link |
| **Booking mechanism** | `href="#contact"` (no form) | `href="#"` (no target) | `href="#booking"` (self-referencing) | Appointment request form (client-side only, no backend) + phone `tel:` link |
| **"What to expect" guidance** | None | None | None | "Bring imaging results, medications, questions" |
| **Empathy/anxiety reduction** | None | None | None | "Your first appointment is a conversation" |
| | | | | |
| **Service card icons** | Generic feather-style SVGs | Generic feather-style SVGs | Custom anatomical SVGs | Custom anatomical SVGs per service |
| **Hero illustration** | Abstract joint with animated orbs | Abstract joint with movement arcs | Anatomical shoulder/knee/hip drawings | Anatomical shoulder/knee/hip drawings |
| **Section dividers** | Wave SVG | None | ECG pulse-line | ECG pulse-line (scroll-animated) |
| **Header / navigation** | None | None | None | Sticky header with brand, nav, phone, CTA |
| **Footer** | None | None | None | 3-column: address, hours, links, insurance |
| **Skip link** | None | None | None | Present |
| **ARIA landmarks** | Partial | Partial | Partial | Complete |
| **Reduced motion** | Supported | Supported | Supported | Supported |
| **Focus states** | Present | Present | Present | Present with visible outlines |
| **Mobile menu** | Hamburger (JS toggle) | Static (hidden links) | None | Hamburger (JS toggle + nav link close) |

The "Creative Studio R1" column is derived from the Round 1 customer review document (`docs/studio/customer-review-round-1.md`), which describes the state of the build before any customer feedback was incorporated. The R1 build was produced by the full multi-agent pipeline (designer brainstorm, copywriter, developer) but without the iterative feedback loop.

### 5.2 Content Completeness

The most striking difference is not visual polish -- all approaches produce visually competent output -- but **content depth**. The skill and workflow approaches produced attractive templates. The creative studio's final output produced a page a patient could actually use.

The skill approach invented a practice name ("Precision Ortho") and phone number but provided no surgeon identity, no location, and no mechanism for actually booking an appointment. A patient visiting this page cannot determine where the practice is, who the surgeon is, or how to schedule a visit.

The workflow approach is even sparser -- 820 lines versus 1,217 -- and provides less content than the skill approach. It does not even display a phone number in the main page content. The footer mentions "Call us" as a link but provides no number.

The creative studio's pre-feedback build (R1) exhibited the same content gaps: placeholder surgeon name in literal brackets (`Dr. [First] [Last], MD`), an obviously fake phone number, no header, no footer, no location, no insurance information, and no testimonials. The Round 1 customer review identified 16 findings including 5 P1 bounce triggers across the three personas. It was only after the feedback loop that the final build (R2) contained every piece of information the ICP document identifies as important to each patient segment.

### 5.3 Persona Coverage

We assess whether each output addresses the documented needs of the three patient personas.[^1]

[^1]: The 12 needs correspond to feature rows in Table 2, each traceable to a specific statement in the ICP document (`docs/BUSINESS/ICP.md`). The criteria were derived from the ICP before examining outputs. Different granularity (collapsing or expanding needs) would change the magnitude of the reported difference. The ICP defines four patient segments; Youth Athletes & Parents is the fourth. We evaluate against the three segments most relevant to the minimal prompt.

**Table 2.** Persona need coverage by approach. "Partial" indicates the feature exists but does not meet the documented need (e.g., a badge saying "Board Certified" partially addresses credential visibility but does not provide name, training, or specific qualifications).

| Patient Need | Skill | Workflow | CS R1 | CS R2 |
|-------------|:-----:|:--------:|:-----:|:-----:|
| **Active Adult** | | | | |
| Online booking mechanism | No (dead link) | No (dead link) | No (dead link) | Yes (interactive form, client-side only) |
| Surgeon credentials visible | Partial (eyebrow text) | Partial (badge) | Partial (badges) | Yes (headline + stats + bio) |
| Compare-and-choose info | No | No | No | Yes (testimonials, stats, affiliation) |
| **Older Adult** | | | | |
| Surgeon name and face[^2] | No | No | No (placeholder) | Name yes, face no |
| Hospital affiliation | No | No | No | Yes (St. David's) |
| Insurance information | No | No | No | Yes (named carriers) |
| Phone path with equal weight | Partial (ghost button) | No | Partial (fake number) | Yes (bordered phone block) |
| Empathy for surgical anxiety | No | No | No | Yes (empathy line) |
| **Acute Injury** | | | | |
| Same-day availability above fold | No | No | No | Yes (urgent banner) |
| Walk-in information | In card text only | No | In card text only | Banner + footer hours |
| Practice address | No | No | No | Yes (footer, full address) |
| Saturday hours | No | No | No | Yes (footer) |
| **Total needs addressed** | **1/12** | **0/12** | **1/12** | **10/12** |

[^2]: No approach can provide a surgeon photograph because no photograph exists in the reference documents. This is a hard constraint shared by all approaches. The creative studio's partial coverage (name yes, face no) reflects this constraint, not a design failure.

The skill approach covers 1 of 12 documented needs. The workflow approach covers 0 of 12. The creative studio's R1 build (before feedback) covers 1 of 12 -- comparable to the skill approach despite having a dedicated copywriter and designer. The creative studio's final R2 build covers 10 of 12 (missing only surgeon photo -- a hard constraint for all approaches -- and a verifiably real phone number). The jump from 1/12 to 10/12 occurred entirely as a result of the feedback loop.

### 5.4 Conversion Path Analysis

A medical practice homepage has one job: get the patient to book an appointment or call the office. We trace the conversion path for each approach:

**Skill:** The hero CTA "Book an Appointment" links to `#contact`, which scrolls to a section containing another CTA "Request Appointment" linking to `#` -- a dead end. The phone CTA calls `+15551234567`, which uses the reserved 555 exchange. While the `tel:` link is technically functional (the call would dial), the obviously fictitious number cannot reach a real practice. **Zero conversion paths that reach a real destination.**

**Workflow:** The hero CTA "Book an Appointment" links to `#book`, which scrolls to a card-style section. The card contains a CTA "Book Your Appointment" linking to `#` -- a dead end. The footer says "Call us" as a text link but has no phone number. **Zero conversion paths that reach a real destination.**

**Creative Studio (R1):** The hero CTA links to `#booking`, which is the `id` of the section containing the CTA itself -- a self-referencing anchor. The phone number is the same fake `(555) 123-4567`. **Zero conversion paths that reach a real destination.**

**Creative Studio (R2):** The hero CTA links to `#contact`, scrolling to a section containing an appointment request form (name, phone, reason for visit) with a client-side submit handler that displays visual confirmation ("Request Sent -- We Will Call You") but transmits no data to any backend. Alongside it, a bordered phone block displays `(512) 555-0147` as a `tel:` link that initiates a real phone call, though the number uses the reserved 555 exchange and cannot reach a real practice. **One interactive conversion path** (the appointment request form, which captures patient intent but is a client-side prototype) **and one functional phone conversion path** (the `tel:` link, which initiates a real call), plus a secondary phone path via the header.

**Timeline note.** The appointment request form was added as a post-evaluation fix in direct response to the Round 2 customer review's top P1 finding ("no actual booking mechanism"). The form was not present when the R2 customer agent assigned scores. The R2 scores in Table 3 and Appendix B reflect the pre-form build, in which the CTA was still a dead-end self-referencing anchor. The customer agent did not re-score after the form was added.

### 5.5 Isolating the Feedback Loop's Contribution

The Round 1 customer review document provides critical evidence for isolating the feedback loop's contribution from multi-agent generation. Table 3 shows the creative studio's score progression alongside the observation that the R1 state closely mirrors the skill and workflow outputs.

**Table 3.** Creative studio customer evaluation scores across two rounds (averaged across three personas, with range in parentheses).[^3]

| Dimension | Round 1 | Round 2 | Delta |
|-----------|:-------:|:-------:|:-----:|
| Visual | 6.3 (6-7) | 7.7 (7-8) | +1.3 |
| Copy | 7.3 (7-8) | 8.0 (8-8) | +0.7 |
| Flow | 5.7 (5-6) | 6.7 (6-7) | +1.0 |
| Conviction | 4.7 (4-5) | 7.0 (7-7) | +2.3 |
| Persuasion | 4.7 (4-5) | 7.0 (6-7) | +2.3 |
| **Average** | **5.7** | **7.2** | **+1.5** |

[^3]: R2 scores reflect the customer agent's evaluation of the pre-form build. The appointment request form was added after the R2 evaluation in response to the R2 review's top P1 finding (see Section 5.4, timeline note). The R2 average of 7.2 falls below the skill's 8/10 re-iteration threshold; the orchestrator addressed the R2 review's top P1 finding as a targeted post-evaluation fix rather than triggering a full third design-copy-build iteration.

The scoring agent is the same agent that identified the R1 deficiencies, creating a self-referential dynamic: an agent that flags "no testimonials" as a P1 finding is predisposed to score the addition of testimonials positively. The delta magnitudes should be interpreted as evidence that flagged gaps were addressed, not as independent quality assessments.

Per-persona breakdowns are provided in Appendix B, showing significant variance (e.g., Conviction ranges from 4 to 5 in Round 1 across personas).

The Round 1 customer review identified 16 findings, including 5 P1 bounce triggers that were common across all three personas:

1. CTA was a self-referencing anchor -- zero functional booking path
2. Surgeon name was placeholder brackets (`Dr. [First] [Last], MD`)
3. Phone number was obviously fake (`(555) 123-4567`)
4. No practice name, address, city, hours, or location anywhere on the page
5. No header or footer -- no brand anchor, no persistent navigation

These are the same gaps present in the skill and workflow outputs. The creative studio's R1 build, despite being produced by a multi-agent pipeline with a dedicated designer and copywriter, had **identical content completeness failures** to the single-agent approaches. The multi-agent generation process improved copy quality (the R1 build scored 7.3 on Copy versus generic marketing language in the other approaches) and visual consistency (the R1 build used custom anatomical SVGs rather than generic feather icons), but it did not add the content that distinguishes the final output.

The content additions that emerged between R1 and R2 -- testimonials, hospital affiliation, insurance information, urgent care banner, empathy line, office hours, real address -- were each traceable to specific customer agent findings. The Flow scores specifically reflect the dead-end CTA state of the evaluated build (Active Adult: 6, Acute Injury: 7); the appointment request form was a post-evaluation addition (see Section 5.4). The largest score improvements occurred in Conviction (+2.3) and Persuasion (+2.3), the dimensions most directly tied to the content the feedback loop surfaced.

### 5.6 Qualitative Differences

Beyond the quantifiable feature gaps, the three outputs differ in ways that reveal the depth of the creative process behind them.

**Copy quality.** The skill's hero subtitle reads: "Expert orthopaedic care from diagnosis through recovery -- so you can get back to the life you love." The workflow's reads: "Expert orthopaedic care from diagnosis through recovery. Get back to doing what you love -- with a surgeon who listens." Both are competent but generic -- interchangeable with any medical practice website. The creative studio's subheadline reads: "From diagnosis through surgery to recovery -- one surgeon, one team, one plan. Serving Austin, TX and surrounding communities." The specificity ("one surgeon, one team, one plan") and location grounding ("Austin, TX") were decisions made during the designer-copywriter brainstorm, where the copywriter argued that "pain compresses attention" and the messaging should lead with concrete reassurance rather than aspiration.

**Service card differentiation.** The skill and workflow approaches both use generic feather-style SVG icons -- a lightning bolt for Sports Medicine, a clock face for Surgical Procedures. The creative studio uses custom anatomical SVGs: a running figure with a highlighted knee joint for Sports Injuries, a bone-and-implant cross-section for Joint Replacement, a fractured bone with jagged break line for Fracture Care, and a hand skeleton with radiating fingers for General Orthopaedics. This visual differentiation was a key brainstorm decision: "Distinct service card icons, not uniform cards. Patients arrive with a specific problem. Visual differentiation lets them self-sort before reading."

**Persona-specific features.** Only the creative studio's final output contains features designed for specific patient segments. The urgent care banner exists because the customer agent, evaluating as an acute injury patient, wrote: "I am sitting in an ER with a broken wrist and the first thing I see is 'Appointments This Week.' This week? I need to be seen today." The empathy line exists because the customer agent, evaluating as a 68-year-old facing joint replacement, wrote: "The page never addresses the emotional weight of considering surgery. A single line like 'Making the decision to see a surgeon is a big step' would dramatically increase connection."

### 5.7 Cost-Quality Tradeoff

**Table 4.** Resource consumption by approach.[^4]

[^4]: The ICP defines four patient segments; we evaluate against the three segments most relevant to the prompt. The denominator of 12 persona needs reflects the granularity of Table 2.

| Metric | Skill | Workflow | CS R1 | CS R2 |
|--------|:-----:|:--------:|:-----:|:-----:|
| Token cost (relative) | 1x | 2x | -- | 10x |
| Wall-clock time | 3 min | 4 min | -- | 32 min |
| Personas addressed (of 12 needs) | 1 | 0 | 1 | 10 |
| Conversion paths | 0 | 0 | 0 | 2 (1 interactive (form) + 1 functional (phone)) |
| Distinct artifacts produced | 1 | 2 | -- | 6+ |

The creative studio costs 10x more tokens and takes 10x longer, but it is the only approach that produces a page a patient could actually interact with for booking. The quality gains are non-linear: the 2x cost of the workflow over the skill produces better structure but no additional content; the 10x cost of the creative studio produces fundamentally different output. The R1 comparison demonstrates that most of this cost difference is consumed by the feedback loop iterations, not by multi-agent generation alone.

### 5.8 Implementation Metrics

To offset the evaluation criteria asymmetry noted in Section 3.3, Table 5 reports dimensions where the creative studio does not have a structural advantage.

**Table 5.** Implementation metrics across approaches.

| Metric | Skill | Workflow | Creative Studio |
|--------|:-----:|:--------:|:--------------:|
| Code volume (lines) | **1,217** | **820** | 1,648 |
| File size (bytes) | 39,124 | **26,125** | 53,869 |
| CSS custom properties | 13 | 12 | 18 |
| Inline JavaScript (approx. lines) | ~40 | ~20 | ~80 |

The workflow approach produces the leanest implementation (820 lines, 26KB). The skill approach is the most concise relative to its visual complexity (animated gradient orbs, wave dividers, and scroll reveals in 1,217 lines). The creative studio's additional content, header, footer, urgent banner, testimonials section, and appointment form contribute a 35% larger file and roughly double the JavaScript of the skill approach. These are legitimate tradeoffs: the creative studio's content completeness comes at the cost of implementation complexity and file size.

---

## 6. Qualitative Analysis

### 6.1 Why Feedback Loops Were the Critical Differentiator

In this case study, the results show a clear hierarchy across three variables: methodology (skill), structured thinking (workflow), and feedback loops (creative studio).

- **Methodology alone** prevents obvious design errors (all approaches use design tokens correctly, have responsive layouts, and support reduced motion) but cannot add perspectives the agent does not have. A single agent, no matter how well-instructed, cannot simultaneously be the builder and a 68-year-old patient facing knee replacement surgery.

- **Structured thinking** improves decision-making. The workflow approach's forced brainstorming produces a design document that captures intent. But a single agent brainstorming with itself operates within its own cognitive boundaries -- it cannot challenge its own assumptions the way a separate agent with a different role can.

- **Feedback loops with grounded evaluation** were the multiplier. The creative studio's customer agent identified gaps that no amount of methodology or brainstorming surfaced in this instance, because those gaps require evaluating the output from a perspective the creating agents do not possess. The urgent care banner, the testimonials, the empathy line, the insurance information -- these features emerged not from better generation but from better evaluation.

### 6.2 Grounding Makes Agent Feedback Actionable

The case study reveals a sharp contrast between grounded and ungrounded feedback. Consider how the creative studio's customer agent described the broken CTA:

> "I clicked 'Book an Appointment' and it scrolled me down to a section that says 'Book an Appointment' again. Now what? I have three tabs open comparing surgeons, and the other two have online scheduling. I am closing this tab."
>
> -- Round 1 customer review, Active Adult persona

This finding is actionable because it: (1) identifies the specific technical failure (self-referencing anchor), (2) describes the user behavior consequence (closing the tab), (3) establishes competitive context (other surgeons have online scheduling), and (4) implies the fix (provide a real booking mechanism). A generic critique -- "the CTA could be improved" -- would not have produced the same response.

The grounding mechanism works by forcing the evaluating agent to simulate a specific user's mental model. When the customer agent says "I am sitting in an ER with a broken wrist," it activates reasoning about urgency, mobile usage, proximity search, and time pressure that produces findings no generic evaluation prompt would surface.

### 6.3 The Multi-Perspective Premium

A single agent, regardless of instructions, produces output from a single perspective in this case study. Both the skill and workflow approaches used generic medical marketing copy ("get back to the life you love") and generic service card icons (feather-style SVGs). They did not produce testimonials, persona-specific features, or empathy-driven copy because a single agent operating as a builder has no mechanism to adopt the patient's viewpoint -- at least not without explicit self-evaluation instructions.

While a single agent could be prompted to evaluate its own output from a patient's perspective -- as demonstrated by Self-Refine [14] -- our observation is that the separation of generation and evaluation into distinct agents with distinct roles produced more targeted findings in this instance. Whether this advantage is inherent to multi-agent separation or an artifact of the specific prompting is an open question requiring the ablation proposed in Section 7.

The creative studio achieves multiple perspectives through role separation:
- The **copywriter** optimizes for the patient's emotional state ("pain compresses attention" leads to sparse, scannable copy)
- The **designer** optimizes for visual self-sorting ("distinct icons so patients find their problem before reading")
- The **customer** agent optimizes for conversion ("I cannot take a next step even if I wanted to")
- The **developer** optimizes for implementation quality (accessibility, responsive behavior, performance)

These perspectives are not additive -- they are **adversarial in a productive sense**. The customer agent's job is to find what is wrong, not validate what is right. The "no PASS" policy (the customer always issues REVIEW, never PASS) ensures that even high-scoring outputs receive specific improvement suggestions.

### 6.4 Structured Thinking Is Necessary but Not Sufficient

The workflow approach demonstrates that forcing an agent to brainstorm before building produces better structural decisions: its hero uses a 2-column grid layout with an illustration (a design decision documented in its brainstorm phase), while the skill approach uses a single-column hero with decorative animated orbs. The workflow's section hierarchy is cleaner, and its heading structure is semantically stronger.

However, the workflow produces *better structure around the same shallow content*. Its brainstorming improves how information is organized but does not add information the agent did not already plan to include. The gap between "better structure" and "right content" is where the feedback loop made its contribution in this case study.

### 6.5 Matching Architecture to Stakes

The cost-quality tradeoff suggests a practical heuristic: **match the skill architecture to the stakes of the deliverable.**

- **Methodology injection** is appropriate for internal tools, prototypes, and deliverables where a technically competent result is sufficient. The 3-minute, 50K-token investment produces a functional page.
- **Workflow pipelines** are appropriate for production features where structural quality matters -- team standards enforcement, design system compliance, documented decisions. The 4-minute, 100K-token investment produces better decisions.
- **Creative studio with feedback loops** is appropriate for customer-facing, high-stakes deliverables where the content must serve real users. The 32-minute, 500K-token investment produces fundamentally different output -- not just better execution of the same ideas, but different ideas that emerge from multi-perspective evaluation.

The 10x cost is not justified for every page. But for a homepage that will be the first impression for patients deciding whether to trust a surgeon with their body, the difference between "visually competent template" and "page that addresses your specific fears, answers your questions, and gives you a way to express booking intent" is the difference between a bounce and engagement. A sufficiently detailed prompt could close the content gap, but this shifts the design burden to the prompt author, who must anticipate every persona need in advance -- precisely the work the customer evaluation agent performs autonomously.

### 6.6 Limitations

**Single instance.** Our evidence comes from one prompt, one domain, and one model, each run exactly once. We cannot distinguish between (a) the creative studio architecture being inherently superior, (b) stochastic variation in model output (a different random seed might produce a skill output with a surgeon name), and (c) the creative studio's ICP document providing richer context that a single agent could have exploited with a better prompt. We were unable to run additional replications for this revision; this remains the study's primary methodological limitation. Replication across runs, domains (e-commerce, SaaS, education), and models is required before the observed pattern can be claimed as a general finding.

**No human evaluation.** We did not present the three outputs to real patients or UX professionals. Our evaluation criteria (Tables 1, 2) are based on documented patient needs from the ICP, assessed by the paper authors -- the same authors who designed the system and the criteria. This circularity means the evaluation cannot be considered independent. For a paper at CHI, where user-centered evaluation is foundational, this is the most significant limitation. Author-assessed evaluation cannot substitute for independent human judgment.

**Same model for all.** All agents used the same Claude Opus 4 model. Cross-model architectures (e.g., a more capable model for evaluation, a faster model for generation) might alter the cost-quality curve.

**No A/B testing.** We cannot measure whether the creative studio's content advantages translate to higher conversion rates on a deployed page.

**Prompt specificity.** The prompt is deliberately minimal ("3-section homepage"). A more detailed prompt might narrow the gap between approaches by providing the content decisions (surgeon name, location) that the feedback loop currently surfaces.

**ICP richness.** The ICP document used in this case study is unusually detailed. Whether the creative studio's advantage persists with thinner persona documentation is an open question. We hypothesize that the feedback loop's contribution is proportional to the richness of the persona documentation, but this requires empirical validation.

**No controllable random seeds.** The API does not expose a seed parameter. Stochastic variation between runs is an uncontrolled source of variance.

### 6.7 Confounded Variables and the Need for Ablation

The independent variable -- "skill architecture" -- bundles three changes: (a) number of agents, (b) presence of specialized creative roles (copywriter, designer), and (c) presence of a feedback loop with grounded evaluation. The paper's thesis is that (c) is the critical differentiator, but the current study design cannot fully isolate (c) from (a) and (b).

The Round 1 comparison (Section 5.5) provides partial evidence: the creative studio's R1 build, produced by the full multi-agent pipeline *without* the feedback loop's corrective influence, had content completeness comparable to the single-agent approaches (1/12 persona needs) while having higher copy quality (7.3/10 vs. generic). This suggests that multi-agent generation contributes to **copy quality and visual consistency** while the feedback loop contributes to **content completeness and persona coverage**. Both mechanisms contribute, but to different quality dimensions.

However, this is an observational decomposition, not an experimental isolation. Four ablation conditions would be needed to isolate each component:

1. Single agent + creative direction document pre-loaded (tests whether the brainstorm output alone closes the gap)
2. Multi-agent generation without customer feedback (tests whether role separation alone is sufficient)
3. Single agent with Self-Refine-style self-evaluation using persona instructions (tests whether multi-agent separation is necessary for the feedback benefit)
4. Full creative studio (the current condition)

Until these ablations are conducted, the attribution of quality gains to the feedback loop specifically remains a supported hypothesis, not a proven mechanism.

Additionally, if the evaluation criteria were restricted to implementation quality metrics (code volume, file size, JavaScript complexity), the ordering of approaches would differ. The workflow approach produces the leanest code; the skill approach is most efficient per visual feature. The creative studio's advantages are concentrated in content-oriented dimensions where its customer agent is architecturally designed to optimize.

---

## 7. Future Work

We prioritize future work by expected impact, from highest to lowest.

**1. Ablation study (highest-priority next step).** Run the four conditions described in Section 6.7 to isolate the contribution of multi-agent generation, creative direction, self-evaluation, and grounded evaluation. This ablation is the single most important step toward establishing whether the feedback loop is the critical mechanism or whether the observed gains are attributable to multi-agent generation or richer context alone.

**2. Human evaluation study.** Present all three HTML outputs (unlabeled, randomized order) to (a) 3-5 practicing UX designers rating content completeness, conversion path quality, and design system compliance, and (b) 5-10 participants matching the target patient personas performing a task-based evaluation ("find and use the booking mechanism") followed by semi-structured interviews asking which page they would use to book an appointment and why.

**3. Minimal replication (immediate low-cost action).** Run the skill approach (the cheapest condition at ~50K tokens, 3 minutes) two additional times. If those runs also produce 0-1/12 persona needs, report this as supplementary evidence that the content gap is not a single-run artifact. This requires minimal compute and can be completed in under 10 minutes.

**4. Full replication study.** Run each architecture 5 times with different API calls to establish reliability. Report mean and variance on persona coverage (Table 2 metric). Replicate across at least two additional domains (e-commerce product page, restaurant website) to test cross-domain generalizability.

**5. Prompt specificity experiments.** Vary the prompt from "build a homepage" to "build a homepage with Dr. Sarah Mitchell at St. David's Medical Center in Austin, TX, including office hours, insurance, testimonials, and a booking form." Measure whether detailed prompts reduce the advantage of the creative studio approach.

**6. Cost optimization.** Explore hybrid architectures -- for example, using methodology injection for initial generation but adding a single evaluation pass (without full multi-agent orchestration) to capture the most impactful feedback at lower token cost.

**7. Longitudinal analysis.** Measure whether the creative studio's advantages persist or diminish across multiple pages within the same project, as the accumulated design decisions and creative direction reduce the decision space.

---

## 8. Conclusion

We presented a controlled case study comparing three skill architectures for autonomous web design: methodology injection, workflow pipeline, and creative studio with feedback loops. Holding constant the prompt, model, design system, and reference documents, we observed that skill architecture was the primary determinant of output quality in this instance -- not model capability, not prompt engineering, not design system completeness.

The critical differentiator in this case study was not the number of agents or the volume of tokens, but the presence of **grounded evaluation**: a customer agent that adopts specific user personas, scores against a consistent rubric, and ties findings to observable user behaviors. The creative studio's pre-feedback output exhibited the same content gaps as the single-agent approaches; the content additions emerged only after persona-grounded evaluation identified their absence as bounce triggers.

The practical implication is clear: for high-stakes, customer-facing deliverables, the 10x investment in multi-agent feedback loops produced non-linear quality gains in this case -- not incremental visual polish, but fundamentally different content that addresses real user needs. Methodology prevents bad output. Structure produces good decisions. Feedback loops produce the right decisions. Whether this finding generalizes beyond the single domain, model, and prompt tested here requires the replication, ablation, and human evaluation studies proposed as future work.

---

## 9. Ethics Statement

The creative studio output contains fabricated medical content: "Dr. Sarah Mitchell, MD" is a fictional surgeon, and "Mitchell Orthopaedics" is a fictional practice. The hospital name "St. David's Medical Center" refers to a real institution in Austin, TX; its use in a fictional context is noted as a limitation. The phone number `(512) 555-0147` uses the reserved 555 exchange specifically to prevent accidental calls to real numbers. The practice address (4200 Medical Parkway, Suite 310, Austin, TX 78756) is fictional. None of the generated pages were deployed, indexed by search engines, or made publicly accessible.

LLM-generated medical content that blends real and fictional entities poses risks of patient deception if deployed without human verification. We recommend that any system producing medical web content include mandatory human review before publication, clear labeling of generated content during development, and verification that no real patient could mistake a prototype for an operational medical practice.

The environmental cost of 500K+ tokens per page is a consideration for adoption at scale. If the creative studio approach were applied to every page of a multi-page website, the cumulative compute cost and associated energy consumption would be substantial.

---

## References

[1] Hong, S., Zhuge, M., Chen, J., et al. (2024). MetaGPT: Meta programming for a multi-agent collaborative framework. *Proceedings of ICLR 2024*.

[2] Qian, C., Liu, W., Liu, H., et al. (2024). ChatDev: Communicative agents for software development. *Proceedings of the 62nd Annual Meeting of the ACL*, 15174-15186.

[3] Wu, Q., Bansal, G., Zhang, J., et al. (2024). AutoGen: Enabling next-gen LLM applications via multi-agent conversation. *Proceedings of COLM 2024*.

[4] Chen, W., Su, Y., Zuo, J., et al. (2024). AgentVerse: Facilitating multi-agent collaboration and exploring emergent behaviors. *Proceedings of ICLR 2024*.

[5] Zheng, L., Chiang, W. L., Sheng, Y., et al. (2023). Judging LLM-as-a-judge with MT-Bench and Chatbot Arena. *Proceedings of NeurIPS 2023*.

[6] Liu, Y., Iter, D., Xu, Y., et al. (2023). G-Eval: NLG evaluation using GPT-4 with better human alignment. *Proceedings of EMNLP 2023*.

[7] Grudin, J., & Pruitt, J. (2002). Personas, participatory design and product development: An infrastructure for engagement. *Proceedings of PDC 2002*.

[8] Nielsen, L. (2019). *Personas -- User focused design* (2nd ed.). Springer.

[9] Matthews, T., Judge, T., & Whittaker, S. (2012). How do designers and user experience professionals actually perceive and use personas? *Proceedings of CHI 2012*, 1219-1228.

[10] Cooper, A. (1999). *The inmates are running the asylum*. SAMS.

[11] Pruitt, J., & Adlin, T. (2006). *The persona lifecycle: Keeping people in mind throughout product design*. Morgan Kaufmann.

[12] Long, F. (2009). Real or imaginary: The effectiveness of using personas in product design. *Proceedings of the Irish Ergonomics Society Annual Conference*.

[13] Park, J. S., O'Brien, J., Cai, C. J., Morris, M. R., Liang, P., & Bernstein, M. S. (2023). Generative agents: Interactive simulacra of human behavior. *Proceedings of UIST 2023*.

[14] Madaan, A., Tandon, N., Gupta, P., et al. (2023). Self-Refine: Iterative refinement with self-feedback. *Proceedings of NeurIPS 2023*.

[15] Bai, Y., Kadavath, S., Kundu, S., et al. (2022). Constitutional AI: Harmlessness from AI feedback. *arXiv preprint arXiv:2212.08073*.

[16] Shinn, N., Cassano, F., Gopinath, A., Narasimhan, K., & Yao, S. (2023). Reflexion: Language agents with verbal reinforcement learning. *Proceedings of NeurIPS 2023*.

[17] Huang, Q., Vora, J., Liang, P., & Leskovec, J. (2024). MLAgentBench: Evaluating language agents on machine learning experimentation. *Proceedings of the 41st International Conference on Machine Learning (ICML)*, PMLR 235, 20271-20309.

[18] Chan, C.-M., Chen, W., et al. (2024). ChatEval: Towards better LLM-based evaluators through multi-agent debate. *Proceedings of ICLR 2024*.

[19] Knapp, J., Zeratsky, J., & Kowitz, B. (2016). *Sprint: How to solve big problems and test new ideas in just five days*. Simon & Schuster.

[20] Salminen, J., et al. (2024). Deus ex machina and personas from large language models: Investigating the composition of AI-generated persona descriptions. *Proceedings of CHI 2024*.

[21] Chen, M., Tworek, J., Jun, H., et al. (2021). Evaluating large language models trained on code. *arXiv preprint arXiv:2107.03374*.

[22] Austin, J., Odena, A., Nye, M., et al. (2021). Program synthesis with large language models. *arXiv preprint arXiv:2108.07732*.

[23] Si, C., Li, T., et al. (2024). Design2Code: How far are we from automating front-end engineering? *Proceedings of ICML 2024*.

[24] Yang, J., Prabhakar, A., et al. (2024). InterCode: Standardizing and benchmarking interactive coding with execution feedback. *Proceedings of ICLR 2024*.

---

## Appendix A: Skill Architecture Summary

| | Skill (01) | Workflow (02) | Creative Studio (03) |
|-|:----------:|:------------:|:-------------------:|
| Architecture | Context injection | Sequential pipeline | Multi-agent + loops |
| Agents | 1 | 1 (+ sub-skill calls) | 5+ specialized |
| Creative perspectives | 1 (builder) | 1 (builder) + brainstorm | 3 (designer + copywriter + customer) |
| Process phases | 1 | 4 | 6 + iterations |
| Design thinking | Self-applied tests | Mandatory brainstorm + design doc | Collaborative direction + design spec |
| Copy quality | Agent's own writing | Agent's own writing | Dedicated copywriter agent |
| Quality gates | None (self-evaluation) | Design system compliance check | Customer scoring + quality guardians |
| Iteration | None | None (linear) | Up to 3 rounds |
| Tokens | ~50K | ~100K | ~500K+ |
| Time | 3 min | 4 min | 32 min |
| Skill definitions | `.claude/skills/frontend-design/SKILL.md` | `.claude/skills/feature-frontend/SKILL.md` | `.claude/skills/creative-studio/SKILL.md` |
| Best for | Prototypes, internal tools | Production features, team standards | Customer-facing, high-stakes pages |

## Appendix B: Customer Evaluation Score Progression (Creative Studio)

R2 scores reflect the customer agent's evaluation of the pre-form build. The appointment request form was added after the R2 evaluation (see Section 5.4, timeline note).

| Persona | Dim | R1 | R2 | Delta | Driver |
|---------|-----|:--:|:--:|:-----:|--------|
| Active Adult | Visual | 7 | 8 | +1 | Header/footer legitimacy |
| Active Adult | Copy | 8 | 8 | 0 | Already strong |
| Active Adult | Flow | 6 | 6 | 0 | Booking CTA remains dead-end in evaluated build; form added post-evaluation (see Section 5.4) |
| Active Adult | Conviction | 5 | 7 | +2 | Testimonials (Marcus T./ACL), hospital affiliation |
| Active Adult | Persuasion | 5 | 6 | +1 | Proof added, but no competitive differentiator |
| Older Adult | Visual | 6 | 7 | +1 | Practice name in header, footer structure |
| Older Adult | Copy | 7 | 8 | +1 | Empathy line, insurance information |
| Older Adult | Flow | 6 | 7 | +1 | Phone path works; location present |
| Older Adult | Conviction | 4 | 7 | +3 | Hospital affiliation, Linda R. testimonial |
| Older Adult | Persuasion | 5 | 7 | +2 | Empathy line + dual CTA + insurance |
| Acute Injury | Visual | 6 | 8 | +2 | Urgent banner above fold |
| Acute Injury | Copy | 7 | 8 | +1 | "Same-day walk-in" messaging |
| Acute Injury | Flow | 5 | 7 | +2 | Banner provides 2-tap phone conversion |
| Acute Injury | Conviction | 5 | 7 | +2 | Saturday hours, same-day imaging |
| Acute Injury | Persuasion | 4 | 7 | +3 | Urgent banner creates real urgency |

## Appendix C: The Creative Studio's Key Brainstorm Decision

The converged creative direction document, named "Steady Hands," established the following key decision that shaped all subsequent output:

> *"Reassurance over aspiration in the hero. The audience is mid-decision and in pain. They need to trust this surgeon, not be inspired about movement. Aspiration earns its place in the subheadline, not the headline."*

This decision is visible in the three outputs. The skill's hero leads with aspiration: **"Restore Your Movement."** The workflow's hero leads with aspiration: **"Restore Movement. Restore Life."** The creative studio's hero leads with credential: **"Fellowship-Trained Orthopaedic Surgeon. Appointments This Week."** The brainstorm -- a dialogue between a designer who proposed the visual direction and a copywriter who insisted that "pain compresses attention" -- produced a fundamentally different framing that neither a single agent with methodology nor a single agent with a brainstorming phase arrived at independently.
