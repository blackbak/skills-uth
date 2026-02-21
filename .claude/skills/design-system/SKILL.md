---
name: design-system
description: "Generate a complete design system from brand identity inputs. Bridges the gap between brand vision and concrete design tokens that Claude Code uses when building UI. Outputs docs/DESIGN/DESIGN_SYSTEM.md (tokens), docs/DESIGN/showcase.html (visual validation), docs/DESIGN/SCREENS.md (screen descriptions), and optional starter CSS/Tailwind tokens."
---

# Design System Generator

## Overview

Transform brand identity into a concrete, implementable design system. This skill bridges the gap between "what does our brand feel like" and "what CSS variables do our components use."

## Reference Guides

This skill includes detailed reference documents for platform-specific patterns and universal design principles:

- [references/design-imperatives.md](references/design-imperatives.md) -- Golden standards: progressive disclosure, Fitts's law, Hick's law, Miller's law, Jakob's law, Gestalt principles, Doherty threshold, Postel's law, principle of least surprise
- [references/desktop-patterns.md](references/desktop-patterns.md) -- Desktop layouts, hover interactions, keyboard navigation, data tables, split panels, command palettes, sidebar navigation
- [references/mobile-patterns.md](references/mobile-patterns.md) -- Touch targets, thumb zones, bottom sheets, swipe gestures, mobile forms, stack navigation, skeleton screens

Consult these references when generating component patterns and anti-patterns for the design system.

## When to Use

| Scenario | Use This |
|----------|----------|
| New project with no design system | Yes -- generate from scratch |
| Existing brand, no design tokens | Yes -- translate brand into tokens |
| Updating brand identity | Yes -- regenerate tokens from new brand |
| Adding a component to existing system | No -- use `frontend-design` skill |
| Reviewing UI code | No -- use `style-quality-guardian` skill |
| Applying a theme to slides/docs | No -- use `theme-factory` skill |

## Input

$ARGUMENTS - Brand description or context. Can be:
- A brand name and personality (e.g., "Acme Corp, developer tools, precise and confident")
- A reference to an existing brand doc
- "from-product" to extract brand signals from `docs/PRODUCT/PRODUCT_DOCUMENT.md` and `docs/PRODUCT_MARKETING/PRODUCT_MARKETING.md`
- Empty -- will prompt for brand inputs interactively

## Workflow

### Phase 1: Brand Discovery

**If $ARGUMENTS is "from-product" or empty, gather brand signals:**

1. Read existing reference docs for brand context:
   - `docs/PRODUCT/REFERENCE.md` -- identity, UX principles, audience
   - `docs/PRODUCT_MARKETING/REFERENCE.md` -- positioning, competitors, differentiation
   - `docs/DESIGN/REFERENCE.md` -- check current design system sections

   Read the full doc (e.g. `PRODUCT_DOCUMENT.md`) only if the reference lacks the brand context needed for token generation.

2. Read existing codebase for implementation context:
   - Tailwind config (`tailwind.config.{js,ts,mjs,cjs}`)
   - Global CSS (`**/globals.css`, `**/global.css`, `**/base.css`)
   - Component library config (`components.json`, `shadcn.json`)
   - Existing CSS custom properties (grep for `--color-`, `--font-`, `--space-`)

3. If insufficient brand context, ask the user these questions **one at a time**:

   **Q1: What is the brand personality?**
   Pick 3-5 adjectives: bold, precise, warm, playful, authoritative, minimal, luxurious, raw, organic, technical, friendly, serious, energetic, calm, rebellious, trustworthy.

   **Q2: Who is the actual person using this?**
   Not "users." The human. Their context, their state of mind, their environment.

   **Q3: What should the interface feel like?**
   Not "clean and modern." Reference a real thing: warm like a notebook? Cold like a terminal? Dense like a trading floor? Spacious like a gallery? Sharp like a scalpel?

   **Q4: What brands or products do you admire visually?**
   Name 2-3 products whose visual identity resonates. This anchors the aesthetic without copying.

   **Q5: What must this NOT look like?**
   Name specific anti-patterns to avoid. This is as important as the positive direction.

### Phase 2: Design System Generation

Using the brand identity from Phase 1, generate every section of `docs/DESIGN/DESIGN_SYSTEM.md`:

#### Token Generation

Generate all token categories following the detailed guidance in [references/token-generation-guide.md](references/token-generation-guide.md):

1. **Color Palette** -- Primary (3 shades), secondary, neutral scale (50-900), semantic, surface, dark mode. Calculate WCAG contrast ratios for every text/background pairing.
2. **Typography** -- Distinctive display font (never Inter/Roboto/Arial), body font, mono font. Modular type scale with `clamp()`. Text styles with weight, spacing, line-height.
3. **Spacing, Borders, Shadows, Motion** -- Scales derived from brand personality (dense/spacious/playful/minimal).
4. **Component Patterns & Signature Elements** -- 3-5 visual elements unique to this product.
5. **Progressive Disclosure Strategy** -- Disclosure levels, platform-specific patterns, smart defaults. Reference [references/design-imperatives.md](references/design-imperatives.md).
6. **Anti-Patterns** -- Based on Q5 (what this must NOT look like) plus cognitive load violations.

