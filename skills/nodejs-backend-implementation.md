---
title: "Node.js Backend Implementation"
type: skill
tags:
  - skills
  - nodejs
  - backend
  - runtime
  - execution
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - approved work package
  - codebase conventions
  - integration boundaries
outputs:
  - module and package layout
  - composition root
  - runtime-safe implementation
related:
  - ../skills/README.md
  - ../skills/typescript-design.md
  - ../skills/aws-lambda-implementation.md
  - ../skills/typescript-jest-test-design.md
  - ../agents/executor-agent.md
  - ../knowledge/safety-policy.md
---

# Summary

Implement Node.js backend work with a clear composition root, class-based dependency injection, and runtime-safe handling of async, lifecycle, and configuration concerns. Language-level design rules come from `typescript-design.md`; this skill covers the runtime.

## Use When

- Building or changing a Node.js backend service, worker, CLI, or library that runs under Node.
- Wiring dependencies, configuration, and lifecycle for a feature that has more than one moving part.
- Choosing where async, error handling, and process-level concerns belong.

## Inputs

- Required:
  - approved objective and ordered steps
  - target Node runtime version and package manager
  - module or package boundary the implementation belongs to
- Optional:
  - existing logger, metrics, or configuration patterns
  - downstream service contracts
  - prior validation findings or rework instructions

## Method

1. Identify the composition root. Construct concrete classes there and inject them into one another; do not let business code instantiate its own dependencies.
2. Place configuration behind a typed `Config` class loaded once at the composition root. Validate the shape at load time and fail fast on missing or malformed values.
3. Keep modules side-effect free at the top level. Imports must not start servers, open connections, read files, or mutate global state.
4. Express async behavior with `async`/`await`. Always handle rejections; never leave a floating promise that can crash the process unobserved.
5. Treat errors as values where they cross boundaries. Wrap unknown thrown values into typed error classes at the seam.
6. Handle process signals (`SIGINT`, `SIGTERM`) for long-running processes. Drain in-flight work and close resources via an explicit shutdown method on the composition root.
7. Use the registered package manager and pinned versions. Do not introduce new dependencies without approval; do not rely on global installs.

## Runtime Boundaries

- I/O adapters (HTTP clients, database drivers, queue clients, file system access) are classes behind interfaces. Business code depends on the interface, not on the SDK.
- Logging and metrics are injected, not imported globally inside business code, so they can be replaced in tests and tightened in production.
- Long-running operations have explicit timeouts. Do not rely on the default behavior of an upstream client.

## Failure Modes

- Top-level side effects in modules (connection pools opened on import, servers started in a constructor at import time).
- Business code that imports SDKs directly, making it untestable without network mocks at unstable seams.
- Free-function modules that accumulate hidden state through closures, which then defeats dependency injection.
- Floating promises and swallowed rejections, especially in event handlers and background tasks.
- Use `typescript-design.md` instead when the task is language-level (types, classes, error modeling) rather than runtime-level.
- Use `aws-lambda-implementation.md` instead when the runtime target is AWS Lambda and the handler-plus-service pattern applies.
