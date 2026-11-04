# AI-Hub Instructions

Use [../AI.md](../AI.md) as the single source of truth for repository structure, the artifact schema, body rules, and contribution conventions.

- Start there before creating or reorganizing artifacts.
- Browse folders from [../README.md](../README.md).
- Treat this file as a thin adapter, not a second policy document.
- Use [context.md](context.md) for a short description of the repository's purpose.
- Follow [../knowledge/safety-policy.md](../knowledge/safety-policy.md) for operational guardrails, and [../knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md) for what may be read into context.
- For multi-role delivery work, start from [../agents/README.md](../agents/README.md) and [../knowledge/orchestrated-delivery-protocol.md](../knowledge/orchestrated-delivery-protocol.md). Tool-specific agent adapters live in `.cursor/agents/`, `.claude/agents/`, and `.codex/agents/`; edit the role file, never the adapter.
