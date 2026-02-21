# Customer Review: Round 2

**Verdict: REVIEW**

**Evaluated output:** Homepage build (`docs/studio/workspace/build/index.html`), copy (`docs/studio/workspace/copy.md`)
**Date:** 2026-02-21
**Previous review:** `docs/studio/customer-review-round-1.md`

---

## Round 1 P1 Resolution Audit

| # | Round 1 P1 Issue | Status | Notes |
|---|-----------------|--------|-------|
| 1 | CTA `#booking` self-referencing loop -- zero functional booking path | PARTIALLY RESOLVED | Anchor renamed from `#booking` to `#contact`, which is a real section. But the "Book an Appointment" button inside section 4 (line 1433) has `href="#contact"` and sits inside the element with `id="contact"` (line 1409). Clicking it scrolls you nowhere -- you are already there. The hero CTA and header CTA correctly scroll you *down* to section 4, so those work as navigation. But there is still no actual booking mechanism: no form, no Calendly link, no external scheduling URL. The conversion path terminates at a button that does nothing. |
| 2 | Surgeon name is placeholder brackets `[First] [Last]` | RESOLVED | "Dr. Sarah Mitchell, MD" appears consistently in the heading, bio, testimonials, footer, and meta description. |
| 3 | Phone number is obviously fake `(555) 123-4567` | IMPROVED | Changed to `(512) 555-0147` with Austin area code. Significantly more plausible. Still technically a 555 number (reserved for fiction), but an average patient would not recognize it as fake the way they would `(555) 123-4567`. Acceptable for a prototype. |
| 4 | No practice name, address, city, hours, or location | RESOLVED | "Mitchell Orthopaedics" in header. Full address in footer. "Austin, TX" in hero subheadline and page title. Hours in footer including Saturday walk-in hours. |
| 5 | No navigation header or footer | RESOLVED | Sticky header with brand, nav links, phone, and CTA button. Three-column footer with address, hours, quick links, insurance, and copyright. Mobile hamburger menu implemented. |

**Summary:** 3 of 5 P1 issues fully resolved. 1 significantly improved (phone number). 1 partially resolved but still a critical gap (no actual booking mechanism -- the section 4 CTA remains a dead end).

---

## Evaluation 1: Active Adult (30-55) with Sports Injury or Joint Pain

**Persona lens:** Active Adult
**Persona context:** Working professional with a torn ACL or chronic knee pain. Googled "orthopaedic surgeon Austin TX." Has two other tabs open. Wants to know this surgeon is qualified, available soon, and has a clear path to an appointment.

### Dimension Scores

| Dimension | Score | Severity | Summary |
|-----------|-------|----------|---------|
| Visual | 8/10 | P3 | Clean, professional, well-structured. Header and footer give it legitimacy. Anatomical SVGs still read as abstract but no longer feel like the page's biggest weakness. |
| Copy / Messaging | 8/10 | P2 | Reassurance-first headline is strong. Subheadline with location lands well. Testimonials add real proof. But the empathy line, while warm, creates a speed bump for someone who just wants to book fast. |
| Flow | 6/10 | P1 | Hero CTA and header CTA successfully navigate me to section 4. But section 4's "Book an Appointment" button links to `#contact` which is the section I am already in. There is no form, no scheduling link, no way to actually book. The conversion funnel still has no exit to a real action. |
| Conviction | 7/10 | P2 | Testimonials are a major upgrade. Marcus T.'s ACL story maps directly to my situation. Hospital affiliation (St. David's) adds local credibility. Stats are solid. But "3,000+ procedures" is still generic -- what kind of procedures? |
| Persuasion | 6/10 | P2 | The urgent banner is smart for acute patients but irrelevant to me. The page builds interest but does not close. I would forward this to a friend and say "this looks good" but I cannot actually book. Urgency is implied but never stated for my segment. |

### Why I Would Walk Away

I scrolled to the bottom section, read the empathy line (nice touch), and clicked "Book an Appointment." Nothing happened. I am already looking at the section the button points to. There is no form asking for my name, no calendar showing available slots, no "we will call you back within 2 hours" promise. My next action is unclear. The other surgeon's website has a Zocdoc widget. I click that instead. This page convinced me Dr. Mitchell is qualified -- and then gave me no way to act on that conviction.

### Findings

#### P1 -- Would Cause Me to Leave

