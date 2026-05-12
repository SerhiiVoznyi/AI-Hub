# AI-Hub

AI-Hub is a curated collection of AI artifacts, patterns, and frameworks focused on competency, not tools.

Start with [AI.md](AI.md). It is the canonical entry point for repository structure, metadata conventions, and contribution rules.

## Current Structure

- `agents/` for reusable agent role definitions
- `skills/` for atomic capabilities and techniques
- `prompts/` for prompt patterns and reusable task setups
- `workflows/` for multi-step execution patterns
- `knowledge/` for stable concepts, glossaries, and mental models
- `templates/` for starter files used to create new artifacts

Tool-specific configuration should stay thin and point back to `AI.md` rather than duplicating project guidance.
