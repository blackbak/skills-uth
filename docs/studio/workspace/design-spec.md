# Design Specification: Orthopaedic Practice Homepage

**Date:** 2026-02-21
**Deliverable:** 3-section homepage (single self-contained HTML file)
**Design direction:** Steady Hands (see creative-direction.md)

---

## 1. Page Structure

### Overall Layout

Single-page, vertical scroll. Three full-width sections separated by a pulse-line divider element. All content constrained within a 1200px max-width centered container. 12-column grid with 24px gutters.

```
+=========================================================+
|  SECTION 1: HERO                                        |
|  bg: #FFFFFF                                            |
|  Credential-led headline, subheadline, CTA, trust badges|
|  Anatomical SVG illustrations (right side on desktop)   |
+---------------------------------------------------------+
|  ~~~ PULSE-LINE DIVIDER ~~~                             |
+---------------------------------------------------------+
|  SECTION 2: SERVICES                                    |
|  bg: #F7F9FC (secondary)                                |
|  Section heading + 4 service cards in grid              |
+---------------------------------------------------------+
|  ~~~ PULSE-LINE DIVIDER ~~~                             |
+---------------------------------------------------------+
|  SECTION 3: TRUST + BOOKING                             |
|  bg: #FFFFFF                                            |
|  Two-column: surgeon stats (left) + booking CTA (right) |
+=========================================================+
```

### Vertical Spacing

