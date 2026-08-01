---
title: "Orchestrated execution with task skills manifest"
type: prompt
tags:
  - prompts
  - multi-agent
  - orchestration
  - skills
status: draft
version: 0.2.0
last_reviewed: 2026-08-01
tooling: agnostic
inputs:
  - user objective
  - task skills manifest
outputs:
  - bounded multi-agent run with explicit skill binding
---

# Summary

Kick off the planner, executor, and validator flow through the orchestrator while binding skills **only** from a per-role manifest. Paths are repository-root relative (for example `skills/foo.md`).

## Use When

- You want the four-agent orchestrated pattern with explicit control over which skills each role loads.
- The stack or test tooling varies by task and must not be hardcoded inside agent definitions.

## Prompt

```text
You are running the AI-Hub orchestrated multi-agent pattern. Load and follow from the repository root:

Agents:
- agents/orchestrator-agent.md
- agents/planner-agent.md
- agents/executor-agent.md
- agents/validator-agent.md

Knowledge (do not restate; obey):
- knowledge/safety-policy.md
- knowledge/orchestrated-handoff-protocol.md
- knowledge/agent-return-contracts.md
- knowledge/execution-output-discipline.md

## User objective

{{USER_OBJECTIVE}}

## Task skills manifest

Authoritative for this run. Resolve paths from the repository root. Apply each skill only for the listed role(s).
Paths: skills/... or knowledge/...
Required keys: orchestrator_skills, planner_skills, executor_skills, validator_skills.

orchestrator_skills:
  - skills/story-brief-normalization.md
planner_skills:
  - skills/aws-lambda-change-planning.md
executor_skills:
  - skills/typescript-design.md
validator_skills:
  - skills/validation-disposition.md

Replace lists for this task before execution. Manifest changes need user approval.

## Start

Begin as the orchestrator: normalize using orchestrator_skills, then follow the handoff protocol through planner → executor → validator. Emit packages per agent-return-contracts.md; keep outputs short per execution-output-discipline.md.
```

## Notes

- Replace `{{USER_OBJECTIVE}}` with the concrete goal, scope, and constraints.
- Duplicate entries across roles are allowed when the same skill should guide multiple phases (for example acceptance traceability on both executor and validator).
- `knowledge/safety-policy.md` always applies; listing it under a role is optional.

## Appendix: example manifests

These examples are copy-paste starters. Adjust lists to match the task.

### Example A — TypeScript, Node.js, AWS Lambda, Jest

```yaml
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
```

### Example B — .NET 10 C#, AWS Lambda, xUnit

```yaml
orchestrator_skills:
  - skills/story-brief-normalization.md
planner_skills:
  - skills/aws-lambda-change-planning.md
  - skills/serverless-operability-checks.md
  - skills/dotnet-10-csharp-test-design.md
executor_skills:
  - skills/dotnet-10-csharp-design.md
  - skills/dotnet-backend-implementation.md
  - skills/aws-lambda-dotnet-implementation.md
  - skills/dotnet-10-csharp-test-design.md
  - skills/acceptance-evidence-traceability.md
  - skills/serverless-operability-checks.md
validator_skills:
  - skills/validation-disposition.md
  - skills/acceptance-evidence-traceability.md
  - skills/serverless-operability-checks.md
  - skills/dotnet-10-csharp-test-design.md
```
