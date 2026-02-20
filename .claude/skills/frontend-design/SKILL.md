---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with high design quality. Use for websites, landing pages, dashboards, admin panels, SaaS apps, React components, HTML/CSS layouts, or any web UI. Covers both marketing design and product interface design. Avoids generic AI aesthetics.
license: Complete terms in LICENSE.txt
---

This skill guides creation of distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details and creative choices.

The user provides frontend requirements: a component, page, application, or interface to build. They may include context about the purpose, audience, or technical constraints.

## Design System Check (MANDATORY FIRST STEP)

Before any aesthetic decisions, check for an existing design system:

1. Read `docs/DESIGN/DESIGN_SYSTEM.md` if it exists
2. If it exists and is populated: **all aesthetic choices must conform to the design system.** Use the defined color palette, typography, spacing scale, shadow scale, motion tokens, and component patterns. The design system is the constraint -- creativity lives within it, not outside it.
3. If it does not exist or is empty: proceed with the design thinking below, but recommend running the `design-system` skill first to establish brand tokens.

**When a design system exists:** The sections below (Typography, Color & Theme, etc.) describe quality standards. Apply them using the tokens and palettes from the design system doc, not ad-hoc choices.

## Design Thinking

Before coding, understand the context and commit to a BOLD aesthetic direction:
- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick an extreme: brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, etc. There are so many flavors to choose from. Use these for inspiration but design one that is true to the aesthetic direction.
- **Constraints**: Technical requirements (framework, performance, accessibility).
- **Differentiation**: What makes this UNFORGETTABLE? What's the one thing someone will remember?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work - the key is intentionality, not intensity.

Then implement working code (HTML/CSS/JS, React, Vue, etc.) that is:
- Production-grade and functional
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view
- Meticulously refined in every detail

## Frontend Aesthetics Guidelines

Focus on:
- **Typography**: Choose fonts that are beautiful, unique, and interesting. Avoid generic fonts like Arial and Inter; opt instead for distinctive choices that elevate the frontend's aesthetics; unexpected, characterful font choices. Pair a distinctive display font with a refined body font.
- **Color & Theme**: Commit to a cohesive aesthetic. Use CSS variables for consistency. Dominant colors with sharp accents outperform timid, evenly-distributed palettes.
- **Motion**: Use animations for effects and micro-interactions. Prioritize CSS-only solutions for HTML. Use Motion library for React when available. Focus on high-impact moments: one well-orchestrated page load with staggered reveals (animation-delay) creates more delight than scattered micro-interactions. Use scroll-triggering and hover states that surprise.
- **Spatial Composition**: Unexpected layouts. Asymmetry. Overlap. Diagonal flow. Grid-breaking elements. Generous negative space OR controlled density.
- **Backgrounds & Visual Details**: Create atmosphere and depth rather than defaulting to solid colors. Add contextual effects and textures that match the overall aesthetic. Apply creative forms like gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, custom cursors, and grain overlays.

NEVER use generic AI-generated aesthetics like overused font families (Inter, Roboto, Arial, system fonts), cliched color schemes (particularly purple gradients on white backgrounds), predictable layouts and component patterns, and cookie-cutter design that lacks context-specific character.

Interpret creatively and make unexpected choices that feel genuinely designed for the context. No design should be the same. Vary between light and dark themes, different fonts, different aesthetics. NEVER converge on common choices (Space Grotesk, for example) across generations.

**IMPORTANT**: Match implementation complexity to the aesthetic vision. Maximalist designs need elaborate code with extensive animations and effects. Minimalist or refined designs need restraint, precision, and careful attention to spacing, typography, and subtle details. Elegance comes from executing the vision well.

Remember: Claude is capable of extraordinary creative work. Don't hold back, show what can truly be created when thinking outside the box and committing fully to a distinctive vision.

## Product Interface Design (Dashboards, Admin Panels, SaaS)

For product interfaces (dashboards, admin panels, tools, data interfaces), apply intent-first thinking before any visual decisions:

**Intent First**: Answer these before touching code:
- **Who is this human?** Not "users." The actual person, their context, their state of mind.
- **What must they accomplish?** The specific verb — not "use the dashboard" but "find the broken deployment."
- **What should this feel like?** "Clean and modern" means nothing. Warm like a notebook? Cold like a terminal? Dense like a trading floor?

**Domain Exploration** (required for product interfaces):
1. **Domain**: Concepts, metaphors, vocabulary from this product's world. Minimum 5.
2. **Color world**: What colors exist naturally in this domain? Not "warm" — go to the actual world.
3. **Signature**: One element that could only exist for THIS product.
4. **Defaults to reject**: 3 obvious choices for this interface type. Name them to avoid them.

**Craft Foundations**:
- **Subtle layering**: Surfaces barely different but distinguishable. Study Vercel, Linear, Supabase.
- **Borders light but not invisible**: Disappear when not looking, findable when needed.
- **Token names are design**: `--ink` and `--parchment` evoke a world. `--gray-700` evokes a template.
- **Infinite expression**: Same pattern, never the same output. A metric display could be hero number, sparkline, gauge, trend badge, or something new.

**The Checks** (run before presenting):
- **Swap test**: If you swapped choices for the most common alternatives and it didn't feel different, you defaulted.
- **Squint test**: Blur your eyes. Can you still perceive hierarchy? Nothing jumping out harshly?
- **Signature test**: Can you point to five specific elements where your signature appears?
- **Token test**: Do your CSS variables sound like they belong to this product's world?
- **Progressive disclosure test**: Can a first-time user complete the primary task without seeing advanced options? Is complexity revealed gradually, not dumped? See [design-system references/design-imperatives.md](../design-system/references/design-imperatives.md).
- **Platform test**: Does this interface follow desktop or mobile patterns correctly? Desktop: hover states, keyboard shortcuts, data tables. Mobile: touch targets (44px+), thumb zones, bottom sheets. See [desktop-patterns.md](../design-system/references/desktop-patterns.md) and [mobile-patterns.md](../design-system/references/mobile-patterns.md).
