# AI-Hub

`AI.md` is the canonical entry point for this repository. Any assistant or tool that loads repository instructions should start here, and any tool-specific adapter should point back here instead of restating the same guidance.

## Purpose

AI-Hub stores reusable AI artifacts organized by competency. It is intentionally model-agnostic and tool-aware rather than vendor-centered.

## Navigate The Repository

- `agents/`: reusable agent role definitions with clear responsibilities and boundaries
- `skills/`: atomic capabilities that can be composed into larger tasks
- `prompts/`: reusable prompt patterns for common tasks
- `workflows/`: multi-step task sequences, including human checkpoints when needed
- `knowledge/`: stable concepts, glossaries, mental models, and shared contracts (safety, handoffs, return shapes, output discipline); agents and prompts must link these instead of restating them
- `templates/`: starter files for creating new artifacts consistently
- `.cursor/rules/ai-hub.mdc` and `.coding-assistant/`: thin adapters for specific tools; they should not become alternate sources of truth

## Repository Conventions

1. Competency over configuration: describe the capability or workflow first, then note tool dependencies explicitly.
2. One concept per file: prefer small, composable artifacts over large mixed documents.
3. Keep names descriptive and generic: prefer `structured-reasoning.md` over names that imply hidden model internals.
4. Use lowercase kebab-case for artifact filenames.
5. Version and review materials over time as capabilities evolve.
6. Treat [knowledge/safety-policy.md](knowledge/safety-policy.md) as the single source of operational guardrails. Agents and skills must reference it instead of restating its clauses.
7. Shared orchestration contracts live under `knowledge/` ([orchestrated-handoff-protocol.md](knowledge/orchestrated-handoff-protocol.md), [agent-return-contracts.md](knowledge/agent-return-contracts.md), [execution-output-discipline.md](knowledge/execution-output-discipline.md)). Agents, prompts, and runtime packages must reference them instead of duplicating shapes or handoff rules.
8. Default coding style for TypeScript and Node.js work is object-oriented (classes with constructor-injected dependencies). See [skills/typescript-design.md](skills/typescript-design.md) for concrete rules and allowed exceptions.
9. Orchestrated multi-agent runs use a **task skills manifest** (per-role skill paths) supplied by the triggering prompt; see [prompts/orchestrated-execution-with-skills.md](prompts/orchestrated-execution-with-skills.md).
10. For a fixed AWS Lambda / Node.js story run with a hard-coded hub path, see [prompts/orchestrated-aws-lambda-nodejs-story.md](prompts/orchestrated-aws-lambda-nodejs-story.md). For a fixed general .NET 10 / C# 14 task run with a hard-coded hub path, see [prompts/orchestrated-dotnet-10-csharp-task.md](prompts/orchestrated-dotnet-10-csharp-task.md). For Principal-Engineer-style codebase evaluation, see [prompts/project-evaluation.md](prompts/project-evaluation.md). For criterion-by-criterion confirmation of a story against a codebase — stable `AC-1…n` IDs, one evidence-gated verdict per acceptance criterion — see [prompts/story-acceptance-criteria-confirmation.md](prompts/story-acceptance-criteria-confirmation.md). For technology-agnostic test-suite diagnosis and test/mock-only repair (skills supplied as a parameter), see [prompts/test-state-evaluation.md](prompts/test-state-evaluation.md).
11. AI-Hub is the **SDLC control repository** for Jira-triggered AI plan generation. Runtime workflows live under `.github/workflows/` (`sdlc-plan-story.yml`, `create-branch.yml`); the competency description is [workflows/sdlc-ai-plan-story.md](workflows/sdlc-ai-plan-story.md). Target allowlist: [allowlist.yml](allowlist.yml).

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

- `type`: `agent`, `skill`, `prompt`, `workflow`, `knowledge`, or `template`
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
