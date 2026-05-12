# AI-Hub

`AI.md` is the canonical entry point for this repository. Any assistant or tool that loads repository instructions should start here, and any tool-specific adapter should point back here instead of restating the same guidance.

## Purpose

AI-Hub stores reusable AI artifacts organized by competency. It is intentionally model-agnostic and tool-aware rather than vendor-centered.

## Navigate The Repository

- `agents/`: reusable agent role definitions with clear responsibilities and boundaries
- `skills/`: atomic capabilities that can be composed into larger tasks
- `prompts/`: reusable prompt patterns for common tasks
- `workflows/`: multi-step task sequences, including human checkpoints when needed
- `knowledge/`: stable concepts, glossaries, and mental models
- `templates/`: starter files for creating new artifacts consistently
- `.cursor/rules/ai-hub.mdc` and `.coding-assistant/`: thin adapters for specific tools; they should not become alternate sources of truth

## Repository Conventions

1. Competency over configuration: describe the capability or workflow first, then note tool dependencies explicitly.
2. One concept per file: prefer small, composable artifacts over large mixed documents.
3. Keep names descriptive and generic: prefer `structured-reasoning.md` over names that imply hidden model internals.
4. Use lowercase kebab-case for artifact filenames.
5. Version and review materials over time as capabilities evolve.

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
related:
  - ../prompts/README.md
---
```

Field guidance:

- `type`: `agent`, `skill`, `prompt`, `workflow`, `knowledge`, or `template`
- `status`: `draft`, `reviewed`, or `deprecated`
- `tooling`: `agnostic`, `tool-assisted`, or a specific tool name when required
- `related`: relative links to neighboring artifacts or indexes

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
