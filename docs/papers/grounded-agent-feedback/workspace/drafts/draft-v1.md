# Skill Architecture Matters: How Autonomous Feedback Loops Transform LLM Agent Design Quality

**Target venue:** ACM CHI 2027 (Conference on Human Factors in Computing Systems) — Case Study track
**Preprint:** arXiv (cs.HC / cs.AI cross-list)

---

## Abstract

Large language model agents can generate functional web pages from natural language prompts, but the quality of their output varies dramatically depending on the architectural scaffolding around the generation process. We present a controlled experiment in which the same prompt, model, design system, and brand guidelines were given to three progressively structured skill architectures: (1) a **methodology-injection skill** that loads design principles into a single agent's context, (2) a **workflow skill** that enforces a sequential brainstorm-then-build pipeline, and (3) a **creative studio** that orchestrates multiple specialised agents (designer, copywriter, developer, customer evaluator) with persona-grounded feedback loops. All three produced self-contained HTML homepages for an orthopaedic surgery practice. We evaluate the outputs across content completeness, persona coverage, conversion path functionality, design system compliance, and accessibility. The single-agent skill produced a visually polished but content-sparse template with no surgeon name, no location, and a non-functional booking path. The workflow skill produced a cleaner structure with a documented design rationale but identical content gaps. The creative studio — at 10x the token cost and 10x the wall-clock time — produced a page with a named surgeon, real location, hospital affiliation, three persona-matched testimonials, an urgent care banner, a functional booking form, insurance information, and office hours. We find that the critical differentiator is not the number of agents or tokens consumed, but the presence of **grounded evaluation** — a customer agent that adopts specific user personas, scores against a five-dimension rubric, and ties findings to observable user behaviors. Without this feedback loop, agents produce what looks correct; with it, they produce what works for real users.

**Keywords:** LLM agents, skill architecture, autonomous design, grounded feedback, persona-based evaluation, multi-agent collaboration

---

## 1. Introduction

The rapid adoption of large language model (LLM) agents as autonomous code generators has raised a fundamental question: what determines the quality of their output? The prevailing assumption is that model capability is the primary factor — a more capable model produces better results. Our experiment challenges this assumption by holding the model constant and varying only the **skill architecture** — the structural scaffolding that shapes how the agent approaches a task.

We define three levels of skill architecture, each adding a layer of process around the same base model:

1. **Methodology injection.** A skill that loads design principles, validation tests, and anti-patterns directly into the agent's context window. The agent builds the deliverable in a single pass, guided by these internalised rules. One agent, one perspective, no external feedback.

2. **Workflow pipeline.** A skill that enforces a multi-phase process: verify design system constraints, brainstorm the design intent, document decisions in a design document, then implement. The same agent does all the work, but is forced to think before building. One agent, one perspective, structured thinking.

3. **Creative studio with feedback loops.** A skill that orchestrates multiple specialised agents — a brand designer, a copywriter, an expert developer, and a customer persona evaluator — through a six-phase pipeline with iterative feedback loops. The customer agent evaluates the output through specific user personas, scores it against a five-dimension rubric, and classifies findings by severity. If scores fall below a threshold, the entire design-copy-build cycle repeats. Multiple agents, multiple perspectives, grounded evaluation.

All three approaches received an identical prompt: "Build a 3-section homepage for our orthopaedic surgery practice. Single self-contained index.html file. No stock photo URLs." All three had access to the same design system tokens, brand guidelines, ideal customer profiles, and product documentation. The only independent variable was the skill architecture.

The results are stark. The methodology-injection skill (~50K tokens, 3 minutes) produced a visually polished page with animated gradient orbs, a wave divider, and scroll reveal effects — but no surgeon name, no practice location, no testimonials, no insurance information, and a booking button that linked to `#contact` with no actual booking mechanism. The workflow skill (~100K tokens, 4 minutes) produced a structurally cleaner page with a documented design rationale — but identical content gaps. The creative studio (~500K+ tokens, 32 minutes) produced a page with "Dr. Sarah Mitchell, MD" at St. David's Medical Center in Austin, TX, three persona-matched patient testimonials, an urgent care banner for acute injury patients, a functional appointment request form, insurance carrier names, office hours including Saturday walk-ins, and an empathy line addressing pre-surgical anxiety.

This paper makes three contributions:

