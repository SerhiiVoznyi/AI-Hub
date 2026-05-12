---
title: "AWS Lambda Implementation"
type: skill
tags:
  - skills
  - aws
  - lambda
  - serverless
  - execution
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - approved work package
  - lambda trigger and event contract
  - downstream integration boundaries
outputs:
  - thin handler adapter
  - service class implementation
  - lambda-safe runtime behavior
related:
  - ../skills/README.md
  - ../skills/aws-lambda-change-planning.md
  - ../skills/serverless-operability-checks.md
  - ../skills/typescript-design.md
  - ../skills/nodejs-backend-implementation.md
  - ../skills/typescript-jest-test-design.md
  - ../knowledge/safety-policy.md
---

# Summary

Implement AWS Lambda execution discipline so the framework-mandated handler is a thin adapter and the real behavior lives in an injected service class with explicit contracts, IAM, and runtime safety.

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
5. Make every operation idempotent or guarded by an idempotency key. Document the chosen mechanism in code comments only when intent is non-obvious.
6. Budget time against the configured timeout. Apply explicit timeouts to every outbound call; never rely on SDK defaults.
7. Emit structured logs with stable field names and correlation identifiers. Never log secrets, full payloads with PII, or raw credentials. Redact at the logger seam.
8. Declare required IAM actions and environment variables next to the implementation so they can be reviewed alongside code changes. Follow least privilege; no wildcard resources unless flagged as a named risk.

## Lambda Composition Pattern

- `handler.ts`: exports the function the runtime calls. It performs no business logic.
- `service.ts`: exports a class that implements the feature behind an interface. Constructor takes all dependencies.
- `composition.ts`: builds the service instance with concrete adapters. The handler imports from here.
- `adapters/`: classes that wrap AWS SDK clients behind interfaces the service depends on. Mocking happens at these seams in tests.

## Failure Modes

- Putting business logic, validation, and SDK calls directly into the exported `handler`, making the function impossible to unit-test without invoking AWS.
- Constructing SDK clients inside the handler body on every invocation, eliminating warm-start benefits and complicating instrumentation.
- Logging full event payloads that may contain secrets, customer identifiers, or production data.
- Calling production AWS resources from tests, or relying on the default region or profile.
- Use `aws-lambda-change-planning.md` instead when the task is sequencing the work and naming risks before implementation begins.
- Use `serverless-operability-checks.md` instead when the task is auditing operability rather than implementing the change.
