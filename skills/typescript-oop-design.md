---
title: "TypeScript OOP Design"
type: skill
summary: "Structure TypeScript features as classes behind explicit interfaces with constructor-injected dependencies."
tags:
  - skills
  - typescript
  - design
  - oop
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - approved work package
  - module or feature scope
outputs:
  - class-based feature surface
  - interface boundaries
---

# TypeScript OOP Design

## Summary

Structure TypeScript features as classes behind explicit interfaces with constructor-injected dependencies, so state and collaborators are visible instead of hidden in module scope.

## Use When

- Choosing the shape of a new TypeScript module, service, repository, or adapter.
- Deciding whether behavior belongs in a class, an interface, or a small helper function.
- Reviewing TypeScript code that exports free functions as its primary public surface.

## Do Not Use When

- The task is typing, narrowing, or error modeling — use [typescript-boundary-typing.md](./typescript-boundary-typing.md).
- The task is wiring concrete instances together at startup — use [nodejs-composition-root.md](./nodejs-composition-root.md).
- The code is a UI component — use [frontend-component-design.md](./frontend-component-design.md).

## Inputs

- Required:
  - approved objective and module scope
  - module or feature boundary the new code sits behind
- Optional:
  - existing codebase conventions
  - prior validation findings or rework instructions

## Method

1. Define the boundary as an interface first. The public surface of a feature is the interface, not its implementation.
2. Implement the interface as a class with constructor-injected dependencies. Do not use module-level singletons, global state, or top-level side effects.
3. Give each class one responsibility and one consistent set of invariants. Methods on a class share that state; unrelated behavior belongs in another class.
4. Compose by holding other classes as injected fields, not by chaining free functions. Avoid currying and point-free style as the primary composition pattern.
5. Keep pure helpers small, stateless, and module-internal. Do not export them as the feature's public surface.
6. Adapt framework-mandated function shapes (Lambda handler export, Express middleware) as thin wrappers that immediately delegate to a class.

## Quality Bar

- Every exported feature surface is an interface, with its implementation hidden behind it.
- No class constructs its own dependencies, and no module runs side effects on import.
- Each class's methods share one state and one responsibility.
- Framework-shaped functions contain adaptation only, with no behavior of their own.

## Exceptions

- Tiny stateless helpers (formatters, predicates, small mappers) may be plain functions kept module-internal.
- Type-level utilities, schema definitions, and configuration objects do not need to be wrapped in classes.

## Failure Modes

- Exporting a feature as a bag of free functions, then adding state later through hidden singletons.
- Wrapping everything in classes mechanically, including tiny pure helpers that gain nothing from a class.
- Instantiating dependencies inside business code instead of accepting them through the constructor.

## Related

- [typescript-boundary-typing.md](./typescript-boundary-typing.md) — typing the contract this structure exposes.
- [nodejs-composition-root.md](./nodejs-composition-root.md) — constructing and injecting the concrete instances.
- [dotnet-10-csharp-oop-design.md](./dotnet-10-csharp-oop-design.md) — the .NET equivalent.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
