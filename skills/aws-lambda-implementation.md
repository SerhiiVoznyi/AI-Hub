---
title: "AWS Lambda Implementation (Node.js / TypeScript)"
type: skill
tags:
  - skills
  - aws
  - lambda
  - serverless
  - nodejs
  - typescript
  - execution
status: draft
version: 0.2.0
last_reviewed: 2026-08-01
tooling: tool-assisted
inputs:
  - approved work package
  - lambda trigger and event contract
  - downstream integration boundaries
outputs:
  - thin handler adapter
  - service class implementation
  - lambda-safe runtime behavior
---

# Summary

Implement **Node.js / TypeScript** AWS Lambda functions so the framework-mandated handler is a thin adapter and behavior lives in an injected service class with explicit contracts, IAM, and runtime safety. For production checklist items (retries, idempotency, timeouts, observability), apply `serverless-operability-checks.md` when it is on the manifest—do not restate that checklist here. For **.NET** Lambdas use `aws-lambda-dotnet-implementation.md` instead.


## Use When

- Implementing or changing a Lambda function handler, its service layer, or its event contract.
- Wiring AWS SDK clients, configuration, and observability inside a Lambda.
- Hardening a Lambda for idempotency, timeouts, retries, or structured logging.

## Inputs

- Required:
  - approved objective and ordered steps from the planner
  - event source type and payload contract
  - downstream AWS services or APIs the function will call
- Optional:
  - existing handler patterns in the codebase
  - IAM role definition and environment variables
  - timeout, memory, and concurrency configuration

## Method

1. Keep the exported `handler` function as the smallest possible adapter. It parses and narrows the event, constructs or reuses the service instance from the composition root, calls a single method, and translates the result back to the expected response shape.
2. Implement the behavior in a service class that depends only on injected interfaces (logger, AWS SDK adapters, configuration, clock). The service class never imports AWS SDK clients directly.
3. Hold expensive clients (SDK clients, connection pools, parsed config) in module scope outside the handler to benefit from warm starts, but construct them through a single, idempotent initializer; never via top-level side effects with hidden ordering.
4. Define typed contracts for the event and the response. Reject unknown shapes at the handler boundary with a typed parser before invoking the service class.
5. Make every operation idempotent or guarded by an idempotency key when the trigger requires it (see `serverless-operability-checks.md` for the audit checklist).
6. Budget time against the configured timeout; apply explicit timeouts to outbound calls.
7. Emit structured logs with stable field names and correlation IDs. Never log secrets or raw PII; redact at the logger seam.
8. Declare required IAM actions and environment variables next to the implementation. Least privilege; no wildcard resources unless flagged as a named risk.

## Lambda Composition Pattern

- `handler.ts`: exports the function the runtime calls. It performs no business logic.
- `service.ts`: exports a class that implements the feature behind an interface. Constructor takes all dependencies.
- `composition.ts`: builds the service instance with concrete adapters. The handler imports from here.
- `adapters/`: classes that wrap AWS SDK clients behind interfaces the service depends on. Mocking happens at these seams in tests.

## Failure Modes

- Putting business logic, validation, and SDK calls directly into the exported `handler`.
- Constructing SDK clients inside the handler body on every invocation.
- Logging full event payloads that may contain secrets or PII.
- Calling production AWS from tests, or relying on the default region/profile.
- Use `aws-lambda-change-planning.md` for sequencing/risks before implementation.
- Use `serverless-operability-checks.md` for operability audit rather than implementation.
- Use `aws-lambda-dotnet-implementation.md` for C# / .NET Lambdas.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