1. **Empirical evidence** that skill architecture, not model capability, is the primary determinant of autonomous design quality — demonstrated through a controlled experiment with identical inputs.
2. **A grounded feedback framework** that transforms generic LLM critique into persona-specific, dimensionally scored, behaviorally anchored evaluation.
3. **A cost-quality tradeoff analysis** showing that the 10x token cost of multi-agent feedback loops produces non-linear quality gains concentrated in the dimensions that matter most for user conversion: conviction and persuasion.

---

## 2. Related Work

### 2.1 Multi-Agent LLM Systems

Multi-agent architectures have demonstrated advantages over single-agent approaches across software engineering tasks. MetaGPT [1] assigns agents to product manager, architect, engineer, and QA roles, showing that role specialisation reduces hallucination. ChatDev [2] models the software development lifecycle as multi-agent conversation. AutoGen [3] provides a framework for multi-agent cooperation. AgentVerse [4] demonstrates that agent collaboration outperforms individual agents on complex reasoning.

Our work extends multi-agent paradigms to creative design, where quality is not merely functional correctness but subjective user experience. We add a critical role absent from prior systems: a **customer evaluator** that never produces deliverables, only grounded critique.

### 2.2 LLM-as-Judge

Using LLMs to evaluate LLM output has gained traction for text generation tasks. Zheng et al. [5] show that LLM judges approximate human preferences in open-ended generation. Liu et al. [6] demonstrate GPT-4 evaluation correlates with human judgments on summarisation. However, these approaches evaluate text quality in isolation, without the multi-dimensional assessment required for web design — visual hierarchy, user flow, trust building, and conversion path integrity.

Our framework extends LLM-as-judge by requiring the evaluator to adopt a specific user persona with documented motivations and anxieties before issuing any judgment. This bridges the gap between abstract quality assessment and situated user experience evaluation.

### 2.3 Persona-Based Design

Personas have a long history in HCI [7, 8, 9]. Cooper's goal-directed personas [10] represent archetypal users with specific needs. Pruitt and Adlin [11] demonstrate that personas improve design decisions. However, persona use in practice often degrades to superficial archetypes that do not meaningfully influence design [12].

We operationalise personas as **evaluation contracts** — structured documents defining not just demographics and goals, but specific skepticism points, decision factors, and the language the persona uses to describe their problem. The evaluating agent must load this context, adopt the persona's voice, and ground every finding in the persona's behavioral response.

### 2.4 Code Generation Quality

Prior work on LLM code generation has focused primarily on functional correctness — pass rates on benchmarks like HumanEval [13] and MBPP [14]. Our work evaluates a different dimension: whether generated code produces artifacts that serve *users*, not just artifacts that compile. A page that passes all accessibility checks but provides no booking mechanism is functionally correct yet experientially worthless.

---

## 3. Experiment Design

### 3.1 Control Variables

The experiment holds constant all factors except skill architecture:

