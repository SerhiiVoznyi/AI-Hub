---
title: "Orchestrated .NET 10 / C# 14 task execution"
type: prompt
tags:
  - prompts
  - cursor
  - multi-agent
  - orchestration
  - csharp
  - dotnet
status: draft
version: 0.1.0
last_reviewed: 2026-08-01
tooling: tool-assisted
inputs:
  - plain-text task under "## Task" as <TEXT>
  - hard-coded AI_HUB_ROOT absolute path inside the prompt
outputs:
  - planner-approved plan, executor work, validator disposition, final orchestrator response
---

# Summary

Runs the four-agent flow (orchestrator → planner → executor → validator) for a general **.NET 10 / C# 14 + xUnit** task with a fixed task skills manifest (no AWS Lambda skills). The AI-Hub path is hard-coded, so the prompt works from any Cursor workspace. Execution mechanics live in [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md); this file only fixes the hub path, the stack, and the manifest.

## Use When

- A plain-text task should run through the orchestrator on .NET 10 / C# 14 with xUnit.
- AI-Hub is at `C:\Development\Private\AI-Hub` (otherwise edit the path once in the prompt).

## Prompt

```text
Run the AI-Hub orchestrated multi-agent pattern.

## Roots
- AI_HUB_ROOT    = C:\Development\Private\AI-Hub  (resolve agents/..., skills/..., knowledge/... from here)
- WORKSPACE_ROOT = current Cursor workspace (write code, tests, configs here unless a step targets AI-Hub)

## Load and follow (from AI_HUB_ROOT)
- agents/orchestrator-agent.md
- agents/planner-agent.md
- agents/executor-agent.md
- agents/validator-agent.md
- knowledge/safety-policy.md
- knowledge/orchestrated-handoff-protocol.md
- knowledge/agent-return-contracts.md
- knowledge/execution-output-discipline.md

## Task
<TEXT>

## Task skills manifest (authoritative for this run)
orchestrator_skills:
  - skills/story-brief-normalization.md
planner_skills:
  - skills/dotnet-10-csharp-design.md
  - skills/dotnet-10-csharp-test-design.md
executor_skills:
  - skills/dotnet-10-csharp-design.md
  - skills/dotnet-backend-implementation.md
  - skills/dotnet-10-csharp-test-design.md
  - skills/acceptance-evidence-traceability.md
validator_skills:
  - skills/validation-disposition.md
  - skills/acceptance-evidence-traceability.md
  - skills/dotnet-10-csharp-test-design.md

Stack: .NET 10 / C# 14 + xUnit. Begin as the orchestrator; emit packages per agent-return-contracts.md.
```

## Notes

- Replace `<TEXT>` under `## Task` with the concrete goal, scope, and constraints before running.
- Update the `AI_HUB_ROOT` line if the repository moves (single source of truth for this prompt).
- Manifest is the general .NET 10 / C# stack (not Lambda Example B in [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md)); only change it if the stack genuinely differs and the user approves.
