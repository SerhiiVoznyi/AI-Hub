---
title: "TypeScript Boundary Typing"
type: skill
summary: "Narrow external data at the boundary, make invalid states unrepresentable, and give failures typed meaning."
tags:
  - skills
  - typescript
  - typing
  - contracts
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - module or feature scope
  - external contract definitions
outputs:
  - explicit boundary contracts
  - typed error model
---

# TypeScript Boundary Typing

## Summary

Type TypeScript boundaries so external data is narrowed before it travels inward, alternative states are unrepresentable when invalid, and failures carry typed meaning.

## Use When

- Defining the input and output contract of a module, endpoint, event, or adapter.
- Deciding how to represent alternative states, optional data, or domain failures.
- Setting or reviewing compiler strictness for a TypeScript package.

## Do Not Use When

- The task is class and interface structure rather than the type contract — use [typescript-oop-design.md](./typescript-oop-design.md).
- The boundary is a Lambda event and the question is where parsing belongs — use [aws-lambda-handler-composition.md](./aws-lambda-handler-composition.md).
- The boundary is a UI's call to its backend — use [frontend-api-client-seam.md](./frontend-api-client-seam.md).

## Inputs

- Required:
  - the boundary being typed (event, request, schema, or public method signature)
- Optional:
  - external contract definitions from producers or consumers
  - existing error types and parsing conventions

## Method

1. Type all inputs and outputs explicitly. Do not rely on inference for exported signatures.
2. Treat external data as `unknown` and narrow it at the boundary with a typed parser before passing it deeper. Never let unvalidated shapes reach domain code.
3. Model alternative states with discriminated unions instead of boolean flags or loose objects. Make impossible states unrepresentable.
4. Define domain errors as classes that extend `Error`. Throw or return them explicitly; never reuse generic `Error` for domain failures.
5. Use `readonly` for fields and array-shaped data that should not mutate after construction.
6. Keep `strict: true`. Enable `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`, and `noImplicitOverride` for new packages.
7. Disallow `any`. Prefer `unknown` plus narrowing; when third-party gluing code forces `any`, isolate it behind a typed adapter.

## Quality Bar

- No external value reaches domain code without passing a typed parser.
- Every exported signature is explicitly typed, with no `any` outside an isolated adapter.
- Alternative states are discriminated unions, not flag combinations.
- Domain failures are distinguishable by type, not by message text.

## Failure Modes

- Using `any` or untyped `Record<string, unknown>` as the boundary contract, deferring validation to far-away callers.
- Using booleans for state combinations that should be a discriminated union.
- Weakening compiler strictness to make new code compile.

## Related

- [typescript-oop-design.md](./typescript-oop-design.md) — the class structure behind the contract.
- [aws-lambda-handler-composition.md](./aws-lambda-handler-composition.md) — where event parsing belongs in a Lambda.
- [dotnet-10-csharp-nullability-and-async.md](./dotnet-10-csharp-nullability-and-async.md) — the .NET counterpart.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Boundary narrowing is where the untrusted-input clauses are enforced in code.
