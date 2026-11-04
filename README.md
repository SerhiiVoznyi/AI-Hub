![AI-Hub](.assets/banner.png)

# AI-Hub

AI-Hub is a curated collection of AI artifacts, patterns, and frameworks focused on competency, not tools.

**Start here:** [AI.md](AI.md) — canonical entry point for repository structure, the artifact schema, and contribution rules.

## Browse

| Folder | What lives here |
| --- | --- |
| [agents/](agents/README.md) | Delivery team roles, including the review panel |
| [skills/](skills/README.md) | Atomic capabilities and techniques |
| [prompts/](prompts/README.md) | Prompt patterns and reusable task setups |
| [workflows/](workflows/README.md) | Multi-step execution patterns |
| [knowledge/](knowledge/README.md) | Stable concepts, glossaries, and shared contracts |
| [templates/](templates/README.md) | Starter files, the frontmatter schema, and the body rules |

## Quick links

- [Safety policy](knowledge/safety-policy.md) — operational guardrails for every agent, prompt, and skill
- [Orchestrated delivery](workflows/orchestrated-delivery.md) — triage, design, client gate, parallel build, panel verification
- [Orchestrator agent](agents/orchestrator-agent.md) — owns a request end to end and is the only role that talks to the client
- [Delivery protocol](knowledge/orchestrated-delivery-protocol.md) — packets, returns, budgets, and loop limits
- [Project evaluation](prompts/project-evaluation.md) — Principal-Engineer codebase audit across 14 criteria
- [Story completion evaluation](prompts/story-development-completion-evaluation.md) — is the story implemented, and is every criterion met
- [Bug fix diagnosis and resolution](prompts/bug-fix-diagnosis-and-resolution.md) — triage, root cause, gated fix
- [Repository knowledge graph creation](prompts/repository-knowledge-graph-creation.md) — root and per-project `AGENTS.md`, `AI.md`, and `README.md`, plus a `kb/` graph, so agents can navigate any repository, monorepos included

## Tool adapters

Thin, tool-specific adapters. They point back to [AI.md](AI.md) and the role files in [agents/](agents/README.md), and must not become alternate sources of truth:

- [`.cursor/rules/ai-hub.mdc`](.cursor/rules/ai-hub.mdc) — Cursor entry rule
- [`.coding-assistant/instructions.md`](.coding-assistant/instructions.md) — generic coding-assistant adapter
- [`.coding-assistant/context.md`](.coding-assistant/context.md) — short purpose context
- `.cursor/agents/`, `.claude/agents/`, `.codex/agents/` — agent adapters, one thin file per role
- `.claude/skills/orchestrate/`, `.agents/skills/orchestrate/` — the `/orchestrate` entry skill
