---
name: paper-submission
description: "Orchestrates the full scientific paper lifecycle: researcher writes, reviewer tears it apart, researcher revises, loop repeats until the paper earns ACCEPT. Use for writing and publishing CS/ML/AI research papers."
---

# Paper Submission Lifecycle

Orchestrates a researcher and a research-reviewer through the full cycle of writing, reviewing, revising, and publishing a scientific paper in Computer Science, Machine Learning, or AI.

## Input

$ARGUMENTS - Research topic, question, or brief description (e.g., "attention mechanism efficiency in long-context transformers", "survey on reward hacking in RLHF") OR a path to an existing draft to submit for review.

## Workflow

```
BRIEF -> LITERATURE REVIEW -> DRAFT -> REVIEW -> REVISE -> RE-REVIEW -> ... -> ACCEPT -> CAMERA-READY
```

### Phase 0: Research Brief

1. Parse `$ARGUMENTS` into a structured research brief
2. If `$ARGUMENTS` is a file path, read the existing draft and skip to Phase 3 (Review)
3. Write the brief to `docs/papers/<paper-slug>/brief.md` following the template in [references/brief-template.md](references/brief-template.md)
4. Create workspace directory: `docs/papers/<paper-slug>/workspace/`
5. Present the brief to the user for approval before proceeding

The `<paper-slug>` is a short, lowercase, hyphenated identifier derived from the topic (e.g., `efficient-long-context-attention`).

### Phase 1: Literature Review

Spawn 1 `researcher` subagent with the literature review prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

The researcher:
- Reads the brief
- Searches for related work using WebSearch and WebFetch
- Organizes findings thematically
- Identifies the specific research gap the paper will address
- Proposes 2-3 methodological approaches with trade-offs

**Agent type:** `researcher`
**Output:** `docs/papers/<paper-slug>/workspace/literature-review.md`

**Checkpoint:** Present the literature review and proposed approaches to the user. User selects or refines the approach before proceeding.

### Phase 2: Paper Draft

Spawn 1 `researcher` subagent with the paper draft prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

The researcher:
- Reads the brief, literature review, and selected approach
- Writes a complete paper draft following standard structure (Abstract, Introduction, Related Work, Methodology, Experiments, Results, Analysis, Conclusion)
- Includes all figures, tables, and equations
- Writes the bibliography in BibTeX format
- Performs a self-review against the quality checklist in the researcher agent definition

**Agent type:** `researcher`
**Output:**
- `docs/papers/<paper-slug>/workspace/drafts/draft-v1.md` (full paper)
- `docs/papers/<paper-slug>/workspace/drafts/references-v1.bib` (bibliography)
- `docs/papers/<paper-slug>/workspace/figures/` (any generated figures)

### Phase 3: Review

Spawn 1 `research-reviewer` subagent with the review prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

The reviewer:
- Reads the latest draft in full
- Evaluates across all six dimensions (Novelty, Technical Soundness, Experimental Rigor, Writing, Reproducibility, Ethics)
- Issues a verdict (REJECT or MAJOR REVISION on first review)
- Writes a structured review with actionable feedback

**Agent type:** `research-reviewer`
**Output:** `docs/papers/<paper-slug>/reviews/review-round-N.md`

### Phase 4: Revision

Spawn 1 `researcher` subagent with the revision prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

The researcher:
- Reads the review carefully
- Writes a detailed response letter addressing every comment
- Revises the paper, making all changes described in the response
- Increments the draft version

**Agent type:** `researcher`
**Output:**
- `docs/papers/<paper-slug>/workspace/drafts/draft-vN.md` (revised paper)
- `docs/papers/<paper-slug>/workspace/drafts/references-vN.bib` (updated bibliography)
- `docs/papers/<paper-slug>/workspace/responses/response-round-N.md` (response letter)

### Phase 5: Loop or Accept

**Check loop conditions:**

| Condition | Action |
|-----------|--------|
| Verdict is REJECT | Present findings to user. User decides: REVISE (loop to Phase 4) or ABANDON |
| Verdict is MAJOR REVISION | Loop to Phase 4 (revision), then Phase 3 (re-review) |
| Verdict is MINOR REVISION | Loop to Phase 4 (revision), then Phase 3 (re-review) |
| Verdict is ACCEPT | Proceed to Phase 6 (Camera-Ready) |
| Round reaches max iterations (5) | Present best draft to user. User decides: continue or stop |
| User requests another revision | Loop to Phase 4 |
| User requests stop | Stop and preserve all artifacts |

**Important:** The reviewer NEVER accepts on the first review. The minimum path to ACCEPT is:
1. Round 1: Draft -> MAJOR REVISION
2. Round 2: Revision -> MINOR REVISION or MAJOR REVISION
3. Round 3+: Revision -> ACCEPT (if all issues genuinely resolved)

### Phase 6: Camera-Ready

Spawn 1 `researcher` subagent with the camera-ready prompt from [references/team-handoff-prompts.md](references/team-handoff-prompts.md).

The researcher:
- Reads the accepted draft and final review
- Applies any remaining minor fixes from the last review
- Formats the paper for the target venue (if specified in the brief)
- Performs a final quality pass
- Produces the final version

**Agent type:** `researcher`
**Output:**
- `docs/papers/<paper-slug>/final/paper.md` (camera-ready version)
- `docs/papers/<paper-slug>/final/references.bib` (final bibliography)
- `docs/papers/<paper-slug>/final/figures/` (final figures)

## Artifact Workspace

```
docs/papers/<paper-slug>/
+-- brief.md
+-- workspace/
|   +-- literature-review.md
|   +-- drafts/
|   |   +-- draft-v1.md
|   |   +-- draft-v2.md
|   |   +-- draft-v3.md
|   |   +-- references-v1.bib
|   |   +-- references-v2.bib
|   |   +-- references-v3.bib
|   +-- responses/
|   |   +-- response-round-1.md
|   |   +-- response-round-2.md
|   +-- figures/
+-- reviews/
|   +-- review-round-1.md
|   +-- review-round-2.md
|   +-- review-round-3.md
+-- final/
    +-- paper.md
    +-- references.bib
    +-- figures/
```

## Loop Control

- **First review verdict:** Always REJECT or MAJOR REVISION. No exceptions.
- **Max review rounds:** 5. After 5 rounds, present the best draft to the user regardless of verdict.
- **Accept threshold:** Reviewer issues ACCEPT only when every previous comment is addressed and no new critical or major issues exist.
- **User override:** The user can force another iteration, skip to camera-ready, or stop at any point.
- **Abandon:** If the reviewer issues REJECT and the user agrees the approach is fundamentally flawed, stop and preserve artifacts for future reference.

## Rules

- The researcher and reviewer never run in parallel -- the review loop is strictly sequential
- The reviewer reads the full paper every round -- not just the diff
- The response letter must quote every reviewer comment and state what changed
- The reviewer verifies response claims against the actual revised paper
- All artifacts are written to the paper workspace -- no files outside `docs/papers/<paper-slug>/`
- The researcher may use any available skill (brainstorming, agent-browser, etc.) during drafting
- The reviewer operates in plan mode -- reads and evaluates only, does not modify the paper
- Each draft version is preserved -- never overwrite a previous draft
- The brief is immutable after Phase 0 -- scope changes require a new brief with user approval

## References

- [references/brief-template.md](references/brief-template.md) -- template for the research brief
- [references/team-handoff-prompts.md](references/team-handoff-prompts.md) -- spawn prompts for each agent per phase
