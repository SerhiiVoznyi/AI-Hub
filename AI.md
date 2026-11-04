---
title: "AI-Hub"
type: knowledge
summary: "Canonical entry point: repository purpose, structure, frontmatter schema, body rules, and contribution conventions."
tags:
  - knowledge
  - entry-point
  - conventions
status: reviewed
version: 2.0.0
last_reviewed: 2026-11-04
capabilities: []
inputs:
  - any assistant or tool loading repository instructions
outputs:
  - repository structure
  - artifact schema and body rules
  - contribution conventions
---

# AI-Hub

## Summary

`AI.md` is the canonical entry point for this repository. Any assistant or tool that loads repository instructions should start here, and any tool-specific adapter should point back here instead of restating the same guidance.

AI-Hub stores reusable AI artifacts organized by competency: agents, skills, prompts, workflows, and the shared contracts they depend on. It is intentionally model-agnostic and tool-aware rather than vendor-centered.

## Scope

Governs what lives in this repository, how artifacts are shaped, and how they are added. Operational guardrails live in [knowledge/safety-policy.md](knowledge/safety-policy.md); read limits in [knowledge/scoped-context-discipline.md](knowledge/scoped-context-discipline.md); role coordination in [knowledge/orchestrated-delivery-protocol.md](knowledge/orchestrated-delivery-protocol.md).

## Navigate The Repository

Human-facing indexes, each linking back to [README.md](README.md):

- [agents/](agents/README.md): principal-level role definitions for the delivery team, including the review panel
- [skills/](skills/README.md): atomic capabilities composed into larger tasks
- [prompts/](prompts/README.md): reusable prompt patterns for recurring work
- [workflows/](workflows/README.md): multi-step sequences, including human checkpoints
- [knowledge/](knowledge/README.md): stable concepts and shared contracts; everything else links these instead of restating them
- [templates/](templates/README.md): starter files, plus the schema and body rules in full

Thin tool adapters, which point here and must not become alternate sources of truth:

- [`.cursor/rules/ai-hub.mdc`](.cursor/rules/ai-hub.mdc)
- [`.coding-assistant/instructions.md`](.coding-assistant/instructions.md) and [`.coding-assistant/context.md`](.coding-assistant/context.md)
- `.cursor/agents/`, `.claude/agents/`, `.codex/agents/`, `.claude/skills/orchestrate/`, `.agents/skills/orchestrate/` — agent adapters per tool

## Artifact Schema

Every artifact begins with this frontmatter, in this field order. The full field reference, including the capability vocabulary, is in [templates/README.md](templates/README.md).

```yaml
---
title: "Acceptance Criteria Authoring"
type: skill
summary: "One sentence, at most 160 characters, enough to route on without opening the file."
tags:
  - skills
  - delivery
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - clarified brief
outputs:
  - acceptance criteria
---
```

- `type`: `agent`, `skill`, `prompt`, `workflow`, `knowledge`, or `template`.
- `status`: `draft`, `reviewed`, or `deprecated`.
- `capabilities`: what an executor must be able to do — `read-files`, `edit-files`, `run-commands`, `web-access`, `delegate`, `ask-user`. Use `[]` for documents that are only read. This replaces the former `tooling` field: it describes a capability, never a product, and adapter permissions are derived from it.
- `effort` (agents only): `light`, `standard`, or `deep`.

## Body Rules

1. The H1 is the `title`. Every other heading is H2.
2. Follow the section order of the matching template. Optional sections may be dropped, never reordered or renamed.
3. Cross-references are relative links in a `## Related` section. No bare backtick filenames.
4. Every `## Safety` section links both [knowledge/safety-policy.md](knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](knowledge/scoped-context-discipline.md), and restates neither.
5. Keep artifacts dense: tables and imperative bullets over prose, and every line should change what the reader does.

## Repository Conventions

1. Competency over configuration: describe the capability or role first, then note executor requirements explicitly through `capabilities`.
2. One concept per file; prefer small, composable artifacts over large mixed documents.
3. Names are descriptive and generic, in lowercase kebab-case. Agent files are `<role>-agent.md`.
4. Version and review artifacts over time as capabilities evolve.
5. [knowledge/safety-policy.md](knowledge/safety-policy.md) is the single source of operational guardrails. Agents, prompts, and skills reference it instead of restating its clauses.
6. [knowledge/scoped-context-discipline.md](knowledge/scoped-context-discipline.md) is the single source of rules for what may be read or searched into context.
7. [knowledge/orchestrated-delivery-protocol.md](knowledge/orchestrated-delivery-protocol.md) is the single source of multi-role coordination rules: topology, packets, budgets, output economy, and loop limits.
8. Default coding style for TypeScript and Node.js is object-oriented, with constructor-injected classes; see [skills/typescript-oop-design.md](skills/typescript-oop-design.md). The .NET equivalent is [skills/dotnet-10-csharp-oop-design.md](skills/dotnet-10-csharp-oop-design.md).
9. Prompts run as a single executor acting as a Principal Software Engineer: evidence-cited, scoped, and gated before any change. Multi-role delivery lives in [agents/](agents/README.md), sequenced by [workflows/orchestrated-delivery.md](workflows/orchestrated-delivery.md). Agents reuse the prompts as procedures rather than duplicating them.
10. Agent files stay executor-agnostic: no vendor names, no tool-specific tool names, no absolute paths. Each links the protocol, the safety policy, and the skills it loads.
11. Tool-specific wiring lives in adapter folders. An adapter carries only the routing and permission fields its tool needs plus a pointer to the role file in `agents/`; it is the only place an absolute hub path appears, and it must never become a second role definition.
12. Every artifact that produces work carries a `## Quality Bar` its executor verifies before returning.

## Growth Rules

Prefer `agents/`, `skills/`, `prompts/`, `workflows/`, `knowledge/`, or `templates/` before adding anything at the top level. Create a new top-level folder only when at least three concrete artifacts are ready to live there, or an existing folder has become hard to navigate without a split.

## Contribution Flow

1. Start here to choose the smallest fitting directory.
2. Copy the matching template from [templates/](templates/README.md) and fill the frontmatter first.
3. Write the body, keep the section order, and delete the authoring comments.
4. Link the new artifact from that folder's README index.
5. Keep tool-specific files minimal and pointing back to this document.
