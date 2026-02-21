# Customer Review: Round 1

**Verdict: REVIEW**

**Evaluated output:** Homepage build (`docs/studio/workspace/build/index.html`), copy (`docs/studio/workspace/copy.md`), design spec (`docs/studio/workspace/design-spec.md`)
**Date:** 2026-02-21

---

## Evaluation 1: Active Adult (30-55) with Sports Injury or Joint Pain

**Persona lens:** Active Adult
**Persona context:** Working professional or recreational athlete, currently in pain. Googled "orthopaedic surgeon near me" or got a GP referral. Comparing 2-3 options in browser tabs. Wants to know this surgeon is qualified, available soon, and not going to waste their time.

### Dimension Scores

| Dimension | Score | Severity | Summary |
|-----------|-------|----------|---------|
| Visual | 7/10 | P2 | Clean and professional, but the anatomical SVGs read as abstract art rather than medical authority. No photo of the doctor or the practice -- feels faceless. |
| Copy / Messaging | 8/10 | P2 | Reassurance-first approach lands well. "Appointments This Week" is strong. But copy uses em dashes (--) instead of real em dashes, and the subheadline is generic enough to be any practice. |
| Flow | 6/10 | P1 | The CTA "Book an Appointment" links to #booking which scrolls to a section that has... another "Book an Appointment" button that links to #booking (itself). There is no actual booking destination. This is a dead end. |
| Conviction | 5/10 | P1 | The surgeon's name is a placeholder ("Dr. [First] [Last], MD"). The phone number is fake. There are zero patient reviews, zero named hospital affiliations, zero insurance details. I cannot build trust with brackets and placeholder text. |
| Persuasion | 5/10 | P1 | I have no way to actually book. The CTA is a self-referencing anchor link. Even if this were a real link, there is no online booking form, no scheduling system, nothing. The entire conversion funnel terminates at a teal button that goes nowhere. |

### Why I Would Walk Away

I clicked "Book an Appointment" and it scrolled me down to a section that says "Book an Appointment" again. Now what? I am supposed to call a fake number? I have three tabs open comparing surgeons, and the other two have online scheduling. I am closing this tab. The page looks clean but it feels like a template that was never finished -- placeholder names, dummy phone numbers, no reviews, no location, no insurance information. I cannot take a next step even if I wanted to.

### Findings

#### P1 -- Would Cause Me to Leave

1. **Flow:** The hero CTA `href="#booking"` scrolls to section 3, where the second CTA also has `href="#booking"` -- pointing to itself. There is no actual booking destination (no form, no external scheduling link, no mailto). The entire page has zero functional conversion paths. -> Replace `#booking` with an actual booking URL (Calendly, Jane App, practice management system) or, at minimum, an appointment request form embedded in section 3.

2. **Conviction:** Surgeon name is `Dr. [First] [Last], MD` -- literal brackets in the rendered HTML. A patient seeing this will immediately conclude the page is unfinished or fake. -> This must be a real name before the page goes live. If this is a template, the evaluation cannot proceed meaningfully on conviction until real data is present.

3. **Conviction:** Phone number `(555) 123-4567` is an obvious test number. Any adult recognises 555 numbers from TV shows. This destroys credibility for the entire trust section. -> Replace with real practice phone number.

4. **Flow:** There is no navigation bar, no header, no footer. The page has no practice name visible (the copy doc specifies `[Practice Name] Orthopaedics` but it never appears in the HTML). A patient landing here from search has no brand anchor -- they do not know whose website they are on. -> Add a minimal sticky header with the practice name and a persistent "Book" CTA. Add a footer with address, hours, and phone.

5. **Persuasion:** There is no location information anywhere on the page. The ICP doc says patients search "orthopaedic surgeon near me." A page with no address, no map, no city name cannot answer the most basic question: "Is this near me?" -> Add practice location (city, suburb, or address) to section 3 or a footer. Even "Serving [City] and surrounding areas" would help.

#### P2 -- Would Make Me Hesitate

