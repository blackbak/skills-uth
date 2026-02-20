# Design System

## Overview

Design system for the orthopaedic surgery practice's digital presence — website, patient portal, and marketing materials.

## Layout

### Grid
- 12-column grid, max container width: 1200px
- Gutter: 24px
- Mobile breakpoint: 768px (stack to single column)

### Spacing Scale
| Token  | Value | Usage                    |
|--------|-------|--------------------------|
| xs     | 4px   | Tight element spacing    |
| sm     | 8px   | Related element gaps     |
| md     | 16px  | Section padding          |
| lg     | 32px  | Between content blocks   |
| xl     | 64px  | Page section separation  |

## Colour Tokens

| Token             | Hex       | Usage                          |
|-------------------|-----------|--------------------------------|
| primary           | #1B4D7A   | Headers, buttons, links        |
| primary-dark      | #0F3355   | Hover states, footer           |
| secondary         | #F7F9FC   | Page backgrounds               |
| accent            | #2A9D8F   | CTAs, success states, highlights|
| text-primary      | #1A1A2E   | Body text                      |
| text-secondary    | #6B7280   | Captions, meta info            |
| border            | #E5E7EB   | Dividers, card borders         |
| error             | #DC2626   | Form errors, alerts            |
| white             | #FFFFFF   | Cards, modals                  |

## Typography

| Element    | Font             | Size  | Weight | Line Height |
|------------|------------------|-------|--------|-------------|
| H1         | Inter            | 36px  | 700    | 1.2         |
| H2         | Inter            | 28px  | 600    | 1.3         |
| H3         | Inter            | 22px  | 600    | 1.3         |
| Body       | Inter            | 16px  | 400    | 1.6         |
| Body Small | Inter            | 14px  | 400    | 1.5         |
| Caption    | Inter            | 12px  | 400    | 1.4         |

## Components

### Buttons

```
Primary:    bg: primary, text: white, radius: 8px, padding: 12px 24px
Secondary:  bg: white, text: primary, border: 1px primary, radius: 8px
CTA:        bg: accent, text: white, radius: 8px, padding: 14px 28px
Disabled:   bg: #E5E7EB, text: #9CA3AF, cursor: not-allowed
```

### Cards
- Background: white
- Border: 1px solid border token
- Border radius: 12px
- Padding: 24px
- Shadow: 0 1px 3px rgba(0,0,0,0.08)
- Hover shadow: 0 4px 12px rgba(0,0,0,0.12)

### Forms
- Input height: 44px
- Border: 1px solid border token
- Border radius: 8px
- Focus ring: 2px accent colour
- Label: Body Small, weight 500, margin-bottom 4px
- Error text: 12px, error colour, margin-top 4px

### Navigation
- Desktop: Horizontal top bar, sticky, white background, subtle bottom border
- Mobile: Hamburger menu, full-screen overlay
- Active link: primary colour with 2px bottom underline

## Key Pages

| Page                | Purpose                                    |
|---------------------|--------------------------------------------|
| Home                | Overview, trust signals, primary CTAs      |
| Services            | List of procedures and treatments          |
| About / Meet the Doctor | Credentials, bio, photo                |
| Patient Resources   | Pre/post-op instructions, FAQs             |
| Contact / Book      | Location, hours, appointment request form  |
| Testimonials        | Patient reviews and outcomes               |

## Accessibility

- Minimum contrast ratio: 4.5:1 (WCAG AA)
- All images require alt text
- Interactive elements: minimum 44x44px touch target
- Keyboard navigation support on all interactive elements
- Form inputs must have associated labels