1. **Flow:** The "Book an Appointment" CTA in section 4 (line 1433) has `href="#contact"` and sits inside the element with `id="contact"` (line 1409). Clicking it scrolls nowhere because you are already there. The hero and header CTAs correctly bring you to this section, but once you arrive, the final action button is a dead end. There is no booking form, no external scheduling link, no Calendly embed, no appointment request form. The entire page builds to a conversion moment that does not exist. -> Replace `href="#contact"` on the section 4 CTA with an actual booking URL (Calendly, Zocdoc, Jane App, or a practice management system). If no external service is available, embed a simple contact form (name, phone, reason for visit) directly in section 4 so the patient can take a concrete action.

#### P2 -- Would Make Me Hesitate

1. **Conviction:** "3,000+ Procedures Performed" is still the same generic stat from round 1. Round 1 specifically flagged this: a patient considering ACL surgery wants to know how many ACL reconstructions this surgeon has done, not a total across all procedure types. -> Add procedure-specific volume where it matters most. "500+ Sports Medicine Surgeries" or "800+ Arthroscopic Procedures" would be dramatically more convincing for this persona.

2. **Copy:** The empathy line ("Deciding to see a surgeon is a big step...") is well-written and addresses older patients well, but for a 35-year-old athlete, it reads slightly patronizing. I tore my ACL. I know I need a surgeon. I do not need to be told it is a big step -- I need to know you can fix my knee and I can play soccer again. -> Consider making the empathy line contextually lighter for the active adult segment, or position it after the CTA rather than before it so it does not slow down someone ready to book.

3. **Persuasion:** No competitor differentiation. The page establishes Dr. Mitchell's credentials but never tells me why I should choose her over the other orthopaedic surgeon in my search results. "Fellowship-trained" is table stakes in a major metro like Austin. -> Add one differentiating claim: fastest recovery times, specific surgical technique, or a concrete outcome stat ("95% of our ACL patients return to full activity within 6 months").

4. **Copy:** The testimonials are strong and persona-appropriate, but all three are unverifiable. There are no links to Google Reviews, Healthgrades, or any third-party platform. A patient comparing surgeons in 2026 will check external reviews regardless. -> Add a link to the practice's Google Reviews or Healthgrades profile to anchor the on-page testimonials in verifiable social proof.

#### P3 -- Would Reduce My Confidence

1. **Visual:** The service cards no longer have a hover effect that implies clickability (good -- round 1 flagged the false affordance with `translateY`). However, `box-shadow` still changes on hover (line 510-511). This is subtler than a transform but still suggests interactivity on non-interactive cards. -> Remove the hover shadow change on service cards entirely, or make them link to service detail anchors/pages.

2. **Copy:** The meta description includes the phone number, which is smart for mobile search results. But the number is still technically a 555 number. Any searcher who notices will question the practice's legitimacy in the search results themselves, before even clicking. -> Replace with a real practice phone number before going live.

3. **Flow:** The "Patient Forms" link in the footer quick links (line 1479 in copy.md) does not appear in the HTML build (line 1479 in index.html only has Services, About Dr. Mitchell, and Contact). The copy doc specifies it, but the build omits it. This is minor for a patient but indicates a copy-to-build sync gap. -> Either add the Patient Forms link or remove it from the copy doc.

### What Almost Worked

1. **The testimonials section** is the single biggest improvement from round 1. Marcus T.'s ACL story, Linda R.'s knee replacement regret-of-waiting, and Jennifer P.'s walk-in fracture experience each map to a specific persona. The attributions include location (Austin, Round Rock, Cedar Park) which builds local credibility. This section does real persuasive work.

2. **The urgent banner** ("Injured today? Same-day walk-in appointments available.") directly addresses the round 1 acute injury persona gap. It is dismissible, uses `role="alert"`, and includes a clickable phone number. This is exactly what was requested and it is well-executed.

---

## Evaluation 2: Older Adult (55+) Facing Joint Replacement

**Persona lens:** Older Adult
**Persona context:** 68-year-old with chronic knee pain. GP said "you should see an orthopaedic surgeon about that knee." Daughter searched online and found this page. Wants a trustworthy, experienced surgeon at a reputable hospital nearby. Will likely want to call.

### Dimension Scores

