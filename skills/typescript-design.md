---
title: "TypeScript Design"
type: skill
tags:
  - skills
  - typescript
  - design
  - oop
  - language
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - approved work package
  - module or feature scope
  - integration boundaries
outputs:
  - typed module structure
  - class-based feature surface
  - explicit boundary contracts
related:
  - ../skills/README.md
  - ../skills/nodejs-backend-implementation.md
  - ../skills/aws-lambda-implementation.md
  - ../skills/typescript-jest-test-design.md
  - ../knowledge/safety-policy.md
---

# Summary

Apply strict, object-oriented TypeScript design so feature surfaces are typed at boundaries, dependencies are explicit, and state lives in cohesive classes rather than scattered free functions.

## Use When

- Writing or reviewing TypeScript code regardless of runtime (Node.js, browser, Lambda).
- Choosing the shape of a new module, service, repository, or adapter.
- Deciding whether something belongs in a class, an interface, or a small helper function.

## Inputs

- Required:
  - approved objective and module scope
  - module or feature boundary that the new code will sit behind
- Optional:
  - existing codebase conventions
  - external contract definitions (events, requests, schemas)
  - prior validation findings or rework instructions

## Method

1. Define the boundary as an interface first. The public surface of a feature is the interface, not its implementation.
2. Implement the interface as a class with constructor-injected dependencies. Do not reach for module-level singletons, global state, or top-level side effects.
3. Type all inputs and outputs explicitly. Treat external data as `unknown` and narrow it at the boundary with a typed parser before passing it deeper.
4. Model alternative states with discriminated unions instead of boolean flags or loose objects. Make impossible states unrepresentable.
5. Define error types as classes that extend `Error`. Throw or return them explicitly; never reuse generic `Error` for domain failures.
6. Keep pure helpers small, stateless, and module-internal. Do not export free functions as the primary public surface of a feature.

## Object-Oriented Default

Object-oriented design is the default style. Concrete rules:

- Default unit of organization is a class behind an explicit interface at module boundaries.
- Stateful behavior, lifecycle, integrations, services, repositories, handlers, and adapters are classes.
- Dependencies are injected through the constructor. Resolve them at the composition root, not inside business code.
- Methods are cohesive: one class owns one responsibility and one consistent set of invariants.
- Composition is via classes that hold other classes, not via free-function pipelines.
- Avoid currying and point-free style as the primary composition pattern. Prefer named methods on cohesive classes.

Allowed exceptions, narrow and explicit:

- Tiny stateless helpers (formatters, predicates, small mappers) may be plain functions kept module-internal.
- Type-level utilities, schema definitions, and configuration objects do not need to be wrapped in classes.
- Framework-mandated function shapes (for example a Lambda handler export, an Express middleware) stay as functions but immediately delegate to a class. The function is a thin adapter; the behavior lives in the class.

## TypeScript Configuration Posture

- Use `strict: true`. Do not weaken it for new code.
- Disallow `any`. Prefer `unknown` plus narrowing. If `any` is unavoidable in third-party gluing code, isolate it behind a typed adapter class.
- Enable `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`, and `noImplicitOverride` for new packages where feasible.
- Prefer `readonly` for fields and array-shaped data that should not mutate after construction.

## Failure Modes

- Exporting a feature as a bag of free functions, then later trying to add state or dependencies and ending up with hidden singletons.
- Using `any` or untyped `Record<string, unknown>` as the boundary contract, which defers all validation to far-away callers.
- Using booleans for state combinations that should be a discriminated union.
- Wrapping everything in classes mechanically, including tiny pure helpers that gain nothing from a class.
- Use `nodejs-backend-implementation.md` instead when the task is Node runtime concerns (process lifecycle, async patterns, configuration loading) rather than language-level design.
- Use `aws-lambda-implementation.md` instead when the task is the Lambda-specific handler-and-service composition pattern.
