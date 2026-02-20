# Skill Presentation Generator

Create an interactive HTML presentation that documents a skill's architecture, workflow, and agent orchestration. The presentation is a technical overview for understanding how the skill works end-to-end.

## Input

$ARGUMENTS - The skill name to present (must match a directory under `.claude /skills/`). Example: `creative-studio`, `agent-team`, `brainstorming`.

## Process

### Step 1: Load Skill Context

1. Read `.claude /skills/$ARGUMENTS/SKILL.md` — the core skill definition
2. Read all files under `.claude /skills/$ARGUMENTS/references/` — supporting docs
3. Read all files under `.claude /skills/$ARGUMENTS/scripts/` — bundled scripts
4. Identify every agent referenced in the skill (by name or agent type). For each, read `.claude /agents/{agent-name}.md` if it exists
5. Identify every external skill referenced (e.g., `brainstorming`, `frontend-design`, `live-verification`). For each, read `.claude /skills/{skill-name}/SKILL.md` if it exists

### Step 2: Analyze and Map

Extract and organize the following from the loaded context. For each section, determine whether the information exists explicitly, can be inferred, or does not exist.

**Agents:**
- List every agent involved in the skill's workflow
- For each agent: name, role, model, tools, skills, when it is spawned, what it produces
- Note whether agents run in parallel or sequentially
- If an agent definition file does not exist under `.claude /agents/`, state: "Agent definition not found — referenced in skill but not defined as a standalone agent"

**Prompts:**
- Identify all prompt templates, spawn prompts, and handoff prompts referenced in the skill
- Trace where prompts live (inline in SKILL.md, in references/, or dynamically generated)
- If the skill references prompt templates in a file (e.g., `references/team-handoff-prompts.md`), summarize the prompt structure for each agent/phase
- If prompts are not explicitly defined, state: "No explicit prompt templates — agents receive context via task description at spawn time"

**Workflows:**
- Map the complete workflow from input to output as a sequence of phases/steps
- For each phase: what happens, which agent(s) execute, what artifacts are produced, what the exit criteria are
- Identify decision points, loops, and branching logic
- Note parallelism (which phases spawn multiple agents simultaneously)

**Handoff:**
- Document how work passes between agents and phases
- What artifacts does each agent produce that the next agent consumes?
- How is context shared (files on disk, task descriptions, shared directories)?
- If handoff is implicit (orchestrator reads output and passes to next agent), state that explicitly

**Evaluation:**
- Identify any evaluation, scoring, or quality gate mechanisms
- Who evaluates (a dedicated agent like `customer`, a quality guardian, the orchestrator)?
- What criteria are used (scoring dimensions, pass/fail thresholds, checklists)?
- If no evaluation mechanism exists, state: "No built-in evaluation — skill completes when workflow finishes"

**Feedback:**
- Identify any feedback loops or iteration cycles
- What triggers another iteration (score thresholds, user input, quality gate failures)?
- How does feedback flow back into the workflow (prepended to prompts, written to files, passed as context)?
- What are the termination conditions (max iterations, score threshold, user override)?
- If no feedback loop exists, state: "No feedback loop — skill executes linearly without iteration"

### Step 3: Build the Presentation

Create a single self-contained HTML file at `presentation/$ARGUMENTS.html` with:

**Design requirements:**
- Single-file HTML with embedded CSS and JS — no external dependencies except Google Fonts
- Use the `frontend-design` skill's aesthetic principles: distinctive typography, bold visual direction, intentional color palette
- Dark theme with high contrast for readability
- Responsive layout that works on desktop and tablet
- Smooth scroll-triggered animations for section reveals
- Interactive elements where they add clarity (expandable agent cards, clickable workflow nodes)

**Presentation structure — one section per topic:**

1. **Title Slide** — Skill name, one-line description from frontmatter, visual badge showing agent count and phase count

2. **Overview** — 2-3 sentence summary of what the skill does and when to use it. Include the skill's "When to Use" table if one exists.

3. **Agents** — Card grid showing each agent involved. Each card displays: agent name, role description, model, tools available, skills available, what it produces. Cards for agents without a definition file get a subtle "referenced only" indicator. If agents run in parallel, visually group them.

4. **Workflow** — Visual step-by-step flow diagram built with HTML/CSS (not an image). Show phases as connected nodes. For each phase: name, description, which agent(s) execute, artifacts produced. Highlight parallel execution paths. Show decision points and branching. Use arrows or connecting lines between phases.

5. **Prompts** — For each phase that has explicit prompt templates: show the prompt structure, what variables are injected, and what context the agent receives. If prompts are loaded from reference files, show the file path and summarize the template. Use code blocks for prompt excerpts.

6. **Handoff** — Diagram showing artifact flow between phases. What does each agent write, and what does the next agent read? Show the file/directory structure of the workspace if the skill defines one (e.g., `docs/studio/team-a/`).

7. **Evaluation** — Scoring framework visualization. Show dimensions, scoring criteria, and thresholds. If a dedicated evaluation agent exists, show its evaluation output format. If no evaluation exists, show a clear "Not Implemented" card explaining what evaluation could look like.

8. **Feedback** — Loop diagram showing iteration flow. Show triggers, conditions, and termination criteria as a decision tree or flowchart. If no feedback loop exists, show a clear "Linear Execution" card.

9. **Rules & Constraints** — Bullet list of the skill's rules section, styled as constraint cards with icons.

10. **References** — Links to all files that compose the skill (SKILL.md, references/, scripts/, agent definitions). Show relative paths.

**Visual style guidelines:**
- Use CSS Grid or Flexbox for layouts
- Monospace font for code/paths, sans-serif for body text
- Color-code agents consistently across all sections (same agent = same color everywhere)
- Use subtle gradients, borders, and shadows for depth — avoid flat design
- Section transitions with fade-in on scroll (Intersection Observer)
- Navigation sidebar or top nav with section links
- Print-friendly: `@media print` styles that remove animations and fix layout

### Step 4: Validate

1. Open the generated HTML file and verify it renders correctly
2. Confirm all sections have content (even if that content is "does not exist" for missing elements)
3. Verify the workflow diagram matches the SKILL.md phases exactly
4. Verify agent names and roles are accurate to the source files

## Output

Single file: `presentation/$ARGUMENTS.html`

## Rules

- Present only what actually exists in the skill files — do not fabricate workflows, agents, or mechanisms
- When something does not exist, say so explicitly and explain what it means (e.g., "No evaluation agent — the skill relies on the orchestrator's judgment")
- Use direct quotes from SKILL.md and agent definitions where they add clarity
- The presentation must be self-contained — opening the HTML file in a browser should show the complete presentation with no broken assets
- Do not use external JS libraries (no React, no reveal.js) — vanilla HTML/CSS/JS only, with Google Fonts as the sole external resource
- Keep the HTML under 2000 lines — prefer concise, well-structured markup over verbose repetition
