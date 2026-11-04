---
title: ".NET 10 C# OOP Design"
type: skill
summary: "Structure C# features as classes behind interfaces with constructor injection, choosing records or classes by value semantics or identity."
tags:
  - skills
  - dotnet
  - csharp
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
  - feature or module scope
outputs:
  - interface-backed class structure
  - DI-friendly types
---

# .NET 10 C# OOP Design

## Summary

Structure **.NET 10** C# features as classes behind explicit interfaces with constructor-injected collaborators, choosing records and classes by whether the type carries value semantics or identity.

## Use When

- Authoring or reviewing C# types for class libraries, ASP.NET Core, workers, or Lambda projects on .NET 10.
- Choosing between records and classes, or deciding where an interface boundary belongs.
- Removing static service locators and ambient context from existing code.

## Do Not Use When

- The task is nullability, async, or failure modeling — use [dotnet-10-csharp-nullability-and-async.md](./dotnet-10-csharp-nullability-and-async.md).
- The task is where registrations and wiring live — use [dotnet-composition-and-di.md](./dotnet-composition-and-di.md).
- The runtime is TypeScript — use [typescript-oop-design.md](./typescript-oop-design.md).

## Inputs

- Required:
  - approved objective and scope
  - target framework moniker (expect `net10.0` unless the brief states otherwise)
- Optional:
  - existing solution conventions
  - analyzer or style rules already enforced in the repo

## Method

1. Use file-scoped namespaces and one primary type per file when it improves readability.
2. Model boundaries as interfaces. Public behavior for a feature lives behind an interface implemented by a focused class; avoid static service locators and hidden singletons.
3. Use constructor injection for collaborators (`ILogger<T>`, repositories, typed HTTP abstractions). Domain logic never resolves its own dependencies.
4. Use `record` types for immutable data transfer and value-like DTOs; use `class` for entities and services with identity, lifecycle, or polymorphic behavior.
5. Establish invariants through constructors, `required` members, or `init` accessors rather than settable properties filled in later.
6. Keep pure static helpers small and `internal` to the feature assembly. The primary surface remains the implementing class behind its interface.
7. Keep framework-required entry points (for example a Lambda handler method) thin, delegating immediately to injected services.

## Quality Bar

- Every feature surface is an interface with one focused implementation.
- No domain type resolves its own dependencies or reads static state.
- Each DTO's invariants hold at construction, with no settable properties filled in later.
- Record versus class is a deliberate choice, justified by value semantics or identity.

## Exceptions

- A type with exactly one implementation and no test double does not need an interface created mechanically.
- Small internal static helpers are fine when they are pure and stay inside the feature assembly.

## Failure Modes

- Turning DTO records into mutable bags of settable properties.
- Creating interfaces mechanically for types that will never have a second implementation or a test double.
- Reaching for static state to share collaborators instead of registering them in DI.

## Related

- [dotnet-10-csharp-nullability-and-async.md](./dotnet-10-csharp-nullability-and-async.md) — contracts, cancellation, and failure modeling.
- [dotnet-composition-and-di.md](./dotnet-composition-and-di.md) — where these types are registered.
- [typescript-oop-design.md](./typescript-oop-design.md) — the TypeScript equivalent.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
