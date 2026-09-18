---
title: "TypeScript Boundary Typing"
type: skill
tags:
  - skills
  - typescript
  - typing
  - contracts
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: agnostic
inputs:
  - module or feature scope
  - external contract definitions
outputs:
  - explicit boundary contracts
  - typed error model
---

# Summary

Type TypeScript boundaries so external data is narrowed before it travels inward, alternative states are unrepresentable when invalid, and failures carry typed meaning.

## Use When

- Defining the input and output contract of a module, endpoint, event, or adapter.
- Deciding how to represent alternative states, optional data, or domain failures.
- Setting or reviewing compiler strictness for a TypeScript package.

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

## Failure Modes

- Using `any` or untyped `Record<string, unknown>` as the boundary contract, deferring validation to far-away callers.
- Using booleans for state combinations that should be a discriminated union.
- Weakening compiler strictness to make new code compile.
- Use `typescript-oop-design.md` instead when the task is class and interface structure rather than the type contract.
- Use `aws-lambda-handler-composition.md` when the boundary is a Lambda event and the question is where parsing belongs.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