| Dimension | Score | Severity | Summary |
|-----------|-------|----------|---------|
| Visual | 7/10 | P3 | Professional and clean. The sticky header and footer give it the feel of a real practice. Still no surgeon photo, which matters more for this persona than any other. |
| Copy / Messaging | 8/10 | P2 | Empathy line is perfect for this persona. "Your first appointment is a conversation" directly addresses surgery anxiety. Insurance mention is reassuring. But joint replacement is not prominently featured above the fold. |
| Flow | 7/10 | P2 | The phone path works. `tel:` link is functional. Phone is in the header, the urgent banner, and section 4. If I want to call, I can. The booking button is still a dead end, but this persona is more likely to call anyway. |
| Conviction | 7/10 | P2 | Hospital affiliation (St. David's Medical Center) is a major trust signal for this persona -- this was a P1 gap in round 1 and it is now resolved. Testimonials help: Linda R. (age 68, Round Rock) is essentially this patient. Still lacks joint replacement-specific volume. |
| Persuasion | 7/10 | P3 | The page builds enough trust that I would consider calling. The dual CTA pattern works well for this persona. Urgency is not critical here -- this patient has been in pain for months. But there is no "the longer you wait, the fewer options you have" framing. |

### Why I Would Walk Away

My daughter found this website and showed it to me on her phone. I can see the doctor's name and that she is at St. David's -- I know that hospital, it is close to us. The testimonial from Linda, age 68, in Round Rock sounds like she could be my neighbor. I want to call. The phone number is right there. But here is what gives me pause: I cannot see this doctor's face. I do not see where she went to medical school or did her fellowship. "Fellowship-trained" is mentioned three times but I never learn where. For a decision this big -- letting someone operate on my knee -- I want to know more about the person. I would probably call anyway because of the St. David's affiliation, but I would also Google "Dr. Sarah Mitchell Austin orthopaedic" to find more information before I commit.

### Findings

#### P2 -- Would Make Me Hesitate

1. **Conviction:** "Fellowship-trained" is stated three times (hero headline, trust badge, bio) but the fellowship institution is never named. For a 68-year-old considering knee replacement, "fellowship at Johns Hopkins" or "fellowship at Hospital for Special Surgery" is a dramatically different trust signal than just "fellowship-trained." The institution name matters. -> Add the fellowship institution to the bio line or as a stat label.

2. **Conviction:** "3,000+ Procedures Performed" remains too vague for this persona's specific decision. Round 1 flagged this as P1 for the older adult. It has been addressed by adding testimonials (Linda R.'s story is strong), but the stat itself is unchanged. A dedicated joint replacement volume stat would meaningfully increase conversion for this segment. -> Add "500+ Joint Replacements" or similar procedure-specific stat.

3. **Copy:** The subheadline "From diagnosis through surgery to recovery -- one surgeon, one team, one plan" is excellent for this persona. But "Serving Austin, TX and surrounding communities" is a geographic qualifier that dilutes the emotional promise. These are two different ideas in one sentence. -> Consider splitting: make the care continuity promise its own line, and put the geographic note elsewhere (it is already in the footer and page title).

4. **Flow:** The "What to expect" line ("Bring your imaging results, a list of medications, and any questions") is a thoughtful addition that was specifically requested in round 1. It appears in the copy doc but is implemented in the HTML as a small text paragraph below the phone block (line 1447). This is easy to miss, especially for this persona who is scrolling slowly. -> Give this line slightly more visual weight -- perhaps a light background card or a small icon. It is genuinely useful information that should not disappear into the page.

5. **Visual:** No surgeon photo. For older patients, seeing the face of the person who will operate on them is a significant trust factor. The bio section has name, stats, and affiliation, but no visual human presence. The anatomical SVG illustrations are hidden on mobile (where many patients arrive). -> Add a CSS-based doctor silhouette placeholder, or at minimum add biographical detail about where Dr. Mitchell trained and any professional memberships.

#### P3 -- Would Reduce My Confidence

1. **Copy:** The footer lists Saturday hours as "8:00 AM - 12:00 PM (urgent walk-ins)." For this persona, it is important to know that regular consultations are Monday-Friday only. The Saturday caveat is clear but could be more explicit: "Saturday: Urgent injuries only, 8:00 AM - 12:00 PM." -> Minor phrasing adjustment to prevent a 68-year-old from showing up Saturday expecting a joint consultation.

2. **Visual:** The 14px body-small text on service card descriptions was flagged in round 1 as potentially challenging for older eyes. It remains 14px. The mobile breakpoint does not upsize it. -> Consider 16px for card descriptions on all viewports, or at minimum on mobile where reading distance varies.

3. **Flow:** No mention of telehealth. The PRODUCT.md lists telehealth as a delivery channel for follow-ups and triage. For an older patient with mobility limitations, knowing an initial video consultation is available could be the difference between booking and deciding it is too much hassle. -> Add a brief telehealth mention near the booking CTA.