- Between sections: 0px (sections are flush; the pulse-line divider sits as a visual separator with 64px `xl` space above and below it within each section's padding)
- Section internal padding: 64px top and bottom (`xl` token)
- Content block gaps: 32px (`lg` token)

### Z-Index Layers

| Layer | Z-Index | Element |
|-------|---------|---------|
| Base | 0 | Section backgrounds |
| Content | 1 | Text, cards, images |
| Divider | 2 | Pulse-line SVG |

---

## 2. Section 1: Hero

### Layout (Desktop >= 768px)

```
+-------------------------------------------------------+
|  max-width: 1200px, centered, padding: 0 24px         |
|                                                        |
|  +---------------------------+  +--------------------+ |
|  |  LEFT COLUMN (7 cols)     |  | RIGHT COL (5 cols) | |
|  |                           |  |                    | |
|  |  [HEADLINE]               |  | Anatomical SVG     | |
|  |  H1, primary #1B4D7A     |  | illustration       | |
|  |  36px / 700 / 1.2         |  | (knee, shoulder,   | |
|  |                           |  |  hip outlines)     | |
|  |  [SUBHEADLINE]            |  |                    | |
|  |  Body, text-secondary     |  | stroke: #1B4D7A    | |
|  |  #6B7280, 16px/400/1.6   |  | stroke-width: 1.5  | |
|  |                           |  | fill: none         | |
|  |  +-----CTA BUTTON------+ |  |                    | |
|  |  | [CTA_TEXT]           | |  |                    | |
|  |  | bg: #2A9D8F          | |  |                    | |
|  |  | text: #FFFFFF        | |  |                    | |
|  |  | 14px 28px padding    | |  |                    | |
|  |  | radius: 8px          | |  |                    | |
|  |  +----------------------+ |  |                    | |
|  |                           |  |                    | |
|  |  TRUST BADGES (inline)    |  |                    | |
|  |  [badge] [badge] [badge]  |  |                    | |
|  +---------------------------+  +--------------------+ |
+-------------------------------------------------------+
```

### Layout (Mobile < 768px)

```
+----------------------------------+
|  padding: 32px 24px (lg / gutter)|
|                                  |
|  [HEADLINE]                      |
|  H1, 28px (scaled down)         |
|                                  |
|  [SUBHEADLINE]                   |
|  Body, 16px                      |
|                                  |
|  +---CTA BUTTON (full-width)--+ |
|  | [CTA_TEXT]                  | |
|  +-----------------------------+ |
|                                  |
|  TRUST BADGES (stacked or       |
|  horizontal scroll)              |
|  [badge]                         |
|  [badge]                         |
|  [badge]                         |
|                                  |
|  (Anatomical SVG hidden or       |
|   reduced to small centered      |
|   accent below badges,           |
|   max-width: 200px, opacity: 0.3)|
+----------------------------------+
```

### Component: Trust Badge

Inline block elements displayed in a horizontal row (desktop) or vertical stack (mobile).

```
Structure:
  <span class="trust-badge">
    <strong>[STAT_VALUE]</strong>
    <span>[STAT_LABEL]</span>
  </span>

Styling:
  display: inline-flex
  flex-direction: column
  align-items: center (mobile) / flex-start (desktop)
  gap: 2px

  STAT_VALUE:
    font: Inter 22px / 700 / 1.2
    color: #1B4D7A (primary)

  STAT_LABEL:
    font: Inter 12px / 400 / 1.4 (caption)
    color: #6B7280 (text-secondary)
    text-transform: uppercase
    letter-spacing: 0.05em

Badge row:
  display: flex
  gap: 32px (lg)
  margin-top: 32px (lg)
  padding-top: 24px
  border-top: 1px solid #E5E7EB (border)

Mobile override:
  gap: 24px
  flex-direction: row (keep horizontal, wrap if needed)
  flex-wrap: wrap
  justify-content: center
```

### Component: Anatomical SVG Illustration

A single SVG element containing thin-stroke outlines of three anatomical structures: a knee joint (center, largest), a shoulder joint (upper-left, medium), and a hip joint (lower-right, medium). These overlap slightly to create a cohesive composition rather than three isolated icons.

```
SVG specification:
  viewBox: 0 0 400 500
  width: 100%, max-width: 400px
  height: auto

  All paths:
    stroke: #1B4D7A (primary)
    stroke-width: 1.5
    stroke-linecap: round
    stroke-linejoin: round
    fill: none

  Knee joint (center-bottom area):
    - Femoral condyle curve (rounded U-shape opening downward)
    - Tibial plateau line beneath it
    - Slight gap between representing the joint space
    - Patella outline (small oval overlapping the front)
    - Minimal ligament suggestion lines (2 thin crossing lines in the joint gap)

  Shoulder joint (upper-left area):
    - Humeral head (large circle, ~60px diameter)
    - Glenoid fossa (shallow concave arc cupping the humeral head)
    - Acromion line (short angular line above the humeral head)
    - Clavicle suggestion (single line extending from acromion toward center-top)

  Hip joint (lower-right area):
    - Femoral head (circle, ~50px diameter)
    - Acetabulum (deeper concave arc, ~2/3 around the femoral head)
    - Femoral neck (two converging lines below the head)
    - Pelvis suggestion (broad curved line above the acetabulum)

  Composition notes:
    - Illustrations are positioned to form a loose triangular arrangement
    - Overlapping slightly via shared negative space, not overlapping strokes
    - Total composition feels like a medical reference plate, not clip art
    - Subtle opacity gradient: closest joint at opacity 1.0, farthest at 0.6
    - On desktop, positioned in the right column with vertical centering
```

---

## 3. Pulse-Line Divider

The signature motion element. A horizontal SVG line styled as a medical pulse/heartbeat trace (ECG-style). It is the only animated element on the page.

### Specification

```
Structure:
  <div class="pulse-divider">
    <svg> ... polyline path ... </svg>
  </div>

Container:
  width: 100%
  max-width: 1200px
  margin: 0 auto
  padding: 0 24px
  height: 48px
  display: flex
  align-items: center
  overflow: hidden
  position: relative

SVG:
  viewBox: 0 0 1200 48
  width: 100%
  height: 48px
  preserveAspectRatio: none

Path shape (polyline):
  The line runs horizontally across the full width.
  It is flat for most of its length, with a single
  sharp pulse spike in the center:

  M 0,24
  L 480,24        (flat line from left)
  L 540,24        (approach the spike)
  L 560,8         (sharp rise)
  L 580,40        (sharp dip below center)
  L 600,16        (secondary rise)
  L 620,28        (settle)
  L 660,24        (return to flat)
  L 1200,24       (flat line to right)

  stroke: #2A9D8F (accent)
  stroke-width: 2
  stroke-linecap: round
  stroke-linejoin: round
  fill: none

Animation:
  stroke-dasharray: [total path length]
  stroke-dashoffset: [total path length] -> 0
  animation: pulse-draw 2s ease-in-out forwards
  animation triggered on scroll into view (IntersectionObserver)
  Plays once per page load, does not loop

  @keyframes pulse-draw {
    from { stroke-dashoffset: [total-path-length]; }
    to   { stroke-dashoffset: 0; }
  }

Mobile override (< 768px):
  height: 32px
  viewBox: 0 0 400 32
  Pulse spike compressed to center third
  Spike amplitude reduced (proportional to viewBox)
  Path:
    M 0,16 L 150,16 L 175,5 L 190,27 L 200,10 L 210,19 L 225,16 L 400,16
  Container padding: 0 24px
  margin: 32px auto (lg, reduced from xl)
```

---

## 4. Section 2: Services

### Layout (Desktop >= 768px)

```
+-------------------------------------------------------+
|  bg: #F7F9FC (secondary)                               |
|  padding: 64px 24px (xl / gutter)                      |
|  max-width: 1200px, centered                           |
|                                                        |
|  [SECTION_HEADING]                                     |
|  H2, #1B4D7A, 28px/600/1.3, text-align: center        |
|  margin-bottom: 16px (md)                              |
|                                                        |
|  [SECTION_SUBHEADING]                                  |
|  Body, #6B7280, 16px/400/1.6, text-align: center      |
|  max-width: 600px, margin: 0 auto 48px auto            |
|                                                        |
|  +--------+ +--------+ +--------+ +--------+          |
|  | CARD 1 | | CARD 2 | | CARD 3 | | CARD 4 |          |
|  | Sports | | Joint  | | Frac-  | | General|          |
|  | Injury | | Replace| | ture   | | Ortho  |          |
|  +--------+ +--------+ +--------+ +--------+          |
|                                                        |
|  Grid: 4 columns, gap: 24px (gutter)                  |
+-------------------------------------------------------+
```

### Layout (Mobile < 768px)

```
+----------------------------------+
|  bg: #F7F9FC                     |
|  padding: 48px 24px              |
|                                  |
|  [SECTION_HEADING] centered      |
|  [SECTION_SUBHEADING] centered   |
|                                  |
|  +---CARD 1 (full width)------+ |
|  | Sports Injury              | |
|  +-----------------------------+ |
|  gap: 16px (md)                  |
|  +---CARD 2 (full width)------+ |
|  | Joint Replacement          | |
|  +-----------------------------+ |
|  gap: 16px                       |
|  +---CARD 3 (full width)------+ |
|  | Fracture Care              | |
|  +-----------------------------+ |
|  gap: 16px                       |
|  +---CARD 4 (full width)------+ |
|  | General Orthopaedics       | |
|  +-----------------------------+ |
+----------------------------------+
```

### Tablet Breakpoint (640px - 767px)

Cards display in a 2x2 grid with 24px gap.

### Component: Service Card

```
Structure:
  <div class="service-card">
    <div class="service-card__icon">
      <svg>...</svg>
    </div>
    <h3 class="service-card__title">[CARD_TITLE]</h3>
    <p class="service-card__description">[CARD_DESCRIPTION]</p>
  </div>

Styling:
  background: #FFFFFF (white)
  border: 1px solid #E5E7EB (border)
  border-radius: 12px
  padding: 24px
  box-shadow: 0 1px 3px rgba(0,0,0,0.08)
  transition: box-shadow 0.2s ease, transform 0.2s ease
  text-align: center

  Icon container:
    width: 64px
    height: 64px
    margin: 0 auto 16px auto
    display: flex
    align-items: center
    justify-content: center

  SVG icon:
    width: 48px
    height: 48px
    stroke: #1B4D7A (primary)
    stroke-width: 1.5
    stroke-linecap: round
    stroke-linejoin: round
    fill: none

  Title:
    font: Inter 22px / 600 / 1.3 (H3)
    color: #1A1A2E (text-primary)
    margin-bottom: 8px (sm)

  Description:
    font: Inter 14px / 400 / 1.5 (body-small)
    color: #6B7280 (text-secondary)

Hover state (desktop only):
  box-shadow: 0 4px 12px rgba(0,0,0,0.12)
  transform: translateY(-2px)

Focus state (keyboard):
  outline: 2px solid #2A9D8F (accent)
  outline-offset: 2px

Cards do NOT have individual links or CTAs.
The unified CTA in section 3 handles booking.

Mobile:
  Cards stack full-width
  text-align: left
  Icon floats left, text beside it (optional layout):

  Alternative mobile layout:
    display: flex
    gap: 16px
    align-items: flex-start
    Icon: flex-shrink: 0, width: 48px, height: 48px
    Text: flex: 1

  This reduces vertical space and improves scannability.
```

### SVG Icon Descriptions

Each service card has a distinct SVG icon with different shapes and line weights to enable visual self-sorting (per creative direction).

#### Sports Injury Icon

```
viewBox: 0 0 48 48
Concept: A running figure silhouette with a highlighted knee area

Elements:
  - Simplified human figure in motion (running pose):
    - Head: circle, cx=24, cy=8, r=4
    - Torso: line from (24,12) to (22,24)
    - Leading leg: line from (22,24) to (16,36) with bend at knee (19,30)
    - Trailing leg: line from (22,24) to (30,34) with bend at knee (26,29)
    - Arms: lines suggesting forward motion
  - Knee highlight: small circle at (19,30), r=4,
    stroke: #2A9D8F (accent), stroke-width: 2
    This is the only accent-colored element, drawing the eye
  - All other strokes: #1B4D7A, stroke-width: 1.5

Distinguishing character:
  Dynamic, diagonal lines suggesting movement
  Accent circle marks the injury point
  Line weight: 1.5px body, 2px accent highlight
```

#### Joint Replacement Icon

```
viewBox: 0 0 48 48
Concept: A knee joint cross-section showing an implant

Elements:
  - Femur end (top): rounded convex shape, like an inverted U
    Two parallel lines descending into the shape (bone shaft)
  - Tibia top (bottom): flat plateau with two parallel lines
    descending away (bone shaft)
  - Joint space between them
  - Implant overlay: geometric shapes replacing the bone surfaces
    - Femoral component: smooth curved cap over the femur end,
      drawn with slightly thicker stroke (2px)
    - Tibial component: flat plate with short stem,
      drawn with slightly thicker stroke (2px)
  - Implant strokes: #1B4D7A, stroke-width: 2 (heavier than bone)
  - Bone strokes: #1B4D7A, stroke-width: 1
  - Small cross-hatch marks on the implant surfaces to suggest metal

Distinguishing character:
  Geometric precision, heavier line weight for the implant
  The engineered shapes contrast with organic bone curves
  Overall feel: technical, precise
```

#### Fracture Care Icon

```
viewBox: 0 0 48 48
Concept: A bone with a fracture line and stabilizing hardware

Elements:
  - Long bone (forearm/radius style):
    Two roughly parallel curves running diagonally from
    upper-left to lower-right, wider at each end (epiphyses)
  - Fracture line: a jagged zigzag line across the bone
    at the midpoint, stroke-width: 1.5
    Small gap in the bone outline at the fracture
  - Fixation hardware: two small parallel lines crossing
    perpendicular to the bone on each side of the fracture
    (representing screws/pins), stroke-width: 2
  - A thin plate line connecting the screws along the bone surface
  - All strokes: #1B4D7A
  - Fracture zigzag: stroke-dasharray: 3 2 (subtle dashed feel)

Distinguishing character:
  Angular, jagged fracture line creates visual tension
  Hardware elements add geometric precision over organic bone
  Most "urgent" feeling icon of the four
```

#### General Orthopaedics Icon

```
viewBox: 0 0 48 48
Concept: A simplified skeletal hand/wrist showing
  the breadth of orthopaedic care

Elements:
  - Open hand outline (palm facing viewer, simplified):
    - Palm: rounded rectangle or organic palm shape
    - Five fingers: simple lines with one bend each
      (proximal and distal segments)
    - Wrist: two parallel lines descending from palm
  - Small arc at the wrist suggesting the carpal bones
  - A subtle circular highlight behind the whole hand
    (dashed circle, stroke-dasharray: 4 4, stroke: #E5E7EB)
    suggesting wholeness/comprehensive care
  - Hand strokes: #1B4D7A, stroke-width: 1.5

Distinguishing character:
  Softer, more organic lines than the other three icons
  Rounded shapes, no sharp angles or mechanical elements
  The hand is a universal symbol of care and dexterity
  Broadest/most general feeling icon
```

---

## 5. Section 3: Trust + Booking

### Layout (Desktop >= 768px)

```
+-------------------------------------------------------+
|  bg: #FFFFFF                                           |
|  padding: 64px 24px (xl / gutter)                      |
|  max-width: 1200px, centered                           |
|                                                        |
|  +--LEFT COLUMN (6 cols)---+ +--RIGHT COLUMN (6 cols)-+|
|  |                         | |                         ||
|  |  [SURGEON_NAME]         | |  [BOOKING_HEADING]      ||
|  |  H2, #1B4D7A            | |  H3, #1A1A2E            ||
|  |  28px / 600 / 1.3       | |  22px / 600 / 1.3       ||
|  |                         | |                         ||
|  |  [ONE_LINE_BIO]         | |  [BOOKING_SUBTEXT]      ||
|  |  Body, #6B7280          | |  Body, #6B7280          ||
|  |  16px / 400 / 1.6       | |  16px / 400 / 1.6       ||
|  |  margin-bottom: 32px    | |  margin-bottom: 24px    ||
|  |                         | |                         ||
|  |  STAT BLOCKS:           | |  +--CTA BUTTON--------+||
|  |  +------+ +------+     | |  | [CTA_TEXT]          |||
|  |  | STAT | | STAT |     | |  | bg: #2A9D8F         |||
|  |  |  1   | |  2   |     | |  | text: #FFFFFF        |||
|  |  +------+ +------+     | |  | padding: 14px 28px   |||
|  |  +------+              | |  | radius: 8px          |||
|  |  | STAT |              | |  | width: 100%          |||
|  |  |  3   |              | |  +----------------------+||
|  |  +------+              | |                         ||
|  |                         | |  [PHONE_DIVIDER]        ||
|  |                         | |  ------- or -------     ||
|  |                         | |                         ||
|  |                         | |  +--PHONE BLOCK-------+||
|  |                         | |  | phone icon + number |||
|  |                         | |  | [PHONE_NUMBER]      |||
|  |                         | |  +---------------------+||
|  +-------------------------+ +-------------------------+|
+-------------------------------------------------------+
```

### Layout (Mobile < 768px)

```
+----------------------------------+
|  bg: #FFFFFF                     |
|  padding: 48px 24px              |
|                                  |
|  [SURGEON_NAME]                  |
|  H2, centered                    |
|                                  |
|  [ONE_LINE_BIO]                  |
|  Body, centered                  |
|                                  |
|  STAT BLOCKS (horizontal scroll  |
|  or 3-column compact grid):      |
|  +------+ +------+ +------+     |
|  | STAT | | STAT | | STAT |     |
|  |  1   | |  2   | |  3   |     |
|  +------+ +------+ +------+     |
|  margin-bottom: 32px             |
|                                  |
|  --- visual separator ---        |
|                                  |
|  [BOOKING_HEADING]               |
|  H3, centered                    |
|                                  |
|  [BOOKING_SUBTEXT]               |
|  Body, centered                  |
|                                  |
|  +---CTA BUTTON (full-width)--+ |
|  | [CTA_TEXT]                  | |
|  +-----------------------------+ |
|  margin-bottom: 16px             |
|                                  |
|  [OR_DIVIDER]                    |
|                                  |
|  +---PHONE BLOCK (full-width)-+ |
|  | phone icon + [PHONE_NUMBER]| |
|  +-----------------------------+ |
+----------------------------------+
```

### Component: Stat Block

```
Structure:
  <div class="stat-block">
    <span class="stat-block__value">[STAT_VALUE]</span>
    <span class="stat-block__label">[STAT_LABEL]</span>
  </div>

Styling:
  display: flex
  flex-direction: column
  align-items: flex-start (desktop) / center (mobile)
  gap: 4px (xs)

  Value:
    font: Inter 36px / 700 / 1.2 (same scale as H1)
    color: #1B4D7A (primary)

  Label:
    font: Inter 14px / 400 / 1.5 (body-small)
    color: #6B7280 (text-secondary)

Stat grid:
  Desktop: display: flex, flex-wrap: wrap, gap: 24px
  Mobile: display: grid, grid-template-columns: repeat(3, 1fr), gap: 16px, text-align: center
```

### Component: Phone Block

```
Structure:
  <div class="phone-block">
    <svg class="phone-icon">...</svg>
    <a href="tel:[PHONE_NUMBER]" class="phone-link">[PHONE_NUMBER]</a>
  </div>

Phone icon SVG:
  viewBox: 0 0 24 24
  width: 24px, height: 24px
  stroke: #1B4D7A, stroke-width: 1.5, fill: none
  Path: standard telephone handset outline
    (receiver shape: curved rectangle tilted 30 degrees)

Styling:
  display: flex
  align-items: center
  justify-content: center
  gap: 12px

  Link:
    font: Inter 22px / 600 / 1.3 (H3 scale)
    color: #1B4D7A (primary)
    text-decoration: none

  Hover:
    color: #0F3355 (primary-dark)
    text-decoration: underline

  Touch target: entire block is tappable on mobile
    min-height: 48px
    padding: 12px 24px
    border: 1px solid #E5E7EB
    border-radius: 8px
    cursor: pointer
```

### Component: "Or" Divider

```
Structure:
  <div class="or-divider">
    <span class="or-divider__line"></span>
    <span class="or-divider__text">[OR_TEXT]</span>
    <span class="or-divider__line"></span>
  </div>

Styling:
  display: flex
  align-items: center
  gap: 16px (md)
  margin: 16px 0 (md)

  Line:
    flex: 1
    height: 1px
    background: #E5E7EB (border)

  Text:
    font: Inter 12px / 400 / 1.4 (caption)
    color: #6B7280 (text-secondary)
    text-transform: uppercase
    letter-spacing: 0.1em
    white-space: nowrap
```

---

## 6. Color Application Map

| Element | Token | Hex | WCAG Notes |
|---------|-------|-----|------------|
| Hero background | white | #FFFFFF | -- |
| Hero headline | primary | #1B4D7A | 7.2:1 on white (AAA) |
| Hero subheadline | text-secondary | #6B7280 | 4.6:1 on white (AA) |
| Body text | text-primary | #1A1A2E | 14.5:1 on white (AAA) |
| CTA button background | accent | #2A9D8F | -- |
| CTA button text | white | #FFFFFF | 4.5:1 on #2A9D8F (AA) |
| CTA button hover | accent darkened | #228578 | 5.3:1 on white text (AA) |
| Services section bg | secondary | #F7F9FC | -- |
| Service card bg | white | #FFFFFF | -- |
| Service card title | text-primary | #1A1A2E | 14.5:1 on white (AAA) |
| Service card description | text-secondary | #6B7280 | 4.6:1 on white (AA) |
| Card border | border | #E5E7EB | decorative, no contrast requirement |
| Pulse-line stroke | accent | #2A9D8F | decorative, no contrast requirement |
| SVG illustration stroke | primary | #1B4D7A | decorative, no contrast requirement |
| Stat block value | primary | #1B4D7A | 7.2:1 on white (AAA) |
| Stat block label | text-secondary | #6B7280 | 4.6:1 on white (AA) |
| Phone link | primary | #1B4D7A | 7.2:1 on white (AAA) |
| Section heading (on #F7F9FC) | primary | #1B4D7A | 6.9:1 on #F7F9FC (AAA) |
| Body text (on #F7F9FC) | text-secondary | #6B7280 | 4.4:1 on #F7F9FC (AA borderline -- verify) |

**Note on #6B7280 on #F7F9FC:** Calculated contrast is approximately 4.4:1. This is slightly below the 4.5:1 AA threshold for normal text. Two options:
1. Use 16px+ text at this pairing (large text AA threshold is 3:1 -- passes).
2. Darken text-secondary to #5F6672 (~4.8:1) when used on #F7F9FC. Recommended approach: the service card descriptions sit on white card backgrounds (#FFFFFF), not directly on #F7F9FC, so the 4.6:1 ratio holds. The only text directly on #F7F9FC is the section subheading, which should use text-primary (#1A1A2E) or primary (#1B4D7A) instead.

---

## 7. Typography Application

All typography uses Inter, loaded via Google Fonts.

```html
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
```

| Element | Size | Weight | Line Height | Color Token | Notes |
|---------|------|--------|-------------|-------------|-------|
| Hero headline (H1) | 36px | 700 | 1.2 | primary | Desktop. Mobile: 28px |
| Section heading (H2) | 28px | 600 | 1.3 | primary | Desktop. Mobile: 24px |
| Card title (H3) | 22px | 600 | 1.3 | text-primary | Desktop. Mobile: 20px |
| Body text | 16px | 400 | 1.6 | text-primary | No change mobile |
| Body small | 14px | 400 | 1.5 | text-secondary | Card descriptions |
| Caption | 12px | 400 | 1.4 | text-secondary | Badge labels, "or" divider |
| Stat value | 36px | 700 | 1.2 | primary | Desktop. Mobile: 28px |
| CTA button | 16px | 600 | 1.0 | white | Explicit line-height for button |
| Phone number | 22px | 600 | 1.3 | primary | Matches H3 scale |

### Mobile Typography Scale

On viewports below 768px, reduce heading sizes proportionally:

```css
@media (max-width: 767px) {
  h1 { font-size: 28px; }
  h2 { font-size: 24px; }
  h3 { font-size: 20px; }
  .stat-block__value { font-size: 28px; }
}
```

---

## 8. Responsive Behavior

### Breakpoints

| Name | Width | Layout Change |
|------|-------|---------------|
| Mobile | < 640px | Single column, stacked cards, full-width CTAs |
| Tablet | 640px - 767px | 2-column card grid, hero still stacked |
| Desktop | >= 768px | Full layout: hero two-column, 4-column cards, trust two-column |

### Section-by-Section Responsive Rules

**Hero (Section 1):**
- Desktop (>= 768px): Two-column (7/5 split). Left: text content. Right: anatomical SVG.
- Mobile (< 768px): Single column. SVG either hidden or rendered as a small centered decorative accent (200px max-width, opacity 0.25) below the trust badges. CTA button becomes full-width.

**Services (Section 2):**
- Desktop (>= 768px): 4-column card grid.
- Tablet (640px - 767px): 2x2 card grid.
- Mobile (< 640px): Single-column stacked cards. Cards switch from center-aligned to left-aligned horizontal layout (icon left, text right).

**Trust + Booking (Section 3):**
- Desktop (>= 768px): Two-column (6/6 split). Left: surgeon info + stats. Right: booking CTA + phone.
- Mobile (< 768px): Single column. Surgeon info stacks above booking block. Stats display as a compact 3-column grid.

**Pulse-Line Divider:**
- Desktop: Full-width within 1200px container. Height: 48px.
- Mobile: Full-width within container. Height: 32px. Spike amplitude proportionally reduced. Becomes a shorter centered accent (max-width: 200px centered, or full-width with reduced spike).

### Container Behavior

```css
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 24px;
  width: 100%;
}

@media (max-width: 767px) {
  .container {
    padding: 0 16px;  /* tighter on mobile */
  }
}
```

---

## 9. Interaction States

### CTA Button (Primary -- Accent)

| State | Background | Text | Shadow | Transform | Border |
|-------|-----------|------|--------|-----------|--------|
| Default | #2A9D8F | #FFFFFF | none | none | none |
| Hover | #228578 | #FFFFFF | 0 2px 8px rgba(42,157,143,0.3) | translateY(-1px) | none |
| Active/Pressed | #1E7A6D | #FFFFFF | none | translateY(0) | none |
| Focus (keyboard) | #2A9D8F | #FFFFFF | none | none | 2px solid #1B4D7A, offset 2px |
| Disabled | #E5E7EB | #9CA3AF | none | none | none, cursor: not-allowed |

```css
.cta-button {
  background: #2A9D8F;
  color: #FFFFFF;
  font-family: 'Inter', sans-serif;
  font-size: 16px;
  font-weight: 600;
  line-height: 1;
  padding: 14px 28px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background 0.2s ease, box-shadow 0.2s ease, transform 0.2s ease;
}

.cta-button:hover {
  background: #228578;
  box-shadow: 0 2px 8px rgba(42, 157, 143, 0.3);
  transform: translateY(-1px);
}

.cta-button:active {
  background: #1E7A6D;
  box-shadow: none;
  transform: translateY(0);
}

.cta-button:focus-visible {
  outline: 2px solid #1B4D7A;
  outline-offset: 2px;
}
```

### Service Cards

| State | Shadow | Transform | Border |
|-------|--------|-----------|--------|
| Default | 0 1px 3px rgba(0,0,0,0.08) | none | 1px solid #E5E7EB |
| Hover (desktop) | 0 4px 12px rgba(0,0,0,0.12) | translateY(-2px) | 1px solid #E5E7EB |
| Focus (keyboard) | 0 1px 3px rgba(0,0,0,0.08) | none | none, outline: 2px solid #2A9D8F offset 2px |

Cards are non-interactive (no links), so hover is purely aesthetic feedback. Cards should still have a subtle `tabindex="0"` for screen reader discoverability if desired, but no click action.

### Phone Link

| State | Color | Decoration |
|-------|-------|------------|
| Default | #1B4D7A | none |
| Hover | #0F3355 | underline |
| Active | #0F3355 | underline |
| Focus | #1B4D7A | outline: 2px solid #2A9D8F offset 2px |
| Visited | #1B4D7A | none (no visited color change for phone numbers) |

### Pulse-Line Divider

| State | Behavior |
|-------|----------|
| Before scroll | SVG path fully hidden (stroke-dashoffset = path length) |
| On scroll into view | Animate stroke-dashoffset to 0 over 2s ease-in-out |
| After animation | Static, fully visible |
| prefers-reduced-motion | Skip animation, show path immediately (stroke-dashoffset: 0) |

---

## 10. Accessibility Specification

### Semantic Structure

```html
<body>
  <main>
    <section aria-labelledby="hero-heading">
      <h1 id="hero-heading">[HEADLINE]</h1>
      ...
    </section>

    <div class="pulse-divider" role="separator" aria-hidden="true">
      <svg>...</svg>
    </div>

    <section aria-labelledby="services-heading">
      <h2 id="services-heading">[SECTION_HEADING]</h2>
      ...
    </section>

    <div class="pulse-divider" role="separator" aria-hidden="true">
      <svg>...</svg>
    </div>

    <section aria-labelledby="booking-heading">
      <h2 id="booking-heading">[SURGEON_NAME]</h2>
      ...
    </section>
  </main>
</body>
```

### Requirements

| Requirement | Implementation |
|-------------|----------------|
| Heading hierarchy | h1 (hero) > h2 (services, trust) > h3 (card titles, booking heading) |
| Landmark regions | `<main>`, `<section>` with aria-labelledby |
| SVG decorations | `aria-hidden="true"` on all decorative SVGs |
| SVG meaningful content | anatomical illustration: `role="img"` with `aria-label` describing the illustration |
| CTA button | `<a>` styled as button or `<button>`, clear accessible name from text content |
| Phone link | `<a href="tel:...">` with visible phone number text |
| Color contrast | All text pairings meet WCAG AA (4.5:1 normal, 3:1 large text) -- see section 6 |
| Touch targets | All interactive elements minimum 44x44px |
| Focus indicators | Visible focus ring (2px solid, offset 2px) on all interactive elements |
| Reduced motion | `@media (prefers-reduced-motion: reduce)` disables pulse-line animation |
| Font sizing | Minimum 16px body text for mobile readability |
| Skip link | Optional: skip-to-content link for keyboard users (hidden until focused) |

### Reduced Motion

```css
@media (prefers-reduced-motion: reduce) {
  .pulse-divider svg path {
    animation: none;
    stroke-dashoffset: 0;
  }

  .service-card,
  .cta-button {
    transition: none;
  }
}
```

---

## 11. Inline CSS Architecture

Since this is a single self-contained HTML file, all styles are inline in a `<style>` tag within `<head>`.

### CSS Custom Properties (Design Tokens)

```css
:root {
  /* Colors */
  --color-primary: #1B4D7A;
  --color-primary-dark: #0F3355;
  --color-secondary: #F7F9FC;
  --color-accent: #2A9D8F;
  --color-accent-hover: #228578;
  --color-accent-active: #1E7A6D;
  --color-text-primary: #1A1A2E;
  --color-text-secondary: #6B7280;
  --color-border: #E5E7EB;
  --color-error: #DC2626;
  --color-white: #FFFFFF;

  /* Typography */
  --font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --font-size-h1: 36px;
  --font-size-h2: 28px;
  --font-size-h3: 22px;
  --font-size-body: 16px;
  --font-size-body-small: 14px;
  --font-size-caption: 12px;

  /* Spacing */
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 32px;
  --space-xl: 64px;

  /* Layout */
  --max-width: 1200px;
  --gutter: 24px;
  --border-radius-sm: 8px;
  --border-radius-md: 12px;

  /* Shadows */
  --shadow-card: 0 1px 3px rgba(0, 0, 0, 0.08);
  --shadow-card-hover: 0 4px 12px rgba(0, 0, 0, 0.12);
  --shadow-cta-hover: 0 2px 8px rgba(42, 157, 143, 0.3);

  /* Motion */
  --transition-fast: 0.2s ease;
  --animation-pulse: 2s ease-in-out forwards;
}
```

### CSS Reset (Minimal)

```css
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; }
body { font-family: var(--font-family); font-size: var(--font-size-body); line-height: 1.6; color: var(--color-text-primary); }
img, svg { display: block; max-width: 100%; }
a { color: inherit; }
```

### Section Ordering in CSS

1. Custom properties
2. Reset
3. Layout utilities (container, grid)
4. Section backgrounds and spacing
5. Hero styles
6. Pulse-line divider
7. Service cards
8. Trust + booking section
9. Component-level styles (buttons, stat blocks, badges, phone block)
10. Responsive overrides (single `@media` block per breakpoint)
11. Reduced motion overrides
12. Animation keyframes

---

## 12. JavaScript Specification

Minimal JavaScript, only for the pulse-line scroll-trigger animation.

```javascript
document.addEventListener('DOMContentLoaded', () => {
  const dividers = document.querySelectorAll('.pulse-divider svg path');

  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    dividers.forEach(path => {
      path.style.strokeDashoffset = '0';
    });
    return;
  }

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const path = entry.target.querySelector('path');
        if (path) {
          path.style.animation =
            `pulse-draw var(--animation-pulse)`;
        }
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.5 });

  document.querySelectorAll('.pulse-divider').forEach(el => {
    observer.observe(el);
  });
});
```

The path's `stroke-dasharray` and initial `stroke-dashoffset` are set via CSS. The JS triggers the animation class/style when the element scrolls into view. The observer disconnects after triggering (plays once).

---

## 13. Complete HTML Structure Outline

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[PAGE_TITLE]</title>
  <meta name="description" content="[META_DESCRIPTION]">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    /* All CSS here -- see section 11 */
  </style>
</head>
<body>
  <main>
    <!-- SECTION 1: HERO -->
    <section class="hero" aria-labelledby="hero-heading">
      <div class="container hero__grid">
        <div class="hero__content">
          <h1 id="hero-heading">[HEADLINE]</h1>
          <p class="hero__subheadline">[SUBHEADLINE]</p>
          <a href="#booking" class="cta-button">[CTA_TEXT]</a>
          <div class="trust-badges">
            <span class="trust-badge">
              <strong>[STAT_VALUE_1]</strong>
              <span>[STAT_LABEL_1]</span>
            </span>
            <span class="trust-badge">
              <strong>[STAT_VALUE_2]</strong>
              <span>[STAT_LABEL_2]</span>
            </span>
            <span class="trust-badge">
              <strong>[STAT_VALUE_3]</strong>
              <span>[STAT_LABEL_3]</span>
            </span>
          </div>
        </div>
        <div class="hero__illustration" aria-hidden="true">
          <svg viewBox="0 0 400 500">
            <!-- Anatomical SVG paths -->
          </svg>
        </div>
      </div>
    </section>

    <!-- PULSE-LINE DIVIDER -->
    <div class="pulse-divider" role="separator" aria-hidden="true">
      <svg viewBox="0 0 1200 48" preserveAspectRatio="none">
        <path d="M0,24 L480,24 L540,24 L560,8 L580,40 L600,16 L620,28 L660,24 L1200,24" />
      </svg>
    </div>

    <!-- SECTION 2: SERVICES -->
    <section class="services" aria-labelledby="services-heading">
      <div class="container">
        <h2 id="services-heading">[SECTION_HEADING]</h2>
        <p class="services__subheading">[SECTION_SUBHEADING]</p>
        <div class="services__grid">
          <div class="service-card">
            <div class="service-card__icon">
              <svg viewBox="0 0 48 48"><!-- Sports Injury icon --></svg>
            </div>
            <h3 class="service-card__title">[CARD_TITLE_1]</h3>
            <p class="service-card__description">[CARD_DESCRIPTION_1]</p>
          </div>
          <div class="service-card">
            <div class="service-card__icon">
              <svg viewBox="0 0 48 48"><!-- Joint Replacement icon --></svg>
            </div>
            <h3 class="service-card__title">[CARD_TITLE_2]</h3>
            <p class="service-card__description">[CARD_DESCRIPTION_2]</p>
          </div>
          <div class="service-card">
            <div class="service-card__icon">
              <svg viewBox="0 0 48 48"><!-- Fracture Care icon --></svg>
            </div>
            <h3 class="service-card__title">[CARD_TITLE_3]</h3>
            <p class="service-card__description">[CARD_DESCRIPTION_3]</p>
          </div>
          <div class="service-card">
            <div class="service-card__icon">
              <svg viewBox="0 0 48 48"><!-- General Orthopaedics icon --></svg>
            </div>
            <h3 class="service-card__title">[CARD_TITLE_4]</h3>
            <p class="service-card__description">[CARD_DESCRIPTION_4]</p>
          </div>
        </div>
      </div>
    </section>

    <!-- PULSE-LINE DIVIDER -->
    <div class="pulse-divider" role="separator" aria-hidden="true">
      <svg viewBox="0 0 1200 48" preserveAspectRatio="none">
        <path d="M0,24 L480,24 L540,24 L560,8 L580,40 L600,16 L620,28 L660,24 L1200,24" />
      </svg>
    </div>

    <!-- SECTION 3: TRUST + BOOKING -->
    <section class="trust" aria-labelledby="trust-heading" id="booking">
      <div class="container trust__grid">
        <div class="trust__surgeon">
          <h2 id="trust-heading">[SURGEON_NAME]</h2>
          <p class="trust__bio">[ONE_LINE_BIO]</p>
          <div class="stat-blocks">
            <div class="stat-block">
              <span class="stat-block__value">[STAT_VALUE_1]</span>
              <span class="stat-block__label">[STAT_LABEL_1]</span>
            </div>
            <div class="stat-block">
              <span class="stat-block__value">[STAT_VALUE_2]</span>
              <span class="stat-block__label">[STAT_LABEL_2]</span>
            </div>
            <div class="stat-block">
              <span class="stat-block__value">[STAT_VALUE_3]</span>
              <span class="stat-block__label">[STAT_LABEL_3]</span>
            </div>
          </div>
        </div>
        <div class="trust__booking">
          <h3>[BOOKING_HEADING]</h3>
          <p>[BOOKING_SUBTEXT]</p>
          <a href="[BOOKING_URL]" class="cta-button cta-button--full">[CTA_TEXT]</a>
          <div class="or-divider">
            <span class="or-divider__line"></span>
            <span class="or-divider__text">[OR_TEXT]</span>
            <span class="or-divider__line"></span>
          </div>
          <div class="phone-block">
            <svg viewBox="0 0 24 24" width="24" height="24">
              <!-- Phone icon paths -->
            </svg>
            <a href="tel:[PHONE_NUMBER]" class="phone-link">[PHONE_NUMBER]</a>
          </div>
        </div>
      </div>
    </section>
  </main>

  <script>
    /* Pulse-line scroll animation -- see section 12 */
  </script>
</body>
</html>
```

---

## 14. Implementation Checklist

Before the implementation is considered complete, verify:

- [ ] All color pairings pass WCAG AA contrast (4.5:1 normal text, 3:1 large text)
- [ ] All interactive elements have minimum 44x44px touch targets
- [ ] All hover effects have keyboard focus equivalents
- [ ] `prefers-reduced-motion` is respected
- [ ] Semantic HTML structure with proper heading hierarchy (h1 > h2 > h3)
- [ ] SVG decorations are `aria-hidden="true"`
- [ ] Phone number is a tappable `tel:` link
- [ ] CTA button is a link (`<a>`) for bookmark/sharing, not a `<button>` (no JS form submission)
- [ ] Page is readable and functional with JavaScript disabled (pulse-line shows statically)
- [ ] No horizontal scroll at any viewport width
- [ ] Inter font loads with `font-display: swap` (text visible during load)
- [ ] No stock photo URLs anywhere
- [ ] Single HTML file with no external dependencies beyond Google Fonts
- [ ] Pulse-line animation triggers on scroll, plays once, and stops
- [ ] Mobile card layout switches to horizontal (icon-left, text-right) below 640px
- [ ] Stat blocks remain scannable on mobile (compact 3-column grid)
- [ ] The "or" divider between CTA and phone number is visually balanced
