# Workflow Standards

Extended standards referenced from [CLAUDE.md](/CLAUDE.md).

## Context Management

- Scope one feature/bug/investigation per session
- Prefer /clear over /compact (/clear wipes clean, /compact is lossy compression)
- Cut losses after two corrections -- if still wrong, /clear and restart
- Use checkpoints (Esc Esc or /rewind) aggressively
- Offload research to subagents (they have their own context windows)
- Write plans/specs to files, /clear, implement in fresh session
- Anything reusable goes in CLAUDE.md (survives /clear)

## Agent Teams

- Plan first, team second. Wrong decomposition costs 500k+ tokens.
- Use teams for 3+ independent work streams, multi-lens review, or competing hypotheses.
- One teammate per file/module. Never assign overlapping file ownership.
- 5-6 tasks per teammate. Define shared interfaces BEFORE teammates start.
- Lead orchestrates in delegate mode (Shift+Tab). Teammates execute.
- All agents use Opus. Lead and teammates run the same model for quality.
- Always brainstorm before spawning a team.

## Sandboxing

For sensitive projects, enable OS-level isolation:
- /sandbox: Restricts writes to current working directory (macOS Seatbelt / Linux bubblewrap)
- Devcontainer: Full filesystem isolation with only project files mounted
- Remote: Disposable cloud instances for maximum isolation

Permission deny rules (settings.json) enforce tool-level restrictions.
/sandbox enforces OS-level restrictions. Use both.
