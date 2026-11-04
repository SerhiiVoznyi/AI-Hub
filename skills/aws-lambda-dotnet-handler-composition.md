---
title: "AWS Lambda .NET Handler Composition"
type: skill
summary: "Keep the .NET Lambda entry a thin adapter over a DI-resolved service, with response mapping the trigger expects."
tags:
  - skills
  - aws
  - lambda
  - dotnet
  - csharp
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - approved work package
  - event source and contract
outputs:
  - thin Lambda entry
  - injectable handler service
---

# AWS Lambda .NET Handler Composition

## Summary

Lay out a **C# / .NET** Lambda so the entry method is a thin adapter over a DI-resolved handler service, with response mapping that matches what the trigger expects.

## Use When

- Authoring or changing a .NET managed Lambda (`dotnet10`, or `provided.al2023` with a .NET custom runtime when the brief requires it).
- Integrating API Gateway, SQS, SNS, EventBridge, or direct invoke payloads in C#.
- Splitting a generated `Function` class that holds business logic and static state.

## Do Not Use When

- The concern is JSON options, client reuse, and time budgets — use [aws-lambda-dotnet-serialization-and-reuse.md](./aws-lambda-dotnet-serialization-and-reuse.md).
- The task is an operability audit rather than implementation — use [serverless-operability-checks.md](./serverless-operability-checks.md).
- The runtime is Node.js / TypeScript — use [aws-lambda-handler-composition.md](./aws-lambda-handler-composition.md).

## Inputs

- Required:
  - approved objective and ordered steps
  - event shape and the response type the trigger expects
- Optional:
  - environment variables and parameter store paths
  - existing host bootstrap patterns in the solution

## Method

1. Keep the Lambda entry method minimal: accept the typed event, resolve the handler service from DI, invoke a single method, map success and failure to the correct response type (`APIGatewayProxyResponse`, batch item failures, and so on).
2. Implement behavior in an injectable service class that depends on interfaces, so it can be tested without the Lambda runtime.
3. Build the DI container once during bootstrap (static constructor or `Host` builder), not per invocation.
4. Prefer `Amazon.Lambda.RuntimeSupport` or the generic Lambda host pattern when the project benefits from `HostBuilder` (logging, configuration, DI); add ASP.NET Core only when API Gateway proxy integration truly needs it.
5. Apply idempotency and partial batch response patterns as the trigger requires; return `batchItemFailures` rather than reporting whole-batch success.
6. Log with structured fields (`RequestId`, function version) and never log full event bodies that may contain secrets.

## Quality Bar

- The entry method resolves, invokes, and maps — nothing else.
- The handler service is testable without the Lambda runtime.
- The container is built once per cold start, never per invocation.
- Batch triggers return per-item failures rather than whole-batch success.

## Failure Modes

- Putting business rules directly in the generated `Function` class with static state and no tests.
- Returning success for partially processed SQS batches without `batchItemFailures`.
- Building the service provider inside the handler on every invocation.

## Related

- [aws-lambda-dotnet-serialization-and-reuse.md](./aws-lambda-dotnet-serialization-and-reuse.md) — serializer options, reuse, and time budget.
- [dotnet-composition-and-di.md](./dotnet-composition-and-di.md) — the registration patterns the bootstrap follows.
- [serverless-operability-checks.md](./serverless-operability-checks.md) — the operability audit.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Treat event payloads and IAM identity details as sensitive; follow least-privilege IAM in the approved plan.
