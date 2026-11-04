---
title: "Node.js Async and Lifecycle"
type: skill
summary: "Handle rejections, timeouts, and shutdown explicitly so failures are observed and in-flight work drains instead of being lost."
tags:
  - skills
  - nodejs
  - async
  - lifecycle
  - runtime
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - approved work package
  - process or worker surface
outputs:
  - rejection-safe async paths
  - explicit shutdown behavior
---

# Node.js Async and Lifecycle

## Summary

Handle Node.js async execution, error propagation, timeouts, and process shutdown explicitly so failures are observed and in-flight work drains instead of being lost.

## Use When

- Adding background tasks, event handlers, or long-running work to a Node.js process.
- Reviewing async code for floating promises, swallowed rejections, or missing timeouts.
- Implementing graceful shutdown for a service or worker.

## Do Not Use When

- The runtime is Lambda and the concern is invocation time budget and warm-start state — use [aws-lambda-runtime-reuse.md](./aws-lambda-runtime-reuse.md).
- The concern is retries and idempotency across a serverless system — use [serverless-operability-checks.md](./serverless-operability-checks.md).

## Inputs

- Required:
  - approved objective and ordered steps
  - the process surface (server, worker, CLI) and its expected lifetime
- Optional:
  - upstream client timeout defaults
  - deployment stop-grace configuration

## Method

1. Express async behavior with `async`/`await`. Never leave a floating promise that can crash the process unobserved.
2. Handle rejections at every entry point, especially event handlers and background tasks that are not awaited by a caller.
3. Treat errors as values where they cross boundaries. Wrap unknown thrown values into typed error classes at the seam.
4. Apply explicit timeouts to every outbound call. Do not rely on the default behavior of an upstream client.
5. Handle `SIGINT` and `SIGTERM` for long-running processes. Drain in-flight work and close resources through an explicit shutdown method on the composition root.
6. Make shutdown idempotent and bounded so a second signal or a slow drain cannot hang the process indefinitely.

## Quality Bar

- No promise is created without an owner that observes its rejection.
- Every outbound call has an explicit timeout.
- Shutdown drains in-flight work, closes resources, and is safe to call twice.
- No catch block continues when the operation's result was required.

## Failure Modes

- Floating promises and swallowed rejections in event handlers and background tasks.
- Catch blocks that log and continue when the operation's result was required.
- Processes that exit immediately on signal, dropping in-flight work and leaving connections open.

## Related

- [nodejs-composition-root.md](./nodejs-composition-root.md) — the shutdown method's home.
- [aws-lambda-runtime-reuse.md](./aws-lambda-runtime-reuse.md) — time budgeting inside an invocation.
- [typescript-boundary-typing.md](./typescript-boundary-typing.md) — the typed error classes used at seams.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
