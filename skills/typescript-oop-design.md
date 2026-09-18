---
title: "TypeScript OOP Design"
type: skill
tags:
  - skills
  - typescript
  - design
  - oop
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: agnostic
inputs:
  - approved work package
  - module or feature scope
outputs:
  - class-based feature surface
  - interface boundaries
---

# Summary

Structure TypeScript features as classes behind explicit interfaces with constructor-injected dependencies, so state and collaborators are visible instead of hidden in module scope.

## Use When

- Choosing the shape of a new TypeScript module, service, repository, or adapter.
- Deciding whether behavior belongs in a class, an interface, or a small helper function.
- Reviewing TypeScript code that exports free functions as its primary public surface.

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

## Allowed Exceptions

- Tiny stateless helpers (formatters, predicates, small mappers) may be plain functions kept module-internal.
- Type-level utilities, schema definitions, and configuration objects do not need to be wrapped in classes.

## Failure Modes

- Exporting a feature as a bag of free functions, then adding state later through hidden singletons.
- Wrapping everything in classes mechanically, including tiny pure helpers that gain nothing from a class.
- Instantiating dependencies inside business code instead of accepting them through the constructor.
- Use `typescript-boundary-typing.md` instead when the task is typing, narrowing, or error modeling rather than object structure.
- Use `nodejs-composition-root.md` instead when the task is wiring concrete instances together at startup.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
