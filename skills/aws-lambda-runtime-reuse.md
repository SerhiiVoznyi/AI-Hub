---
title: "AWS Lambda Runtime Reuse and Time Budget (Node.js / TypeScript)"
type: skill
tags:
  - skills
  - aws
  - lambda
  - serverless
  - performance
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: tool-assisted
inputs:
  - lambda configuration limits
  - downstream call profile
outputs:
  - warm-start initialization plan
  - timeout budget
---

# Summary

Manage what a **Node.js / TypeScript** Lambda keeps across invocations and how it spends its configured timeout, so warm starts stay cheap and outbound calls cannot exhaust the function's time budget.

## Use When

- Deciding which clients, connections, or parsed configuration live outside the handler.
- Tuning a Lambda that suffers cold-start latency or timeout-related failures.
- Setting outbound call timeouts against the configured function timeout.

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

## Failure Modes

- Constructing SDK clients inside the handler body on every invocation.
- Caching per-request data in module scope, leaking it into the next invocation.
- Leaving default SDK timeouts that exceed the Lambda timeout, producing opaque timeouts with no logs.
- Use `aws-lambda-handler-composition.md` for the handler and service layout.
- Use `serverless-operability-checks.md` when the task is auditing retries, idempotency, and observability.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
- Reused state must never carry caller-specific data across invocations.
