---
title: "AWS Lambda Runtime Reuse and Time Budget (Node.js / TypeScript)"
type: skill
summary: "Decide what a Lambda keeps across invocations and how it spends its timeout, so warm starts stay cheap and calls cannot exhaust the budget."
tags:
  - skills
  - aws
  - lambda
  - serverless
  - performance
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - lambda configuration limits
  - downstream call profile
outputs:
  - warm-start initialization plan
  - timeout budget
---

# AWS Lambda Runtime Reuse and Time Budget (Node.js / TypeScript)

## Summary

Manage what a **Node.js / TypeScript** Lambda keeps across invocations and how it spends its configured timeout, so warm starts stay cheap and outbound calls cannot exhaust the function's time budget.

## Use When

- Deciding which clients, connections, or parsed configuration live outside the handler.
- Tuning a Lambda that suffers cold-start latency or timeout-related failures.
- Setting outbound call timeouts against the configured function timeout.

## Do Not Use When

- The concern is handler and service layout — use [aws-lambda-handler-composition.md](./aws-lambda-handler-composition.md).
- The task is auditing retries, idempotency, and observability — use [serverless-operability-checks.md](./serverless-operability-checks.md).
- The runtime is C# / .NET — use [aws-lambda-dotnet-serialization-and-reuse.md](./aws-lambda-dotnet-serialization-and-reuse.md).

## Inputs

- Required:
  - configured timeout and memory for the function
  - downstream calls the invocation performs
- Optional:
  - concurrency and provisioned concurrency settings
  - observed cold-start and duration metrics

## Method

1. Hold expensive objects (SDK clients, connection pools, parsed configuration) in module scope so warm invocations reuse them.
2. Construct that module-scope state through a single idempotent initializer. Do not rely on top-level side effects with hidden ordering.
3. Keep only safe state across invocations. Never cache request-scoped data, credentials of a specific caller, or mutable buffers that could leak between invocations.
4. Budget invocation time explicitly: sum expected downstream latency and keep it below the configured timeout with headroom for retries.
5. Set each outbound client timeout shorter than the function timeout so the function can fail cleanly and emit diagnostics instead of being killed.
6. Move heavy one-time work (schema compilation, credential resolution) into initialization rather than the invocation path.

## Quality Bar

- No SDK client or pool is constructed inside the handler body.
- Nothing request-scoped or caller-specific is held in module scope.
- Every outbound timeout is strictly shorter than the function timeout, with headroom stated.
- Initialization is idempotent and does not depend on module import order.

## Failure Modes

- Constructing SDK clients inside the handler body on every invocation.
- Caching per-request data in module scope, leaking it into the next invocation.
- Leaving default SDK timeouts that exceed the Lambda timeout, producing opaque timeouts with no logs.

## Related

- [aws-lambda-handler-composition.md](./aws-lambda-handler-composition.md) — handler and service layout.
- [serverless-operability-checks.md](./serverless-operability-checks.md) — retries, idempotency, and observability.
- [performance-review.md](./performance-review.md) — judging the resulting cost at scale.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Reused state must never carry caller-specific data across invocations.