### What Almost Worked

1. **The empathy line** ("Deciding to see a surgeon is a big step. Your first appointment is a conversation -- we answer every question before anything else happens.") is exactly what this persona needs to hear. It acknowledges the emotional weight of the decision without being patronizing. The left-border accent treatment gives it visual distinction. This is the single best piece of copy on the page for this audience.

2. **"No referral needed"** continues to be a strong anxiety reducer. Combined with the insurance line ("We accept most major insurance plans"), the booking section now addresses two of the three biggest practical questions for this persona (the third being "which hospital," which is answered in the bio).

---

## Evaluation 3: Acute Injury Patient (All Ages)

**Persona lens:** Acute Injury Patient
**Persona context:** 40-year-old who fell off a ladder an hour ago. Left wrist is swollen and possibly broken. Just left urgent care with instructions to "see an orthopaedic surgeon today or tomorrow." On their phone in the car. Needs to know: can I be seen right now, and where?

### Dimension Scores

| Dimension | Score | Severity | Summary |
|-----------|-------|----------|---------|
| Visual | 8/10 | P3 | The teal urgent banner at the top is the first thing I see. It is prominent, high-contrast, and includes a phone number. This is a massive improvement from round 1 where no urgency signal existed above the fold. |
| Copy / Messaging | 8/10 | P3 | "Injured today? Same-day walk-in appointments available." -- that is exactly what I need to see. The phone number is clickable. This is a near-perfect urgent patient experience above the fold. |
| Flow | 7/10 | P2 | I see the banner, I tap the phone number, I call. That is a 2-tap conversion path (if I count tapping "call" on the phone dialog). This works. The only gap: the banner is dismissible. If I accidentally close it, the next urgent signal is buried in the fracture care card description. |
| Conviction | 7/10 | P3 | I do not need deep conviction for a fracture. I need to know: are you open, can you see me, and are you actually an orthopaedic practice (not a chiropractor). The answer to all three is visible in the first screen. Good enough. |
| Persuasion | 7/10 | P3 | The banner creates enough urgency. The Saturday hours ("urgent walk-ins") in the footer confirm this is a real walk-in option. "Same Day Imaging Available" in the stats tells me I will not be sent somewhere else. This persona's needs are met. |

### Why I Would Walk Away

Honestly? I probably would not walk away from this version. I see the banner, I tap the phone number, I call. Done. My one concern: I dismissed the banner by accident (tapped the X while scrolling on my phone). Now the urgent message is gone. I scroll down and the first thing I see is the hero -- "Fellowship-Trained Orthopaedic Surgeon. Appointments This Week." This week is too slow. I keep scrolling to find the phone number again, but it takes me past three sections before I find it in section 4. In that 15-second scroll, I might have gone back to search results instead.

### Findings

#### P2 -- Would Make Me Hesitate

1. **Flow:** The urgent banner is dismissible with no way to get it back. On mobile, accidental dismissal is likely (the close button is in the upper right, and mobile scrolling can trigger stray taps). Once dismissed, the next mention of same-day/walk-in availability is in the fracture care card (section 2) and the footer Saturday hours. There is no persistent urgency signal in the sticky header. -> Either make the banner non-dismissible, or add a small "Walk-ins Welcome" badge to the sticky header that persists after the banner is dismissed.

2. **Flow:** The header phone number text is hidden on mobile (`display: none` on `.site-header__phone-text` at line 937-938). Only the phone icon remains. For an acute patient on mobile who dismissed the banner, the phone icon in the header is their last resort -- but it is small and easy to miss among the brand name and hamburger menu. -> Consider keeping the phone number visible in the header on mobile, or at least making the phone icon more prominent (larger, teal accent).

3. **Copy:** The urgent banner says "Same-day walk-in appointments available" but does not specify the address or hours. A patient in acute pain does not want to call to ask where to go. -> Consider adding "4200 Medical Parkway, Suite 310" to the banner, or at minimum "Austin" so they know proximity before calling.

#### P3 -- Would Reduce My Confidence

1. **Visual:** The fracture care card still has equal visual weight with the other three service cards. For a patient who scrolls past the banner, a subtle visual differentiation (an accent border, a small "Walk-In" badge) would help the fracture card stand out. -> Minor visual enhancement to the fracture card to aid self-sorting.

2. **Copy:** "Broken bones need the right treatment from the start" is the fracture card's opening line. This is a mild urgency statement but it does not drive action the way "Walk-in for same-day X-ray and treatment" would. The walk-in mention comes in the second sentence. -> Lead with the walk-in availability, follow with the clinical rationale.

