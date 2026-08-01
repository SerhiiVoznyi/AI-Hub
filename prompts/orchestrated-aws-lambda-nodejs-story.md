---
title: "Orchestrated AWS Lambda (Node.js) user story execution"
type: prompt
tags:
  - prompts
  - cursor
  - multi-agent
  - orchestration
  - aws
  - lambda
  - nodejs
status: draft
version: 0.5.0
last_reviewed: 2026-05-29
tooling: tool-assisted
inputs:
  - plain-text user story under "## Story"
  - hard-coded AI_HUB_ROOT absolute path inside the prompt
outputs:
  - planner-approved plan, executor work, validator disposition, final orchestrator response
---

# Summary

Runs the four-agent flow (orchestrator → planner → executor → validator) for a simple user story on **AWS Lambda / Node.js (TypeScript + Jest)** with a fixed task skills manifest. The AI-Hub path is hard-coded, so the prompt works from any Cursor workspace. Execution mechanics live in [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md); this file only fixes the hub path, the stack, and the manifest.

## Use When

- A short story should run through the orchestrator on AWS Lambda / Node.js.
- AI-Hub is at `C:\Development\Private\AI-Hub` (otherwise edit the path once in the prompt).

## Prompt

```text
Run the AI-Hub orchestrated multi-agent pattern.

## Roots
- AI_HUB_ROOT    = C:\Development\Private\AI-Hub  (resolve agents/..., skills/..., knowledge/... from here)
- WORKSPACE_ROOT = current Cursor workspace (write code, IaC, tests, configs here unless a step targets AI-Hub)

## Load and follow (from AI_HUB_ROOT)
- agents/orchestrator-agent.md
- agents/planner-agent.md
- agents/executor-agent.md
- agents/validator-agent.md
- knowledge/safety-policy.md
- knowledge/orchestrated-handoff-protocol.md
- knowledge/agent-return-contracts.md
- knowledge/execution-output-discipline.md

## Story
(Paste the plain-text user story: actors, trigger, behavior, definition of done.)

## Task skills manifest (authoritative for this run)
orchestrator_skills:
  - skills/story-brief-normalization.md
planner_skills:
  - skills/aws-lambda-change-planning.md
  - skills/serverless-operability-checks.md
  - skills/typescript-jest-test-design.md
executor_skills:
  - skills/typescript-design.md
  - skills/nodejs-backend-implementation.md
  - skills/aws-lambda-implementation.md
  - skills/typescript-jest-test-design.md
  - skills/acceptance-evidence-traceability.md
  - skills/serverless-operability-checks.md
validator_skills:
  - skills/validation-disposition.md
  - skills/acceptance-evidence-traceability.md
  - skills/serverless-operability-checks.md
  - skills/typescript-jest-test-design.md

Stack: AWS Lambda + Node.js/TypeScript + Jest. Begin as the orchestrator; emit packages per agent-return-contracts.md.
```

## Notes

- Replace the `## Story` placeholder with the real story text before running.
- Update the `AI_HUB_ROOT` line if the repository moves (single source of truth for this prompt).
- Manifest matches **Example A** in [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md); only change it if the stack genuinely differs and the user approves.