1. **Visual:** The anatomical SVG illustrations (knee, shoulder, hip) in the hero are thin-stroke line drawings that require medical knowledge to parse. A patient in pain does not look at abstract joint diagrams and think "this is my doctor." They look for a photo of a real person. The SVGs are decorative at best, confusing at worst. -> Consider replacing or supplementing with a CSS-based doctor portrait placeholder, or at minimum, make the SVGs larger and more immediately recognisable as body parts.

2. **Copy:** The subheadline "Get back to the life you love" is warm but interchangeable with any physiotherapy clinic, wellness spa, or rehab centre. It does not say anything specific to orthopaedic surgery. -> Make it specific: "From diagnosis to surgery to recovery -- one surgeon, one team, one plan" or similar language that signals the full-service orthopaedic value.

3. **Copy:** The raw `--` characters appear instead of proper em dashes throughout the build (line 707, 929 in the HTML). This looks like broken formatting to a patient. -> Use actual em dash characters or convert them in the build step.

4. **Conviction:** Zero patient testimonials, reviews, or social proof. The stat blocks (15+ years, 3,000+ procedures) are strong but unsupported -- there is no context for who this surgeon is, where they trained, or what patients say about them. -> Add at least 2-3 short patient quotes, even anonymised. "After my knee replacement, I was walking the next day" carries more weight than "3,000+ Procedures Performed."