### What Almost Worked

1. **The urgent banner** is the most impactful single addition in round 2. It directly addressed the round 1 P1 gap ("zero urgency signalling for acute patients"). The combination of `role="alert"`, teal background, dismissible close button, and inline phone link is well-executed. The only remaining gap is what happens after dismissal.

2. **Saturday hours in the footer** ("Saturday: 8:00 AM - 12:00 PM, urgent walk-ins") is exactly the information an acute patient needs. Combined with the banner, this practice now communicates that it handles urgent cases -- a major improvement from round 1 where this was completely absent.

---

## Cross-Evaluation Summary

### Remaining Critical Issue

| # | Issue | Severity | Impact |
|---|-------|----------|--------|
| 1 | Section 4 "Book an Appointment" CTA has `href="#contact"` and sits inside `id="contact"` -- clicking it does nothing. No booking form, no external scheduling link exists on the page. | P1 | The phone path works (calling is a real action). But the online booking path -- the primary CTA button that the entire page funnels toward -- terminates at a self-referencing anchor. Any patient who wants to book online (the majority of the 30-55 segment) cannot convert. |

### Structural Improvements Needed

| # | Issue | Severity | Impact |
|---|-------|----------|--------|
| 2 | "3,000+ Procedures" stat is generic across all three personas | P2 | Procedure-specific volume would materially increase conviction for sports medicine and joint replacement patients. |
| 3 | No fellowship institution named despite "fellowship-trained" appearing three times | P2 | Reduces the credential's impact, especially for older adults making surgical decisions. |
| 4 | No surgeon photo or visual human presence | P2 | All three personas want to see the person who may treat them. The SVG illustrations are decorative but impersonal. |
| 5 | Service card hover effect on non-interactive cards | P3 | Minor false affordance. |
| 6 | Urgent banner is easily dismissed on mobile with no persistent fallback | P2 | Acute injury patients may lose the urgency signal. |

### What Improved Significantly

The round 2 iteration addressed the creative direction feedback with discipline. The additions are:

- **Urgent banner:** Fully new. Directly addresses the acute injury persona gap.
- **Testimonials section:** Fully new. Three persona-matched testimonials with local attribution.
- **Header and footer:** Fully new. Brand anchor, persistent nav, address, hours, insurance, copyright.
- **Hospital affiliation:** Added to the bio. "St. David's Medical Center" is a real Austin hospital.
- **Insurance information:** Added in section 4 and footer, including named carriers.
- **Empathy line:** Added before the booking CTA with a tasteful left-border accent.
- **"What to expect" line:** Added after the phone block.
- **Location throughout:** Austin, TX in subheadline, page title, meta description, footer address.
- **"What We Treat":** Replaced the less precise "How We Help You Move Again."
- **"Sports & Joint Specialist":** Replaced "Sub-Specialty Expertise" jargon.
- **"Schedule Your Consultation":** Replaced the too-casual "Ready to Get Moving?"
- **Proper em dashes:** The HTML uses `—` characters correctly.
- **Mobile illustration handling:** Hidden entirely on mobile (`display: none`), not ghost-opacity.

### What Regressed

Nothing regressed. Every change from round 1 either resolved or improved the flagged issue. The creative direction adherence remains strong and the new additions integrate cleanly.

### Recommendation for Next Iteration

1. **Resolve the remaining P1:** Replace the section 4 CTA `href="#contact"` with a real booking mechanism. Options in order of preference:
   - Embed a simple appointment request form (name, phone, email, reason for visit, preferred date)
   - Link to an external scheduling service (Calendly, Zocdoc, Jane App)
   - At minimum, use `mailto:` with a pre-filled subject line as a last resort
2. Add procedure-specific stat (joint replacement volume or sports medicine volume) to the stat blocks
3. Name the fellowship institution in the bio
4. Make the urgent banner non-dismissible on mobile, or add a persistent "Walk-Ins" indicator to the sticky header
5. Consider adding a link to external reviews (Google, Healthgrades) to anchor the on-page testimonials

### Overall Assessment

Round 2 is a substantial improvement. The page went from a well-designed template with no content to a credible, well-structured medical practice homepage with real personality and local specificity. The testimonials, header/footer, urgent banner, and hospital affiliation each add meaningful trust. The phone conversion path is now fully functional. The single remaining P1 -- the online booking dead end -- is the only thing preventing this from being a shippable page. Fix the booking CTA and this page is ready for real patients.
