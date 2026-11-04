---
title: "Node.js Composition Root"
type: skill
summary: "Construct and inject concrete classes in one composition root so business code depends on interfaces and imports stay side-effect free."
tags:
  - skills
  - nodejs
  - dependency-injection
  - architecture
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - approved work package
  - module or package boundary
outputs:
  - composition root
  - injected dependency graph
---

# Node.js Composition Root

## Summary

Build a single composition root where concrete Node.js classes are constructed and injected, so business code depends on interfaces and imports stay side-effect free.

## Use When

- Wiring a Node.js service, worker, CLI, or library that has more than one moving part.
- Deciding where SDK clients, repositories, loggers, and metrics are constructed.
- Removing hidden singletons or import-time side effects from an existing codebase.

## Do Not Use When

- The task is loading and validating configuration values — use [nodejs-configuration.md](./nodejs-configuration.md).
- The runtime target is Lambda and warm-start reuse matters — use [aws-lambda-handler-composition.md](./aws-lambda-handler-composition.md).
- The task is the shape of the classes themselves — use [typescript-oop-design.md](./typescript-oop-design.md).

## Inputs

- Required:
  - approved objective and ordered steps
  - module or package boundary the implementation belongs to
- Optional:
  - existing logger, metrics, or client patterns
  - downstream service contracts

## Method

1. Identify one composition root per entry point. Construct concrete classes there and inject them into one another.
2. Forbid business code from instantiating its own dependencies. If a class needs a collaborator, it takes it through the constructor.
3. Wrap I/O adapters (HTTP clients, database drivers, queue clients, file system access) in classes behind interfaces. Business code depends on the interface, not the SDK.
4. Inject logging and metrics rather than importing them globally inside business code, so they can be replaced in tests and tightened in production.
5. Keep modules side-effect free at the top level. Imports must not start servers, open connections, read files, or mutate global state.
6. Use the registered package manager and pinned versions. Do not introduce new dependencies without approval or rely on global installs.

## Quality Bar

- Exactly one composition root per entry point, and every concrete instance is built there.
- Importing any module runs no side effects.
- No business class references an SDK type directly.
- Logger, metrics, clock, and configuration all arrive through constructors.

## Failure Modes

- Top-level side effects in modules (connection pools opened on import, servers started at import time).
- Business code importing SDKs directly, which forces mocking at unstable seams in tests.
- Free-function modules that accumulate hidden state through closures, defeating dependency injection.

## Related

- [nodejs-configuration.md](./nodejs-configuration.md) — the typed configuration the root loads and injects.
- [nodejs-async-lifecycle.md](./nodejs-async-lifecycle.md) — the shutdown method the root owns.
- [aws-lambda-handler-composition.md](./aws-lambda-handler-composition.md) — the Lambda-specific arrangement.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
