---
title: "AWS Lambda Handler Composition (Node.js / TypeScript)"
type: skill
tags:
  - skills
  - aws
  - lambda
  - serverless
  - nodejs
  - typescript
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: tool-assisted
inputs:
  - approved work package
  - lambda trigger and event contract
outputs:
  - thin handler adapter
  - service class implementation
---

# Summary

Lay out a **Node.js / TypeScript** Lambda so the exported handler is a thin adapter and behavior lives in an injected service class with typed event contracts and declared permissions.

## Use When

- Implementing or changing a Lambda handler, its service layer, or its event contract.
- Splitting an existing handler that mixes parsing, business logic, and SDK calls.
- Deciding where event validation, IAM needs, and response mapping belong.

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

## File Layout

- `handler.ts`: exports the function the runtime calls. No business logic.
- `service.ts`: the class implementing the feature behind an interface. Constructor takes all dependencies.
- `composition.ts`: builds the service instance with concrete adapters. The handler imports from here.
- `adapters/`: classes wrapping AWS SDK clients behind interfaces.

## Failure Modes

- Putting business logic, validation, and SDK calls directly into the exported `handler`.
- Logging full event payloads that may contain secrets or PII.
- Calling production AWS from tests, or relying on the default region and profile.
- Use `aws-lambda-runtime-reuse.md` for warm-start client initialization and timeout budgeting.
- Use `aws-lambda-change-planning.md` for sequencing and risks before implementation.
- Use `serverless-operability-checks.md` for the operability audit rather than implementation.
- Use `aws-lambda-dotnet-handler-composition.md` for C# / .NET Lambdas.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
