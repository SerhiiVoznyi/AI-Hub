![AI-Hub](.assets/banner.png)

# AI-Hub

AI-Hub is a curated collection of AI artifacts, patterns, and frameworks focused on competency, not tools.

**Start here:** [AI.md](AI.md) — canonical entry point for repository structure, metadata conventions, and contribution rules.

## Browse

| Folder | What lives here |
| --- | --- |
| [agents/](agents/README.md) | Reusable agent role definitions |
| [skills/](skills/README.md) | Atomic capabilities and techniques |
| [prompts/](prompts/README.md) | Prompt patterns and reusable task setups |
| [workflows/](workflows/README.md) | Multi-step execution patterns |
| [knowledge/](knowledge/README.md) | Stable concepts, glossaries, and shared contracts |
| [templates/](templates/README.md) | Starter files for new artifacts |

## Quick links

- [Safety policy](knowledge/safety-policy.md) — operational guardrails for every agent and skill
- [Orchestrated handoff protocol](knowledge/orchestrated-handoff-protocol.md) — four-agent topology and skill-manifest forwarding
- [Orchestrated execution with skills](prompts/orchestrated-execution-with-skills.md) — start a planner → executor → validator run
- [Peer review panel](prompts/peer-review-panel.md) — philosopher / AI expert / software engineer panel

## Tool adapters

Thin, tool-specific adapters — they point back to [AI.md](AI.md) and must not become alternate sources of truth:

- [`.cursor/rules/ai-hub.mdc`](.cursor/rules/ai-hub.mdc) — Cursor entry rule
- [`.coding-assistant/instructions.md`](.coding-assistant/instructions.md) — generic coding-assistant adapter
- [`.coding-assistant/context.md`](.coding-assistant/context.md) — short purpose context
