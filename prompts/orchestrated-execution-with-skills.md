---
title: "Orchestrated execution with task skills manifest"
type: prompt
tags:
  - prompts
  - multi-agent
  - orchestration
  - skills
status: draft
version: 0.1.0
last_reviewed: 2026-05-13
tooling: agnostic
inputs:
  - user objective
  - task skills manifest
outputs:
  - bounded multi-agent run with explicit skill binding
related:
  - ../agents/orchestrator-agent.md
  - ../agents/README.md
  - ../skills/README.md
  - ../knowledge/safety-policy.md
---

# Summary

Kick off the planner, executor, and validator flow through the orchestrator while binding skills **only** from a per-role manifest. Paths are repository-root relative (for example `skills/foo.md`).

## Use When

- You want the four-agent orchestrated pattern with explicit control over which skills each role loads.
- The stack or test tooling varies by task and must not be hardcoded inside agent definitions.

## Prompt

```text
You are running the AI-Hub orchestrated multi-agent pattern. Load and follow these agent definitions from the repository root:

- agents/orchestrator-agent.md
- agents/planner-agent.md
- agents/executor-agent.md
- agents/validator-agent.md

Operational guardrails: knowledge/safety-policy.md

## User objective

{{USER_OBJECTIVE}}

## Task skills manifest

The manifest below is authoritative for this run. Resolve each path from the repository root, read the file, and apply it only for the role(s) listed.

Paths use the form skills/... or knowledge/....

The manifest must contain all four keys: orchestrator_skills, planner_skills, executor_skills, validator_skills. Each value is a list of paths.

orchestrator_skills:
  - skills/story-brief-normalization.md
planner_skills:
  - skills/aws-lambda-change-planning.md
executor_skills:
  - skills/typescript-design.md
validator_skills:
  - skills/validation-disposition.md

Replace the lists with the correct skills for this task before execution. Do not add skills to a role unless the user approves a manifest change.

## Execution rules

1. The orchestrator receives the user objective and the full manifest (all four keys). It applies only orchestrator_skills itself.
2. On every handoff to the planner, executor, or validator, the orchestrator re-attaches the full manifest unchanged, together with the role-specific payload (task brief, work package, or validation inputs).
3. The planner applies only documents listed under planner_skills. The executor applies only executor_skills. The validator applies only validator_skills.
4. If planner_skills, executor_skills, or validator_skills is missing or empty for that role, the specialist returns a clarification request or blocker to the orchestrator instead of guessing technology or methodology skills.
5. Specialists must not load or follow skills assigned to a different role unless the orchestrator explicitly updates the manifest after user approval.
6. Begin with the orchestrator role: normalize the request using orchestrator_skills, then proceed through planner, executor, and validator as defined in the agent files.
```

## Notes

- Replace `{{USER_OBJECTIVE}}` with the concrete goal, scope, and constraints.
- Duplicate entries across roles are allowed when the same skill should guide multiple phases (for example acceptance traceability on both executor and validator).
- `knowledge/safety-policy.md` always applies; listing it under a role is optional but may be used when you want an explicit reminder in the manifest.

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
