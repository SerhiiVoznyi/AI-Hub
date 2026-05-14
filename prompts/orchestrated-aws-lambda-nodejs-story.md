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
version: 0.4.0
last_reviewed: 2026-05-14
tooling: tool-assisted
inputs:
  - plain-text user story under "## Story"
  - explicit AI_HUB_ROOT absolute path inside the prompt
outputs:
  - planner-approved plan, executor work, validator disposition, final orchestrator response
related:
  - ./orchestrated-execution-with-skills.md
  - ../agents/orchestrator-agent.md
  - ../knowledge/safety-policy.md
---

# Summary

Run the four-agent flow (orchestrator → planner → executor → validator) for a **simple user story** on **AWS Lambda / Node.js**, with a fixed task skills manifest. The **AI-Hub repository path is hard-coded inside the prompt** (`C:\Development\Ai-Hub`), so this works the same whether Cursor is opened on the hub itself, on an unrelated project, or anywhere else.

Agent, skill, and policy mechanics live in the agent files and in [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md); this prompt only adds the absolute hub path, the stack, and the manifest.

## Use When

- A short story should be executed through the orchestrator on AWS Lambda / Node.js.
- The AI-Hub repository lives at `C:\Development\Ai-Hub` (edit the prompt once if it ever moves).

## Prompt

```text
Run the AI-Hub orchestrated multi-agent pattern.

## Roots

- AI_HUB_ROOT    = C:\Development\Ai-Hub
- WORKSPACE_ROOT = the current Cursor workspace root.

Resolve any path of the form agents/..., skills/..., or knowledge/... from AI_HUB_ROOT.
Create or edit code, IaC, tests, and configs under WORKSPACE_ROOT unless a step explicitly targets AI-Hub itself.

## Agents and policy

Load and follow:
- agents/orchestrator-agent.md
- agents/planner-agent.md
- agents/executor-agent.md
- agents/validator-agent.md
- knowledge/safety-policy.md

## Story

(Paste the plain-text user story here: actors, trigger, behavior, definition of done.)

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

Stack: AWS Lambda, Node.js / TypeScript, Jest. Begin with the orchestrator role.
```

## Notes

- Replace the parenthetical under `## Story` with the actual story text.
- If the AI-Hub repository ever moves, update the `AI_HUB_ROOT` line in the fenced block (single source of truth for this prompt).
- Manifest matches **Example A** in [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md). Change it only if the story genuinely needs a different stack and the user approves.
