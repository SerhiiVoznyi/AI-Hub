---
title: "AWS Lambda Change Planning"
type: skill
tags:
  - skills
  - aws
  - lambda
  - planning
  - serverless
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - clarified task brief
  - lambda context
  - integration boundaries
outputs:
  - ordered implementation plan
  - lambda-specific risks
  - acceptance criteria
related:
  - ../skills/README.md
  - ../agents/planner-agent.md
  - ../agents/orchestrator-agent.md
  - ./story-brief-normalization.md
  - ./serverless-operability-checks.md
---

# Summary

Plan AWS Lambda story work by turning a clear brief into ordered steps, dependencies, risks, and testable acceptance criteria.

## Use When

- The story changes a Lambda handler, event trigger, deployment configuration, or an AWS integration used by Lambda.
- The planner needs to expose hidden prerequisites such as IAM, environment variables, payload contracts, or infrastructure changes.
- Acceptance criteria must reflect serverless runtime behavior rather than only code structure.

## Inputs

- Required:
  - approved or clarified task brief
  - current Lambda entry points, triggers, and downstream dependencies
- Optional:
  - infrastructure ownership boundaries
  - event samples
  - performance, cost, or reliability constraints

## Method

1. Identify the change surface: handler logic, event schema, downstream service calls, configuration, permissions, deployment assets, and observability impact.
2. Break the work into ordered steps that respect dependencies across application code, infrastructure assumptions, and test updates.
3. Surface assumptions explicitly, especially around event sources, IAM access, environment variables, retries, and existing contracts with other services.
4. Add Lambda-specific risks such as duplicate delivery, timeout pressure, partial failure handling, schema drift, and cold-start-sensitive initialization.
5. Define acceptance criteria in terms the validator can observe: behavior on valid and invalid events, expected side effects, error handling, and evidence from tests or artifacts.
6. Return only the plan package. Do not slip into implementation details that belong to the executor.

## Failure Modes

- Planning only the code change while ignoring permissions, configuration, or event contract implications.
- Writing steps that assume the executor can change scope or redesign the solution independently.
- Using broad acceptance criteria like "works correctly" without naming behaviors and evidence.
- Use `node-typescript-backend-implementation.md` instead when the plan is approved and the task is execution rather than planning.