5. **Visual:** The services section subheading text sits directly on the `#F7F9FC` background but uses `--color-text-primary` (#1A1A2E). The design spec flagged that `#6B7280` on `#F7F9FC` is borderline AA (4.4:1). The build correctly uses text-primary for the subheading, but the card descriptions use `#6B7280` on white card backgrounds (4.6:1) -- this is AA compliant but tight. Verify in real rendering. -> Run an automated contrast check on the final rendered output.

6. **Flow:** No insurance information anywhere. For the 55+ segment especially, "do you take my insurance?" is a make-or-break question that precedes any booking intent. -> Add a line in section 3 or a footer: "We accept most major insurance plans. Call to verify your coverage."

#### P3 -- Would Reduce My Confidence

1. **Visual:** The pulse-line divider animation is a nice signature detail, but on slow scroll it fires and finishes before the user notices it. There is no replay or indication it happened. If a patient scrolls quickly past it, they miss the only motion element on the page. -> Consider a slightly longer animation duration (2.5-3s) or trigger at a lower threshold (0.3 instead of 0.5).

2. **Copy:** Trust badge labels use uppercase text at 12px (`ORTHOPAEDIC SURGERY`, `SUB-SPECIALTY EXPERTISE`). "Sub-Specialty Expertise" is industry jargon that means nothing to a patient. -> Replace with "Sports & Joint Specialist" or similar patient-facing language.

3. **Copy:** "How We Help You Move Again" as a section heading is warm but slightly presumptuous -- not every patient has lost mobility. Someone with a nagging knee might still be running on it. -> Consider "What We Treat" or "Our Specialties" as more neutral alternatives that do not assume a specific patient state.

4. **Visual:** The service card hover effect (translateY -2px, deeper shadow) exists on cards that have no click action. This creates a false affordance -- the card looks interactive but does nothing when clicked. A patient might click a card expecting to see more detail and get frustrated. -> Either remove the hover effect from non-interactive cards or make them link to service detail sections.

5. **Copy:** The meta description and page title are solid for SEO but the title does not include a location. "Fellowship-Trained Orthopaedic Surgeon | Same-Week Appointments" will rank poorly against "Orthopaedic Surgeon in [City] | Same-Week Appointments." -> Add city/region to the title tag.

6. **Visual:** On mobile (< 768px), the anatomical SVG illustration drops to 200px max-width at 0.25 opacity. At that point it is a ghost of a decoration -- either show it properly or remove it entirely. A barely-visible illustration signals indecision. -> Either hide it completely on mobile (`display: none`) or show it at a legible opacity (0.5+).

### What Almost Worked

1. **The hero headline structure (credential + availability)** is exactly right. "Fellowship-Trained Orthopaedic Surgeon. Appointments This Week." answers the two biggest questions in the first line. The reassurance-first approach from the creative direction was executed faithfully. It just needs a real name and a real booking path to convert the trust it builds.

2. **The dual CTA (button + phone number) in section 3** is a smart decision that respects the older patient segment. The "or" divider and the phone framing line ("Prefer to call?") are well-crafted. This pattern would work well if the button actually went somewhere.

---

## Evaluation 2: Older Adult (55+) Facing Joint Replacement

**Persona lens:** Older Adult
**Persona context:** Retiree or near-retiree with chronic knee or hip pain. GP said "you should see an orthopaedic surgeon." Possibly arrived via a family member who searched for them. Wants a trustworthy, experienced surgeon close to home. May be anxious about surgery. Will likely want to call rather than book online.

### Dimension Scores

| Dimension | Score | Severity | Summary |
|-----------|-------|----------|---------|
| Visual | 6/10 | P2 | Text is readable, but the page feels sparse and impersonal. No photo of the doctor, no photo of the facility. Older patients want to see a face. |
| Copy / Messaging | 7/10 | P2 | Warm tone is right. "No referral needed" is excellent (many older patients assume they need one). But the page never mentions joint replacement prominently enough for someone whose GP specifically said those words. |
| Flow | 6/10 | P1 | Same dead-end CTA problem. But for this persona, the phone number path is more relevant -- and it works (the tel: link is functional). However, the phone number is fake, which negates the entire path. |
| Conviction | 4/10 | P1 | This patient is facing a major life decision (surgery). They need to know where this doctor trained, which hospital they operate at, how many joint replacements they have done specifically. "3,000+ procedures" is not specific enough when I am about to let someone cut into my knee. |
| Persuasion | 5/10 | P1 | No urgency mechanism for this persona. Joint pain gets worse over time, but the page never says that. No "the sooner we assess, the more options you have" framing. |

### Why I Would Walk Away

My doctor told me I might need a knee replacement. That is a big deal. I am on this website and I see "3,000+ Procedures Performed" -- but how many of those were knee replacements? Where does this surgeon operate? Which hospital? I do not see a face, I do not see a location, and the name is literally in brackets. My daughter found this website for me and now I am going to tell her "it looks like it is not finished yet." I would rather go with the surgeon my friend recommended, someone I can actually look up.

### Findings

#### P1 -- Would Cause Me to Leave

1. **Conviction:** No hospital affiliation mentioned anywhere. For a 65-year-old considering joint replacement, "which hospital will the surgery be at?" is a critical trust factor. They want a surgeon affiliated with a reputable local hospital. -> Add hospital/surgical centre affiliation to the surgeon bio or stat blocks.

2. **Conviction:** "3,000+ Procedures Performed" is too vague for a surgical decision. A joint replacement patient wants to know specifically about joint replacement volume. "500+ Joint Replacements" or "Performs 100+ joint replacements per year" is dramatically more convincing. -> Break out procedure-specific volume where possible, especially for the highest-stakes service.

3. **Flow:** Same self-referencing `#booking` CTA issue as Evaluation 1. For this persona, the phone number is the primary path -- but `(555) 123-4567` is obviously fake. If the phone number worked, this persona's flow would be functional despite the broken button. -> Real phone number is non-negotiable for this audience.

4. **Persuasion:** The page never addresses the emotional weight of considering surgery. Older adults are not just in pain -- they are anxious, possibly scared. The copy is warm but never acknowledges the gravity of the decision. A single line like "Making the decision to see a surgeon is a big step. We are here to answer every question before anything else happens." would dramatically increase connection. -> Add an empathy-forward line in section 3 near the booking CTA.

#### P2 -- Would Make Me Hesitate

1. **Copy:** "Get back to the life you love" is aspirational, but for a 70-year-old with bone-on-bone arthritis, "the life you love" might feel patronising or unrealistic. They want to walk without pain, not run a marathon. -> Consider a more grounded aspiration: "Walk without pain. Sleep through the night. Get back to your daily life."

2. **Visual:** No photo of the surgeon. For older patients, seeing the face of the person who might operate on them is a major trust signal. The page has thin-stroke SVG line art instead of a human presence. -> If photos are not available, at minimum add more biographical detail (where they trained, professional memberships) to compensate for the missing visual trust signal.

3. **Flow:** There is no mention of telehealth or virtual consultation options. The ICP doc lists telehealth as a delivery channel. For an older patient who may have mobility limitations, knowing they can do an initial consultation via video is a meaningful accessibility factor. -> Add a brief mention: "Virtual consultations available for initial assessments."

4. **Conviction:** No mention of insurance acceptance. This is often the first question an older patient (or their adult child) asks. The PRODUCT.md mentions "transparent pricing for self-pay patients," which implies they also accept insurance -- but the page says nothing. -> Add insurance information or at least a "We accept most major insurance plans" statement.

#### P3 -- Would Reduce My Confidence

1. **Visual:** The 14px body-small text on service cards may be challenging for older eyes, especially on mobile. The design system specifies 14px as the smallest body text, but for a 65+ audience, 16px minimum for all readable content would be safer. -> Consider using 16px for card descriptions, especially given the target demographic includes 55+.

2. **Copy:** "Ready to Get Moving?" as the booking section heading is too casual for someone facing potential surgery. It reads like a gym ad. For this persona, something like "Take the First Step" or "Schedule Your Consultation" would feel more appropriate to the weight of the decision. -> Adjust the booking heading to match the gravity of the patient's situation.

3. **Flow:** The page has no mention of what to bring or expect at a first appointment. Older patients want to prepare. Even a single line -- "Bring your imaging results and a list of medications" -- would reduce anxiety about the unknown. -> Consider adding a brief "What to expect" note near the booking CTA.

### What Almost Worked

1. **"No referral needed"** in the booking subtext is precisely the right message for this persona. Many older patients assume they need a GP referral before seeing a specialist, and this removes a significant barrier. This is a smart, audience-aware detail.

2. **The phone block with "Prefer to call?" framing** is exactly what this persona needs. The equal visual weight of phone vs. button (per the creative direction) was executed well. The bordered phone block with large number is easy to find and tap. It just needs a real number behind it.

---

## Evaluation 3: Acute Injury Patient (All Ages)

**Persona lens:** Acute Injury Patient
**Persona context:** Just broke something or tore something. In urgent pain. Possibly in an ER waiting room or just left urgent care with a referral. Searching on their phone. Needs to know: can I be seen today or tomorrow? Will this person fix my specific problem?

### Dimension Scores

| Dimension | Score | Severity | Summary |
|-----------|-------|----------|---------|
| Visual | 6/10 | P2 | Page is clean but nothing screams "we handle emergencies." The fracture card is buried as the third of four equal-weight service cards. |
| Copy / Messaging | 7/10 | P3 | "Walk-in appointments available for urgent fractures" is buried in a card description. This should be a top-level message for this persona. |
| Flow | 5/10 | P1 | Same dead-end CTA. But this persona needs URGENT contact. No hours listed, no "call now for same-day injury assessment," no after-hours information. |
| Conviction | 5/10 | P2 | "Same Day Imaging Available" is the right stat for this persona, but it is in the last section. By the time they scroll there, they may have already called someone else. |
| Persuasion | 4/10 | P1 | Zero urgency signalling for acute patients. No "injured today? Call now" anywhere above the fold. |

### Why I Would Walk Away

I am sitting in an ER with a broken wrist and they told me to follow up with an orthopaedic surgeon. I am on my phone. I land on this page and the first thing I see is "Fellowship-Trained Orthopaedic Surgeon. Appointments This Week." This week? I need to be seen today or tomorrow. I scroll to the service cards -- fracture care is the third card. The description says "Walk-in appointments available" -- but where? What are the hours? What is the address? I have no way to know if I can actually walk in. I Google the next surgeon instead.

### Findings

#### P1 -- Would Cause Me to Leave

1. **Persuasion:** The page has no urgent-care messaging above the fold. "Appointments This Week" is the strongest availability signal, but for someone with a fresh fracture, "this week" feels slow. The ICP identifies "urgent walk-in" as a service channel. -> Add an urgent callout: "Acute injury? Same-day walk-in appointments available. Call (XXX) XXX-XXXX" -- either as a top banner or prominently in the hero.

2. **Flow:** No practice hours anywhere on the page. An acute injury patient needs to know if they can show up right now. -> Add hours of operation, ideally in a sticky header or footer.

3. **Flow:** No address or location. Acute patients are searching by proximity. "Near me" is literally in their search query. -> Must include a physical address.

#### P2 -- Would Make Me Hesitate

1. **Visual:** The fracture care card has equal visual weight with "General Orthopaedics." For an acute patient, fracture care is urgent and time-sensitive. It should stand out. -> Consider visual differentiation for the fracture card (e.g., a subtle accent border or an "urgent" badge) to help acute patients self-sort faster.

2. **Copy:** "Walk-in appointments available for urgent fractures and dislocations" is buried in 14px body-small text inside a card. This is the most time-sensitive information on the page and it has the least visual prominence. -> Elevate walk-in availability to a hero-level trust badge or a standalone callout between sections.

#### P3 -- Would Reduce My Confidence

1. **Copy:** The phrase "Broken bones need the right treatment from the start" in the fracture card is good urgency-building copy. But it is isolated -- the rest of the page does not reinforce the "get it right the first time" message for acute injuries. -> Thread urgency more consistently if acute patients are a meaningful segment.

### What Almost Worked

1. **"Same Day Imaging Available"** as a stat block is exactly the right signal for an acute injury patient. It tells them they will not be sent somewhere else for an X-ray. It just needs to appear earlier in the page flow -- ideally visible without scrolling.

---

## Cross-Evaluation Summary

### Critical Issues (Must Fix Before Any Further Iteration)

| # | Issue | Severity | Impact |
|---|-------|----------|--------|
| 1 | CTA button links to `#booking` which is the section it sits in -- zero functional booking path exists | P1 | No patient can convert. The page has no purpose without a working CTA. |
| 2 | Surgeon name is placeholder brackets `[First] [Last]` in rendered HTML | P1 | Destroys all credibility. Page looks unfinished/fake. |
| 3 | Phone number is `(555) 123-4567` -- obviously fake | P1 | Negates the phone-call conversion path entirely. |
| 4 | No practice name, address, city, hours, or location information anywhere | P1 | Cannot answer "is this near me?" -- the #1 question for local healthcare search. |
| 5 | No navigation header or footer | P1 | Page has no brand anchor, no persistent CTA, no wayfinding. |

### Structural Issues (Fix In This Iteration)

| # | Issue | Severity | Impact |
|---|-------|----------|--------|
| 6 | No patient testimonials or social proof | P2 | Stats without stories do not build trust for surgical decisions. |
| 7 | No insurance information | P2 | Major decision factor for both primary segments. |
| 8 | No hospital/surgical centre affiliation | P2 | Critical for joint replacement patients. |
| 9 | Raw `--` instead of em dashes in rendered HTML | P2 | Looks like broken formatting. |
| 10 | Anatomical SVGs are too abstract to communicate medical authority | P2 | Decorative but not persuasive. |

### Creative Direction Adherence

The build faithfully executes the creative direction from the brainstorm:

- **Reassurance-first headline:** Delivered. Credential + availability in the hero.
- **Standalone stat blocks:** Delivered. Bold numbers, scannable.
- **Distinct service card icons:** Delivered. Each SVG is unique and differentiable.
- **Dual CTA paths (button + phone):** Delivered. "Or" divider, phone framing line, bordered phone block.
- **Single motion element (pulse line):** Delivered. ECG-style line with scroll-triggered draw animation.
- **Teal reserved for CTAs and pulse line:** Delivered. Accent colour is disciplined.
- **Design token compliance:** Delivered. All colours, spacing, and typography match the design system.

The creative direction was well-conceived and well-executed at the design/build level. The failures are all in the "last mile" -- the page was built as a template with placeholder content and no functional booking path. The design decisions are sound; the page just cannot convert anyone because it is not connected to a real practice, a real surgeon, or a real scheduling system.

### Recommendation for Next Iteration

1. Populate all placeholder content with real practice data (surgeon name, phone, address, hours).
2. Connect the CTA to a real booking mechanism (embedded form, external scheduling link, or at minimum a contact form).
3. Add a minimal header (practice name + book button) and footer (address, hours, phone, insurance note).
4. Add 2-3 patient testimonials in section 3 or between sections 2 and 3.
5. Add location/city name to the page title, hero area, and section 3.
6. Consider an urgent-care banner for acute injury patients if that segment is a meaningful part of the practice.
