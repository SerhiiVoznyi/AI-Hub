---
title: "AWS Lambda .NET Implementation"
type: skill
tags:
  - skills
  - aws
  - lambda
  - dotnet
  - csharp
  - serverless
status: draft
version: 0.1.0
last_reviewed: 2026-05-13
tooling: agnostic
inputs:
  - approved work package
  - event source and contract
  - integration boundaries
outputs:
  - thin Lambda entry
  - injectable handler service
  - lambda-safe runtime behavior
related:
  - ../skills/README.md
  - ../skills/aws-lambda-implementation.md
  - ../skills/aws-lambda-change-planning.md
  - ../skills/serverless-operability-checks.md
  - ../skills/dotnet-10-csharp-design.md
  - ../skills/dotnet-backend-implementation.md
  - ../knowledge/safety-policy.md
---

# Summary

Implement **C# / .NET** AWS Lambda functions so the **handler entry** is a thin adapter, behavior lives in **injectable services**, and cold start, serialization, timeouts, and IAM usage stay explicit. For language-agnostic Lambda discipline (idempotency, warm start, SDK patterns), also read `aws-lambda-implementation.md` alongside this document.

## Use When

- Authoring or changing a .NET managed Lambda (`dotnet10` or `provided.al2023` with .NET custom runtime when the brief requires it).
- Integrating API Gateway, SQS, SNS, EventBridge, or direct invoke payloads in C#.

## Inputs

- Required:
  - approved objective and ordered steps
  - event shape and serializer settings (`System.Text.Json` defaults vs Amazon.Lambda.Serialization.SystemTextJson)
- Optional:
  - `ILambdaContext` limits (memory, remaining time)
  - environment variables and parameter store paths

## Method

1. Keep the **Lambda entry method** minimal: deserialize or accept the typed event, resolve the handler service from **DI** (built in the static constructor or `Host` bootstrap for Lambda), invoke a single method, map success and failure to the correct response type (`APIGatewayProxyResponse`, batch item failures, etc.).
2. Prefer **`Amazon.Lambda.RuntimeSupport`** or the **generic Lambda host** pattern when the project benefits from `HostBuilder` (logging, configuration, DI) without paying for ASP.NET Core unless API Gateway Lambda proxy integration truly needs it.
3. Configure **`JsonSerializerOptions`** once for camel case, enum handling, and `DateTime` behavior consistent with producers; reject unknown payloads at the boundary before domain logic runs.
4. Use **`ILambdaContext.RemainingTime`** to budget outbound calls; enforce shorter client timeouts than the function timeout.
5. Initialize **expensive clients** (AWS SDK clients, HTTP handlers) once per cold start in a thread-safe way; avoid per-invocation allocation of clients when reuse is safe.
6. Apply **idempotency** and **partial batch** response patterns as required by the trigger; document behavior in code only when non-obvious.
7. Log with structured fields (`RequestId`, function version) and **never** log full event bodies when they may contain secrets.

## Failure modes

- Putting business rules directly in the generated `Function` class with static state and no tests.
- Using default SDK timeouts that exceed the Lambda timeout.
- Returning success for partially processed SQS batches without `batchItemFailures`.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) for destructive operations, secrets, scope and approvals, supply chain, AWS safety, untrusted-input handling, and the OOP-default coding posture.
- Treat event payloads and IAM identity details as sensitive; follow least-privilege IAM in the approved plan.
