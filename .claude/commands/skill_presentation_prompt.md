# Skill Workflow Visualizer

Create an interactive HTML visualization of a skill's workflow and the agents it orchestrates.

## Input

$ARGUMENTS - The skill name to visualize (must match a directory under `.claude/skills/`). Example: `creative-studio`, `agent-team`, `brainstorming`.

## Process

### Step 1: Load Skill Context

1. Read `.claude/skills/$ARGUMENTS/SKILL.md` — the core skill definition
2. Read all files under `.claude/skills/$ARGUMENTS/references/` — supporting docs
3. Identify every agent referenced in the skill (by name or agent type). For each, read `.claude/agents/{agent-name}.md` if it exists
4. Identify every external skill referenced. For each, read `.claude/skills/{skill-name}/SKILL.md` if it exists

### Step 2: Extract Workflow and Agents

**Workflow:**
- Map the complete workflow from input to output as a sequence of phases/steps
- For each phase: what happens, which agent(s) execute, what artifacts are produced, what the exit criteria are
- Identify decision points, loops, and branching logic
- Note parallelism (which phases spawn multiple agents simultaneously)
- Document handoffs: what each agent produces that the next agent consumes

**Agents (only if the skill spawns subagents):**
- List every agent involved in the skill's workflow
- For each agent: name, role, model, tools, when it is spawned, what it produces
- Note whether agents run in parallel or sequentially
- If an agent definition file does not exist under `.claude/agents/`, mark it as "referenced only — no standalone definition"

### Step 3: Build the Visualization

Create a single self-contained HTML file at `presentation/$ARGUMENTS.html`.

**Design requirements:**
- Single-file HTML with embedded CSS and JS — no external dependencies except Google Fonts
- Dark theme with high contrast
- Responsive layout (desktop and tablet)
- Smooth scroll-triggered animations (Intersection Observer)
- No external JS libraries — vanilla HTML/CSS/JS only

**Sections:**

1. **Header** — Skill name, one-line description, badge showing phase count and agent count (if any)

2. **Workflow Diagram** — Visual step-by-step flow built with HTML/CSS (not an image). Show phases as connected nodes with arrows/lines between them. For each phase: name, description, executing agent(s), artifacts produced. Highlight parallel execution paths. Show decision points, branching, and loops as distinct visual elements.

3. **Agents** (only render if the skill uses subagents) — Card grid showing each agent. Each card: agent name, role, model, tools, what it produces. Color-code agents consistently with the workflow diagram (same agent = same color). Cards for agents without a definition file get a "referenced only" indicator. Visually group agents that run in parallel.

**Visual style:**
- CSS Grid/Flexbox layouts
- Monospace font for code/paths, sans-serif for body text
- Color-code agents consistently across workflow and agent cards
- Subtle gradients, borders, shadows for depth
- Section fade-in on scroll
- `@media print` styles that remove animations

### Step 4: Validate

1. Open the generated HTML file and verify it renders correctly
2. Verify the workflow diagram matches the SKILL.md phases exactly
3. Verify agent names and roles are accurate to the source files

## Output

Single file: `presentation/$ARGUMENTS.html`

## Rules

- Present only what actually exists in the skill files — do not fabricate workflows or agents
- If the skill does not use subagents, omit the Agents section entirely — show only the workflow
- Use direct quotes from SKILL.md and agent definitions where they add clarity
- The HTML must be self-contained — opening it in a browser should work with no broken assets
- Keep the HTML under 1500 lines
