# AI-Hub

`AI.md` is the canonical entry point for this repository. Any assistant or tool that loads repository instructions should start here, and any tool-specific adapter should point back here instead of restating the same guidance.

## Purpose

AI-Hub stores reusable AI artifacts organized by competency: prompts, skills, and the shared contracts they depend on. It is intentionally model-agnostic and tool-aware rather than vendor-centered.

## Navigate The Repository

Human-facing indexes (each links back to [README.md](README.md)):

- [skills/](skills/README.md): atomic capabilities that can be composed into larger tasks
- [prompts/](prompts/README.md): reusable prompt patterns for common tasks
- [workflows/](workflows/README.md): multi-step task sequences, including human checkpoints when needed
- [knowledge/](knowledge/README.md): stable concepts, glossaries, mental models, and shared contracts (safety, context discipline); prompts and skills must link these instead of restating them
- [templates/](templates/README.md): starter files for creating new artifacts consistently

Thin tool adapters (point here; do not become alternate sources of truth):

- [`.cursor/rules/ai-hub.mdc`](.cursor/rules/ai-hub.mdc)
- [`.coding-assistant/instructions.md`](.coding-assistant/instructions.md) / [`.coding-assistant/context.md`](.coding-assistant/context.md)

## Repository Conventions

1. Competency over configuration: describe the capability or workflow first, then note tool dependencies explicitly.
2. One concept per file: prefer small, composable artifacts over large mixed documents.
3. Keep names descriptive and generic: prefer `structured-reasoning.md` over names that imply hidden model internals.
4. Use lowercase kebab-case for artifact filenames.
5. Version and review materials over time as capabilities evolve.
6. Treat [knowledge/safety-policy.md](knowledge/safety-policy.md) as the single source of operational guardrails. Prompts and skills must reference it instead of restating its clauses.
7. Treat [knowledge/scoped-context-discipline.md](knowledge/scoped-context-discipline.md) as the single source of rules for what may be read or searched into context. Prompts must reference it instead of restating read limits.
8. Default coding style for TypeScript and Node.js work is object-oriented (classes with constructor-injected dependencies). See [skills/typescript-oop-design.md](skills/typescript-oop-design.md) for concrete rules and allowed exceptions. The .NET equivalent is [skills/dotnet-10-csharp-oop-design.md](skills/dotnet-10-csharp-oop-design.md).
9. Prompts run as a single assistant acting as a Principal Software Engineer: evidence-cited, scoped to the task, and gated before any change. There is no agent catalog and no multi-agent orchestration.
10. The five prompts are: [prompts/project-evaluation.md](prompts/project-evaluation.md) for a Principal-Engineer codebase audit; [prompts/story-acceptance-criteria-confirmation.md](prompts/story-acceptance-criteria-confirmation.md) for criterion-by-criterion feasibility of a story against the project that would implement it; [prompts/story-development-completion-evaluation.md](prompts/story-development-completion-evaluation.md) for whether a story is implemented and every acceptance criterion met, with cited evidence; [prompts/bug-fix-diagnosis-and-resolution.md](prompts/bug-fix-diagnosis-and-resolution.md) for bug triage, root cause, and a gated fix; [prompts/repository-knowledge-graph-creation.md](prompts/repository-knowledge-graph-creation.md) for building a file-based knowledge graph that lets agents navigate a repository without reading all of it.

## Artifact Metadata

Every artifact should begin with lightweight frontmatter:

```yaml
---
title: "Structured Reasoning"
type: skill
tags:
  - reasoning
  - decomposition
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - problem statement
outputs:
  - stepwise analysis
---
```

Field guidance:

- `type`: `skill`, `prompt`, `workflow`, `knowledge`, or `template`
- `status`: `draft`, `reviewed`, or `deprecated`
- `tooling`: `agnostic`, `tool-assisted`, or a specific tool name when required
- Navigation links belong in folder `README.md` indexes and intentional body links, not in frontmatter
## Growth Rules

Only create a new top-level folder when one of these is true:

- at least three concrete artifacts are ready to live there
- an existing folder has become hard to navigate without a split

Until then, keep governance, evaluation, safety, and domain-specific material inside the current v1 structure.

## Contribution Flow

1. Start here to choose the smallest fitting directory.
2. Create or update an artifact using the shared frontmatter schema.
3. Link the new artifact from the nearest folder `README.md` when helpful.
4. Keep tool-specific files minimal and point them back to this document.
