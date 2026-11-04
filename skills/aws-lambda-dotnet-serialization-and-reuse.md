---
title: "AWS Lambda .NET Serialization and Reuse"
type: skill
summary: "Configure the serializer once, reuse expensive clients across invocations, and budget calls against the remaining time."
tags:
  - skills
  - aws
  - lambda
  - dotnet
  - serialization
  - performance
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - event payload contract
  - lambda configuration limits
outputs:
  - consistent serializer configuration
  - cold-start reuse and time budget
---

# AWS Lambda .NET Serialization and Reuse

## Summary

Configure **C# / .NET** Lambda serialization once and reuse expensive clients across invocations, budgeting outbound calls against `ILambdaContext.RemainingTime` so payload drift and timeouts fail visibly.

## Use When

- Choosing or changing serializer settings for a .NET Lambda event or response.
- Tuning a .NET Lambda for cold-start cost or timeout-related failures.
- Diagnosing payload mismatches between a producer and a .NET consumer.

## Do Not Use When

- The concern is entry-point layout and DI bootstrap — use [aws-lambda-dotnet-handler-composition.md](./aws-lambda-dotnet-handler-composition.md).
- The runtime is Node.js / TypeScript — use [aws-lambda-runtime-reuse.md](./aws-lambda-runtime-reuse.md).

## Inputs

- Required:
  - event payload contract and the producer's casing and date conventions
  - configured timeout and memory for the function
- Optional:
  - existing serializer registration (`Amazon.Lambda.Serialization.SystemTextJson`)
  - observed cold-start and duration metrics

## Method

1. Configure `JsonSerializerOptions` once for camel case, enum handling, and `DateTime` behavior consistent with producers; register the serializer at the assembly or host level rather than per handler.
2. Reject unknown or malformed payloads at the boundary before domain logic runs, surfacing a typed failure instead of a partially populated object.
3. Initialize expensive clients (AWS SDK clients, HTTP handlers) once per cold start in a thread-safe way; avoid per-invocation allocation when reuse is safe.
4. Keep reused state free of request-scoped data so nothing leaks between invocations.
5. Use `ILambdaContext.RemainingTime` to budget outbound calls and enforce client timeouts shorter than the function timeout.
6. Move heavy one-time work (serializer setup, credential resolution, warm-up queries) into initialization rather than the invocation path.

## Quality Bar

- Serializer options are declared once and match the producer's conventions.
- A malformed payload produces a typed failure, never a partially populated object.
- No static field holds request-scoped or caller-specific data.
- Every client timeout is shorter than the function timeout, and the budget is stated.

## Failure Modes

- Using default SDK timeouts that exceed the Lambda timeout, producing opaque failures.
- Serializer settings that differ from the producer's casing, silently yielding null properties.
- Caching per-request data in static fields, leaking it into the next invocation.

## Related

- [aws-lambda-dotnet-handler-composition.md](./aws-lambda-dotnet-handler-composition.md) — entry-point layout and DI bootstrap.
- [dotnet-10-csharp-nullability-and-async.md](./dotnet-10-csharp-nullability-and-async.md) — validating payloads into strong types.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Reused static state must never carry caller-specific data across invocations.
