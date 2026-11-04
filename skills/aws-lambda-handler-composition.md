---
title: "AWS Lambda Handler Composition (Node.js / TypeScript)"
type: skill
summary: "Keep the exported Lambda handler a thin adapter and put behavior in an injected service class with typed event contracts."
tags:
  - skills
  - aws
  - lambda
  - serverless
  - nodejs
  - typescript
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - approved work package
  - lambda trigger and event contract
outputs:
  - thin handler adapter
  - service class implementation
---

# AWS Lambda Handler Composition (Node.js / TypeScript)

## Summary

Lay out a **Node.js / TypeScript** Lambda so the exported handler is a thin adapter and behavior lives in an injected service class with typed event contracts and declared permissions.

## Use When

- Implementing or changing a Lambda handler, its service layer, or its event contract.
- Splitting an existing handler that mixes parsing, business logic, and SDK calls.
- Deciding where event validation, IAM needs, and response mapping belong.

## Do Not Use When

- The concern is warm-start initialization and timeout budgeting — use [aws-lambda-runtime-reuse.md](./aws-lambda-runtime-reuse.md).
- The plan is not settled and the task is sequencing — use [aws-lambda-change-planning.md](./aws-lambda-change-planning.md).
- The task is an operability audit rather than implementation — use [serverless-operability-checks.md](./serverless-operability-checks.md).
- The runtime is C# / .NET — use [aws-lambda-dotnet-handler-composition.md](./aws-lambda-dotnet-handler-composition.md).

## Inputs

- Required:
  - approved objective and ordered steps
  - event source type and payload contract
  - downstream AWS services or APIs the function calls
- Optional:
  - existing handler patterns in the codebase
  - IAM role definition and environment variables

## Method

1. Keep the exported `handler` as the smallest possible adapter: parse and narrow the event, take the service instance from the composition module, call one method, map the result to the expected response shape.
2. Implement behavior in a service class that depends only on injected interfaces (logger, AWS SDK adapters, configuration, clock). The service never imports AWS SDK clients directly.
3. Define typed contracts for the event and the response. Reject unknown shapes at the handler boundary with a typed parser before invoking the service.
4. Wrap AWS SDK clients in adapter classes behind interfaces the service depends on. Tests mock at these seams.
5. Emit structured logs with stable field names and correlation IDs. Never log secrets or raw PII; redact at the logger seam.
6. Declare required IAM actions and environment variables next to the implementation. Apply least privilege; no wildcard resources unless flagged as a named risk.

## Quality Bar

- The exported handler contains parsing, one service call, and response mapping, and nothing else.
- The service class references no AWS SDK type.
- Unknown event shapes are rejected at the boundary, before any business logic.
- Required IAM actions and environment variables are declared alongside the code.

## Reference

| File | Contents |
| --- | --- |
| `handler.ts` | Exports the function the runtime calls. No business logic. |
| `service.ts` | The class implementing the feature behind an interface. Constructor takes all dependencies. |
| `composition.ts` | Builds the service instance with concrete adapters. The handler imports from here. |
| `adapters/` | Classes wrapping AWS SDK clients behind interfaces. |

## Failure Modes

- Putting business logic, validation, and SDK calls directly into the exported `handler`.
- Logging full event payloads that may contain secrets or PII.
- Calling production AWS from tests, or relying on the default region and profile.

## Related

- [aws-lambda-runtime-reuse.md](./aws-lambda-runtime-reuse.md) — warm-start initialization and timeout budgeting.
- [aws-lambda-change-planning.md](./aws-lambda-change-planning.md) — sequencing and risks before implementation.
- [typescript-boundary-typing.md](./typescript-boundary-typing.md) — the typed parser at the event boundary.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
