---
title: "AWS Lambda Change Planning"
type: skill
summary: "Sequence Lambda work across handlers, configuration, permissions, and integrations, surfacing prerequisites before implementation starts."
tags:
  - skills
  - aws
  - lambda
  - planning
  - serverless
status: draft
version: 0.3.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - task description
  - lambda context
  - integration boundaries
outputs:
  - ordered implementation plan
  - lambda-specific risks
  - acceptance criteria
---

# AWS Lambda Change Planning

## Summary

Plan AWS Lambda work by turning a clear brief into ordered steps, dependencies, risks, and testable acceptance criteria.

## Use When

- The story changes a Lambda handler, event trigger, deployment configuration, or an AWS integration used by Lambda.
- Hidden prerequisites such as IAM, environment variables, payload contracts, or infrastructure changes must surface before work starts.
- Acceptance criteria must reflect serverless runtime behavior rather than only code structure.

## Do Not Use When

- The plan is settled and the task is the implementation — use [aws-lambda-handler-composition.md](./aws-lambda-handler-composition.md) or [aws-lambda-dotnet-handler-composition.md](./aws-lambda-dotnet-handler-composition.md).
- The runtime is Node.js but not specifically Lambda — use [nodejs-composition-root.md](./nodejs-composition-root.md).
- The work spans several roles and the concern is ownership — use [contract-first-work-breakdown.md](./contract-first-work-breakdown.md).

## Inputs

- Required:
  - the task or story to be implemented
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
5. Define acceptance criteria in observable terms: behavior on valid and invalid events, expected side effects, error handling, and evidence from tests or artifacts.
6. Return the plan and stop. Settle the sequence and the risks before writing implementation detail.

## Quality Bar

- Every part of the change surface is addressed or explicitly excluded.
- Permissions, configuration, and event-contract impacts appear as steps, not footnotes.
- Each acceptance criterion names a behavior and the evidence that would prove it.
- The plan stops at sequencing; it contains no implementation.

## Failure Modes

- Planning only the code change while ignoring permissions, configuration, or event contract implications.
- Writing steps that quietly widen scope or redesign the solution instead of planning the change that was asked for.
- Using broad acceptance criteria like "works correctly" without naming behaviors and evidence.

## Related

- [serverless-operability-checks.md](./serverless-operability-checks.md) — the operability risks this plan should carry.
- [aws-lambda-handler-composition.md](./aws-lambda-handler-composition.md) — implementing the planned change.
- [contract-first-work-breakdown.md](./contract-first-work-breakdown.md) — splitting the plan across roles.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- IAM and infrastructure steps are proposals requiring confirmation, never assumed approvals.