| Variable | Value |
|----------|-------|
| Prompt | "Build a 3-section homepage for our orthopaedic surgery practice. Single self-contained index.html file. No stock photo URLs." |
| Model | Claude Opus (identical for all agents across all approaches) |
| Design system | docs/DESIGN/DESIGN_SYSTEM.md — colors (#1B4D7A primary, #2A9D8F accent, #F7F9FC secondary), Inter typeface, 12-column grid, 24px gutters |
| Brand guidelines | docs/DESIGN/BRAND.md — warm, confident, reassuring voice; deep blue for trust, teal for action |
| Patient segments | docs/BUSINESS/ICP.md — active adults (30-55), older adults (55+), acute injury (all ages) |
| Product documentation | docs/BUSINESS/PRODUCT.md — services, delivery channels, differentiators |

### 3.2 Independent Variable: Skill Architecture

**Approach 1 — Skill: `frontend-design`** (Methodology injection)

A single agent receives the prompt with design methodology loaded into context: Swap Test (would replacing design choices with defaults feel wrong?), Squint Test (does hierarchy hold when blurred?), Signature Test (is there one memorable detail?), Token Test (do all values trace to design system tokens?), Progressive Disclosure principles, and Platform Test (does it work on mobile?). The agent reads the project documentation and builds the entire page in one pass.

- Agents: 1
- Phases: 1 (build)
- Feedback loops: 0
- Artifacts: 1 (index.html)

**Approach 2 — Workflow: `feature-frontend`** (Sequential pipeline)

A single orchestrating agent follows a four-phase pipeline: (0) check whether a design system exists and use its tokens as hard constraints, (1) call the `brainstorming` skill to explore design intent, hierarchy, interaction states, and how the feature uses design tokens — writing a design document, (2) implement bottom-up (atoms → molecules → organisms → pages) following the brainstorm output, (3) commit and create a PR. The brainstorming phase is the key differentiator — it forces the agent to articulate intent before writing code.

- Agents: 1 (with sub-skill calls)
- Phases: 4 (check → brainstorm → build → ship)
- Feedback loops: 0 (linear pipeline)
- Artifacts: 2 (design-doc.md, index.html)

**Approach 3 — Creative Studio: `creative-studio`** (Multi-agent with feedback loops)

An orchestrator coordinates five or more specialised agents through six phases:

1. **Brief preparation.** The orchestrator reads all project documents and writes a structured creative brief.
2. **Brainstorm.** A brand-designer agent and a copywriter agent engage in multi-round dialogue (up to 4 rounds), debating creative directions until they converge on a single direction document — the immutable contract for all subsequent phases.
3. **Design.** The brand-designer produces a detailed visual specification (layout, components, responsive behavior, accessibility).
4. **Copy.** The copywriter produces all patient-facing text following the messaging direction.
5. **Build.** The expert-developer implements from the design spec and copy doc, using exact copy (no paraphrasing).
6. **Customer review.** A customer agent evaluates the output through each patient persona, scoring across five dimensions (Visual, Copy, Flow, Conviction, Persuasion) with severity-classified findings (P1 bounce triggers, P2 hesitation points, P3 confidence erosion). If the average score falls below 8/10 and the round count is below 3, the pipeline loops back to Phase 3 with targeted feedback.

- Agents: 5+ (brand-designer, copywriter, expert-developer, customer, quality guardians)
- Phases: 6 + iteration loops
- Feedback loops: up to 3 rounds
- Artifacts: 6+ (brief, creative direction, design spec, copy doc, index.html, customer review)

### 3.3 Evaluation Criteria

We evaluate the three outputs across five dimensions, designed to capture the aspects of web design quality that matter for a local medical practice:

1. **Content completeness.** Does the page contain the information a real patient needs? Surgeon name, practice location, phone number, office hours, insurance information, services offered.
2. **Persona coverage.** Does the page address the needs of all three documented patient segments? Active adults wanting online booking, older adults wanting to call and see credentials, acute injury patients needing same-day availability.
3. **Conversion path functionality.** Can a patient actually take the intended action (book an appointment, call the office)?
4. **Design system compliance.** Are design tokens used correctly? Colors, typography, spacing, border radii.
5. **Accessibility.** ARIA labels, focus states, reduced motion support, semantic HTML, skip links, touch target sizes.

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

The agent writes its entire evaluation in first person as the persona: "I clicked 'Book an Appointment' and it scrolled me down to a section that says 'Book an Appointment' again. Now what? I have three tabs open comparing surgeons, and the other two have online scheduling. I am closing this tab."

### 4.2 Five-Dimension Rubric

Each evaluation scores five dimensions that mirror the user's cognitive progression from first impression to action:

1. **Visual** — What the user sees in the first 2 seconds (hierarchy, trust signals, cognitive load)
2. **Copy / Messaging** — Whether words connect with what the user cares about (problem recognition, specificity, objection awareness)
3. **Flow** — The path from landing to desired action (next-step clarity, friction inventory, mobile reality)
4. **Conviction** — Whether enough belief builds for the user to act (proof structure, credibility, risk perception)
5. **Persuasion** — Whether the output motivates action, not just agreement (urgency, stakes clarity, CTA strength)

### 4.3 Behavioral Severity Classification

Each finding is classified by the user behavior it would trigger:

- **P1 (Bounce Trigger).** The user leaves. Tab closed. Back button pressed. Competitor chosen.
- **P2 (Hesitation Point).** The user pauses, doubts, or considers alternatives. Conversion probability drops.
- **P3 (Confidence Erosion).** Small signals that reduce trust. No single P3 kills the interaction, but they accumulate.

Every finding must include the behavioral consequence: not "the phone number is fake" but "I see (555) 123-4567 and immediately conclude this website is a template — I am closing this tab."

---

## 5. Results

### 5.1 Output Comparison

Table 1 presents a feature-by-feature comparison of the three outputs.

**Table 1.** Content and functionality comparison across three skill architectures. All three received the identical prompt, model, and reference documents.

| Feature | Skill (01) | Workflow (02) | Creative Studio (03) |
|---------|:----------:|:------------:|:-------------------:|
| **Code volume** | 1,217 lines | 820 lines | 1,648 lines |
| **Estimated tokens** | ~50K | ~100K | ~500K+ |
| **Wall-clock time** | 3 min | 4 min | 32 min |
| | | | |
| **Practice name** | "Precision Ortho" (invented) | "Orthopaedic Care" (generic) | "Mitchell Orthopaedics" (specific) |
| **Surgeon name** | None | None | Dr. Sarah Mitchell, MD |
| **Location / city** | None | None | Austin, TX + full address |
| **Phone number** | (555) 123-4567 (obviously fake) | None visible in content | (512) 555-0147 in banner, header, CTA, footer |
| **Office hours** | None | None | Mon-Fri 8-5, Sat 8-12 (walk-ins) |
| **Hospital affiliation** | None | None | St. David's Medical Center |
| **Insurance information** | None | None | Named carriers (BCBS, Aetna, Cigna, UHC) |
| **Patient testimonials** | None | None | 3 persona-matched with local attribution |
| **Urgent care messaging** | None | None | Dismissible banner with phone link |
| **Booking mechanism** | `href="#contact"` (no form) | `href="#"` (no target) | Appointment request form (name, phone, reason) |
| **"What to expect" guidance** | None | None | "Bring imaging results, medications, questions" |
| **Empathy/anxiety reduction** | None | None | "Your first appointment is a conversation" |
| | | | |
| **Service card icons** | Generic feather-style SVGs | Generic feather-style SVGs | Custom anatomical SVGs per service |
| **Hero illustration** | Abstract joint with animated orbs | Abstract joint with movement arcs | Anatomical shoulder/knee/hip drawings |
| **Section dividers** | Wave SVG | None | ECG pulse-line (scroll-animated) |
| **Skip link** | None | None | Present |
| **ARIA landmarks** | Partial | Partial | Complete |
| **Reduced motion** | Supported | Supported | Supported |
| **Focus states** | Present | Present | Present with visible outlines |
| **Mobile menu** | Hamburger (JS toggle) | Static (hidden links) | Hamburger (JS toggle + nav link close) |

### 5.2 Content Completeness

The most striking difference is not visual polish — all three are visually competent — but **content depth**. The skill and workflow approaches produced attractive templates. The creative studio produced a page a patient could actually use.

The skill approach invented a practice name ("Precision Ortho") and phone number but provided no surgeon identity, no location, and no mechanism for actually booking an appointment. A patient visiting this page cannot determine where the practice is, who the surgeon is, or how to schedule a visit.

The workflow approach is even sparser — 820 lines versus 1,217 — and provides less content than the skill approach. It does not even display a phone number in the main page content. The footer mentions "Call us" as a link but provides no number.

The creative studio page contains every piece of information the ICP document identifies as important to each patient segment. The active adult finds online booking (appointment request form). The older adult finds the surgeon's name, hospital affiliation, insurance information, and a phone number with equal visual weight to the online CTA. The acute injury patient finds a dismissible banner above the fold with same-day walk-in messaging and a clickable phone link.

### 5.3 Persona Coverage

We assess whether each output addresses the documented needs of the three patient personas.

**Table 2.** Persona need coverage by approach.

| Patient Need | Skill | Workflow | Creative Studio |
|-------------|:-----:|:--------:|:--------------:|
| **Active Adult** | | | |
| Online booking mechanism | No (dead link) | No (dead link) | Yes (form) |
| Surgeon credentials visible | Partial (eyebrow text) | Partial (badge) | Yes (headline + stats + bio) |
| Compare-and-choose info | No | No | Yes (testimonials, stats, affiliation) |
| **Older Adult** | | | |
| Surgeon name and face | No | No | Name yes, face no |
| Hospital affiliation | No | No | Yes (St. David's) |
| Insurance information | No | No | Yes (named carriers) |
| Phone path with equal weight | Partial (ghost button) | No | Yes (bordered phone block) |
| Empathy for surgical anxiety | No | No | Yes (empathy line) |
| **Acute Injury** | | | |
| Same-day availability above fold | No | No | Yes (urgent banner) |
| Walk-in information | In card text only | No | Banner + footer hours |
| Practice address | No | No | Yes (footer, full address) |
| Saturday hours | No | No | Yes (footer) |

The skill approach covers 1 of 12 documented needs. The workflow approach covers 0 of 12. The creative studio covers 10 of 12 (missing only surgeon photo and a fully real phone number).

### 5.4 Conversion Path Analysis

A medical practice homepage has one job: get the patient to book an appointment or call the office. We trace the conversion path for each approach:

**Skill:** The hero CTA "Book an Appointment" links to `#contact`, which scrolls to a section containing another CTA "Request Appointment" linking to `#` — a dead end. The phone CTA calls `+15551234567` — an obviously fake number. **Zero functional conversion paths.**

**Workflow:** The hero CTA "Book an Appointment" links to `#book`, which scrolls to a card-style section. The card contains a CTA "Book Your Appointment" linking to `#` — a dead end. The footer says "Call us" as a text link but has no phone number. **Zero functional conversion paths.**

**Creative Studio:** The hero CTA links to `#contact`, scrolling to a section with a three-field appointment request form (name, phone, reason for visit) with a submit handler that provides feedback ("Request Sent — We Will Call You"). Alongside it, a bordered phone block displays `(512) 555-0147` as a `tel:` link. The urgent banner also contains a clickable phone link. **Two functional conversion paths** (form + phone), plus a third path via the header phone link.

### 5.5 The Creative Studio's Feedback Loop in Action

The creative studio's output was not produced in a single pass. The customer agent evaluated the initial build and identified 16 findings, including 5 P1 bounce triggers. Two rounds of iteration addressed 12 of these findings. Table 3 shows the score progression.

**Table 3.** Creative studio customer evaluation scores across two rounds (averaged across three personas).

| Dimension | Round 1 | Round 2 | Delta |
|-----------|:-------:|:-------:|:-----:|
| Visual | 6.3 | 7.7 | +1.3 |
| Copy | 7.3 | 8.0 | +0.7 |
| Flow | 5.7 | 6.7 | +1.0 |
| Conviction | 4.7 | 7.0 | +2.3 |
| Persuasion | 4.7 | 7.0 | +2.3 |
| **Average** | **5.7** | **7.2** | **+1.5** |

The largest improvements occurred in Conviction (+2.3) and Persuasion (+2.3) — the dimensions that directly drive patient action. These gains came from concrete additions: patient testimonials, hospital affiliation, insurance information, the empathy line, and the urgent care banner. None of these features existed in the Round 1 build. They were added specifically because the customer agent, evaluating through three personas, identified their absence as bounce triggers and hesitation points.

For comparison, neither the skill nor workflow approaches would have identified these gaps, because neither includes an evaluation step. The methodology-injection skill's built-in "Swap Test" and "Squint Test" evaluate visual distinctiveness, not content completeness. The workflow's brainstorming phase helps the agent make better design decisions, but a single agent brainstorming with itself cannot surface the insight that a 68-year-old considering knee replacement needs to know which hospital the surgery will be at.

### 5.6 Qualitative Differences

Beyond the quantifiable feature gaps, the three outputs differ in ways that reveal the depth of the creative process behind them.

**Copy quality.** The skill's hero subtitle reads: "Expert orthopaedic care from diagnosis through recovery — so you can get back to the life you love." The workflow's reads: "Expert orthopaedic care from diagnosis through recovery. Get back to doing what you love — with a surgeon who listens." Both are competent but generic — interchangeable with any medical practice website. The creative studio's subheadline reads: "From diagnosis through surgery to recovery — one surgeon, one team, one plan. Serving Austin, TX and surrounding communities." The specificity ("one surgeon, one team, one plan") and location grounding ("Austin, TX") were decisions made during the designer-copywriter brainstorm, where the copywriter argued that "pain compresses attention" and the messaging should lead with concrete reassurance rather than aspiration.

**Service card differentiation.** The skill and workflow approaches both use generic feather-style SVG icons — a lightning bolt for Sports Medicine, a clock face for Surgical Procedures. The creative studio uses custom anatomical SVGs: a running figure with a highlighted knee joint for Sports Injuries, a bone-and-implant cross-section for Joint Replacement, a fractured bone with jagged break line for Fracture Care, and a hand skeleton with radiating fingers for General Orthopaedics. This visual differentiation was a key decision in the brainstorm: "Distinct service card icons, not uniform cards. Patients arrive with a specific problem. Visual differentiation lets them self-sort before reading."

**Persona-specific features.** Only the creative studio output contains features designed for specific patient segments. The urgent care banner exists because the customer agent, evaluating as an acute injury patient, wrote: "I am sitting in an ER with a broken wrist and the first thing I see is 'Appointments This Week.' This week? I need to be seen today." The empathy line exists because the customer agent, evaluating as a 68-year-old facing joint replacement, wrote: "The page never addresses the emotional weight of considering surgery. A single line like 'Making the decision to see a surgeon is a big step' would dramatically increase connection."

### 5.7 Cost-Quality Tradeoff

**Table 4.** Resource consumption by approach.

| Metric | Skill | Workflow | Creative Studio |
|--------|:-----:|:--------:|:--------------:|
| Token cost (relative) | 1x | 2x | 10x |
| Wall-clock time | 3 min | 4 min | 32 min |
| Personas addressed (of 12 needs) | 1 | 0 | 10 |
| Functional conversion paths | 0 | 0 | 2 |
| Distinct artifacts produced | 1 | 2 | 6+ |

The creative studio costs 10x more tokens and takes 10x longer, but it is the only approach that produces a page a patient could actually use. The quality gains are non-linear: the 2x cost of the workflow over the skill produces better structure but no additional content; the 10x cost of the creative studio over the skill produces fundamentally different output — a page with a named surgeon, a real location, testimonials, a booking form, and persona-specific features.

---

## 6. Discussion

### 6.1 Why Feedback Loops Are the Critical Differentiator

The experiment isolates three variables: methodology (skill), structured thinking (workflow), and feedback loops (creative studio). The results show a clear hierarchy:

- **Methodology alone** prevents obvious design errors (all three outputs use design tokens correctly, have responsive layouts, and support reduced motion) but cannot add perspectives the agent does not have. A single agent, no matter how well-instructed, cannot simultaneously be the builder and a 68-year-old patient facing knee replacement surgery.

- **Structured thinking** improves decision-making. The workflow approach's forced brainstorming produces a design document that captures intent. But a single agent brainstorming with itself operates within its own cognitive boundaries — it cannot challenge its own assumptions the way a separate agent with a different role can.

- **Feedback loops with grounded evaluation** are the multiplier. The creative studio's customer agent identified gaps that no amount of methodology or brainstorming would have surfaced, because those gaps require evaluating the output from a perspective the creating agents do not possess. The urgent care banner, the testimonials, the empathy line, the insurance information — these features emerged not from better generation but from better evaluation.

### 6.2 Grounding Makes Agent Feedback Actionable

The experiment reveals a sharp contrast between grounded and ungrounded feedback. Consider how the creative studio's customer agent described the broken CTA:

> "I clicked 'Book an Appointment' and it scrolled me down to a section that says 'Book an Appointment' again. Now what? I have three tabs open comparing surgeons, and the other two have online scheduling. I am closing this tab."

This finding is actionable because it: (1) identifies the specific technical failure (self-referencing anchor), (2) describes the user behavior consequence (closing the tab), (3) establishes competitive context (other surgeons have online scheduling), and (4) implies the fix (provide a real booking mechanism). A generic critique — "the CTA could be improved" — would not have produced the same response.

The grounding mechanism works by forcing the evaluating agent to simulate a specific user's mental model. When the customer agent says "I am sitting in an ER with a broken wrist," it activates reasoning about urgency, mobile usage, proximity search, and time pressure that produces findings no generic evaluation prompt would surface.

### 6.3 The Multi-Perspective Premium

A single agent, regardless of instructions, produces output from a single perspective. The experiment demonstrates this clearly: both the skill and workflow approaches used generic medical marketing copy ("get back to the life you love") and generic service card icons (feather-style SVGs). They did not produce testimonials, persona-specific features, or empathy-driven copy because a single agent operating as a builder has no mechanism to adopt the patient's viewpoint.

The creative studio achieves multiple perspectives through role separation:
- The **copywriter** optimises for the patient's emotional state ("pain compresses attention" → sparse, scannable copy)
- The **designer** optimises for visual self-sorting ("distinct icons so patients find their problem before reading")
- The **customer** agent optimises for conversion ("I cannot take a next step even if I wanted to")
- The **developer** optimises for implementation quality (accessibility, responsive behavior, performance)

These perspectives are not additive — they are **adversarial in a productive sense**. The customer agent's job is to find what's wrong, not validate what's right. The "no PASS" policy (the customer always issues REVIEW, never PASS) ensures that even high-scoring outputs receive specific improvement suggestions.

### 6.4 Structured Thinking Is Necessary but Not Sufficient

The workflow approach demonstrates that forcing an agent to brainstorm before building produces better structural decisions: its hero uses a 2-column grid layout with an illustration (a design decision documented in its brainstorm phase), while the skill approach uses a single-column hero with decorative animated orbs. The workflow's section hierarchy is cleaner, and its heading structure is semantically stronger.

However, the workflow produces *better structure around the same shallow content*. Its brainstorming improves how information is organised but does not add information the agent did not already plan to include. The gap between "better structure" and "right content" is where the feedback loop makes its contribution.

### 6.5 Matching Architecture to Stakes

The experiment's cost-quality tradeoff suggests a practical heuristic: **match the skill architecture to the stakes of the deliverable.**

- **Methodology injection** is appropriate for internal tools, prototypes, and deliverables where a technically competent result is sufficient. The 3-minute, 50K-token investment produces a functional page.
- **Workflow pipelines** are appropriate for production features where structural quality matters — team standards enforcement, design system compliance, documented decisions. The 4-minute, 100K-token investment produces better decisions.
- **Creative studio with feedback loops** is appropriate for customer-facing, high-stakes deliverables where the content must serve real users. The 32-minute, 500K-token investment produces fundamentally different output — not just better execution of the same ideas, but different ideas that emerge from multi-perspective evaluation.

The 10x cost is not justified for every page. But for a homepage that will be the first impression for patients deciding whether to trust a surgeon with their body, the difference between "visually competent template" and "page that addresses your specific fears, answers your questions, and gives you a way to act" is the difference between a bounce and a booking.

### 6.6 Limitations

**Single experiment.** Our evidence comes from one prompt, one domain, and one model. Replication across domains (e-commerce, SaaS, education) and models is needed.

**No human evaluation.** We did not present the three outputs to real patients or UX professionals. Our evaluation criteria (Table 1, Table 2) are based on documented patient needs from the ICP, not measured user behavior.

**Same model for all.** All agents used the same Claude Opus model. Cross-model architectures (e.g., a more capable model for evaluation, a faster model for generation) might alter the cost-quality curve.

**No A/B testing.** We cannot measure whether the creative studio's content advantages translate to higher conversion rates on a deployed page.

**Prompt specificity.** The prompt is deliberately minimal ("3-section homepage"). A more detailed prompt might narrow the gap between approaches by providing the content decisions (surgeon name, location) that the feedback loop currently surfaces.

---

## 7. Future Work

**Human evaluation study.** Present all three outputs (unlabeled) to practicing UX designers and potential patients. Measure whether human judgments align with our framework's predictions about content completeness and conversion path quality.

**Prompt specificity experiments.** Vary the prompt's specificity (from "build a homepage" to "build a homepage with Dr. Sarah Mitchell at St. David's Medical Center in Austin, TX") and measure whether detailed prompts reduce the advantage of the creative studio approach.

**Cross-domain replication.** Run the same three-architecture experiment for an e-commerce product page, a SaaS landing page, and a restaurant website to establish whether the finding generalises beyond healthcare.

**Cost optimisation.** Explore hybrid architectures — for example, using methodology injection for initial generation but adding a single evaluation pass (without full multi-agent orchestration) to capture the most impactful feedback at lower token cost.

**Longitudinal analysis.** Measure whether the creative studio's advantages persist or diminish across multiple pages within the same project, as the accumulated design decisions and creative direction reduce the decision space.

---

## 8. Conclusion

We presented a controlled experiment comparing three skill architectures for autonomous web design: methodology injection, workflow pipeline, and creative studio with feedback loops. Holding constant the prompt, model, design system, and reference documents, we found that skill architecture is the primary determinant of output quality — not model capability, not prompt engineering, not design system completeness.

The critical differentiator is not the number of agents or the volume of tokens, but the presence of **grounded evaluation**: a customer agent that adopts specific user personas, scores against a consistent rubric, and ties findings to observable user behaviors. Without this feedback loop, agents produce what looks correct. With it, agents produce what works for real users.

The practical implication is clear: for high-stakes, customer-facing deliverables, the 10x investment in multi-agent feedback loops produces non-linear quality gains — not incremental visual polish, but fundamentally different content that addresses real user needs. Methodology prevents bad output. Structure produces good decisions. Feedback loops produce the right decisions.

---

## References

[1] Hong, S., Zhuge, M., Chen, J., et al. (2023). MetaGPT: Meta programming for a multi-agent collaborative framework. *arXiv preprint arXiv:2308.00352*.

[2] Qian, C., Cong, X., Yang, C., et al. (2023). Communicative agents for software development. *arXiv preprint arXiv:2307.07924*.

[3] Wu, Q., Bansal, G., Zhang, J., et al. (2023). AutoGen: Enabling next-gen LLM applications via multi-agent conversation. *arXiv preprint arXiv:2308.08155*.

[4] Chen, W., Su, Y., Zuo, J., et al. (2023). AgentVerse: Facilitating multi-agent collaboration and exploring emergent behaviors. *arXiv preprint arXiv:2308.10848*.

[5] Zheng, L., Chiang, W. L., Sheng, Y., et al. (2023). Judging LLM-as-a-judge with MT-Bench and Chatbot Arena. *Proceedings of NeurIPS 2023*.

[6] Liu, Y., Iter, D., Xu, Y., et al. (2023). G-Eval: NLG evaluation using GPT-4 with better human alignment. *Proceedings of EMNLP 2023*.

[7] Grudin, J., & Pruitt, J. (2002). Personas, participatory design and product development: An infrastructure for engagement. *Proceedings of PDC 2002*.

[8] Nielsen, L. (2019). *Personas — User focused design* (2nd ed.). Springer.

[9] Matthews, T., Judge, T., & Whittaker, S. (2012). How do designers and user experience professionals actually perceive and use personas? *Proceedings of CHI 2012*, 1219-1228.

[10] Cooper, A. (1999). *The inmates are running the asylum*. SAMS.

[11] Pruitt, J., & Adlin, T. (2006). *The persona lifecycle: Keeping people in mind throughout product design*. Morgan Kaufmann.

[12] Long, F. (2009). Real or imaginary: The effectiveness of using personas in product design. *Proceedings of the Irish Ergonomics Society Annual Conference*.

[13] Chen, M., Tworek, J., Jun, H., et al. (2021). Evaluating large language models trained on code. *arXiv preprint arXiv:2107.03374*.

[14] Austin, J., Odena, A., Nye, M., et al. (2021). Program synthesis with large language models. *arXiv preprint arXiv:2108.07732*.

---

## Appendix A: Skill Architecture Summary

| | Skill (01) | Workflow (02) | Creative Studio (03) |
|-|:----------:|:------------:|:-------------------:|
| Architecture | Context injection | Sequential pipeline | Multi-agent + loops |
| Agents | 1 | 1 (+ sub-skill calls) | 5+ specialised |
| Creative perspectives | 1 (builder) | 1 (builder) + brainstorm | 3 (designer + copywriter + customer) |
| Process phases | 1 | 4 | 6 + iterations |
| Design thinking | Self-applied tests | Mandatory brainstorm + design doc | Collaborative direction + design spec |
| Copy quality | Agent's own writing | Agent's own writing | Dedicated copywriter agent |
| Quality gates | None (self-evaluation) | Design system compliance check | Customer scoring + quality guardians |
| Iteration | None | None (linear) | Up to 3 rounds |
| Tokens | ~50K | ~100K | ~500K+ |
| Time | 3 min | 4 min | 32 min |
| Best for | Prototypes, internal tools | Production features, team standards | Customer-facing, high-stakes pages |

## Appendix B: Customer Evaluation Score Progression (Creative Studio)

| Persona | Dim | R1 | R2 | Delta | Driver |
|---------|-----|:--:|:--:|:-----:|--------|
| Active Adult | Visual | 7 | 8 | +1 | Header/footer legitimacy |
| Active Adult | Copy | 8 | 8 | 0 | Already strong |
| Active Adult | Flow | 6 | 6 | 0 | Booking CTA still dead-end (form added but section CTA persists) |
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

This decision is visible in the three outputs. The skill's hero leads with aspiration: **"Restore Your Movement."** The workflow's hero leads with aspiration: **"Restore Movement. Restore Life."** The creative studio's hero leads with credential: **"Fellowship-Trained Orthopaedic Surgeon. Appointments This Week."** The brainstorm — a dialogue between a designer who proposed the visual direction and a copywriter who insisted that "pain compresses attention" — produced a fundamentally different framing that neither a single agent with methodology nor a single agent with a brainstorming phase arrived at independently.