### Phase 3: Write the Design System

1. Populate `docs/DESIGN/DESIGN_SYSTEM.md` with all generated content
2. Preserve the template section structure exactly
3. Add a Changelog entry with today's date

### Phase 4: Generate the Visual Showcase

Generate `docs/DESIGN/showcase.html` -- a self-contained HTML page that renders every token and component visually for stakeholder validation.

The showcase template at `docs/DESIGN/showcase.html` contains placeholder CSS custom properties. Populate the `:root` block with the actual token values from the design system:

1. Replace all placeholder color hex values with the generated palette
2. Replace font families with the selected fonts (add Google Fonts `<link>` if using web fonts)
3. Replace spacing, radius, shadow, and motion values
4. Update dark mode overrides in `[data-theme="dark"]`
5. Customize the component styles (buttons, cards, inputs) to match the brand's signature elements
6. Add any brand-specific components to the Components section
7. Update the Contrast Check section with actual contrast ratio calculations

The showcase is self-contained (no build step, no dependencies). Open `docs/DESIGN/showcase.html` in any browser to validate. Share with stakeholders for design review.

### Phase 4b: Document Screen Descriptions

Populate `docs/DESIGN/SCREENS.md` with descriptions of every key screen/view in the product:

1. Read `docs/PRODUCT/PRODUCT_DOCUMENT.md` key flows to identify screens
2. For each screen, document:
   - Purpose (user goal, entry/exit points)
   - Progressive disclosure levels (what's visible at each level)
   - Desktop layout (ASCII wireframe)
   - Mobile layout (ASCII wireframe)
   - Components used (with token references)
   - Interaction states (loading, empty, error, success)
   - Accessibility notes (focus order, keyboard shortcuts, announcements)
3. Add the Navigation Map showing how screens connect

### Phase 5: Generate Starter Tokens (Optional)

If the project has a Tailwind config or CSS setup, offer to generate starter implementation files:

**Option A: Tailwind config extension**
```js
// Design system tokens for tailwind.config
{
  colors: { primary: { DEFAULT, light, dark }, ... },
  fontFamily: { display: [...], body: [...], mono: [...] },
  fontSize: { xs: [size, { lineHeight }], ... },
  spacing: { 0: '0', 1: '0.25rem', ... },
  borderRadius: { none: '0', sm: '...', ... },
  boxShadow: { xs: '...', sm: '...', ... },
}
```

**Option B: CSS custom properties file**
```css
:root {
  /* Colors */
  --color-primary: ...;
  /* Typography */
  --font-display: ...;
  /* Spacing */
  --space-1: ...;
  /* etc. */
}
```

Ask the user which output format they prefer. Generate the file but do NOT write it -- present it for review first.

### Phase 5: Validation

Before completing, run these checks:

1. **Contrast check** -- every text/background pairing meets WCAG AA (4.5:1 / 3:1)
2. **Completeness check** -- every section of the template is populated (no empty fields)
3. **Consistency check** -- all token names follow the naming convention
4. **Distinctiveness check** -- run the frontend-design "swap test": if you replaced these choices with the most common alternatives, would it feel different?
5. **Anti-pattern check** -- verify none of the documented anti-patterns appear in the system itself
6. **Design imperatives check** -- verify the design system respects progressive disclosure, Fitts's law (touch targets), Hick's law (choice reduction), and Miller's law (chunking). See [references/design-imperatives.md](references/design-imperatives.md)
7. **Platform check** -- verify desktop patterns use hover/keyboard properly (see [references/desktop-patterns.md](references/desktop-patterns.md)) and mobile patterns respect touch targets/thumb zones (see [references/mobile-patterns.md](references/mobile-patterns.md))

## Rules

- Never generate Inter, Roboto, Arial, or system font stacks as the display font
- Never generate purple-gradient-on-white as a color scheme
- Always calculate and document WCAG contrast ratios
- Always generate dark mode variants
- One question at a time during brand discovery
- Design tokens use semantic names, not descriptive (`--color-primary` not `--color-blue`)
- Domain-specific token names are encouraged (`--ink`, `--canvas`) when they fit the brand world
- All spacing must derive from the base unit -- no magic numbers
- The design system must be opinionated enough to fail the "swap test"

## Integration

This skill feeds into:
- **`frontend-design`** -- reads design system doc as constraints for aesthetic choices
- **`style-quality-guardian`** -- validates implementation against design system tokens
- **`brainstorming`** -- references design system for UI-related decisions
- **`feature-frontend`** -- Step 0 checks for design system before starting
- **`seed-docs`** -- auto-populates design system from codebase analysis
- **`sync-docs`** -- keeps design system doc in sync with token changes

```
Brand Identity -> [design-system] -> Design System Doc + Showcase + Screens -> frontend-design -> Implementation -> style-quality-guardian
                                      │
                                      ├── DESIGN_SYSTEM.md  (tokens for Claude Code)
                                      ├── showcase.html     (visual validation for humans)
                                      └── SCREENS.md        (screen-by-screen specs)
```
