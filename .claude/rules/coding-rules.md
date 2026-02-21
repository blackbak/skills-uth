# Coding Rules

CRITICAL RULES
- No backwards compatibility. No legacy code. Rewrite, build, test, deploy, run.
- NO RE-EXPORTS. Especially from shared. Shared is the main contract between the services.
- NO remapping data with minimal change. Reuse the same stuff.
- ABSOLUTELY NO BLOAT. EVERY LINE OF CODE THAT YOU WRITE SHOULD BE MEANINGFUL. If you don't think it is then you should refactor something existing to solve the problem.
- We are writing strict typed code.
- ALL ISSUES ARE ISSUES. THERE ARE NO MINOR ISSUES. THERE IS NO FIXING LATER.
- NEVER EVER NEVER use hardcoded values. If you need to set something put it in env vars or SOLVE IT PROPERLY.

See /CLAUDE.md for complete development philosophy, quality thresholds, and toolchain preferences.
