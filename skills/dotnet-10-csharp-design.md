---
title: ".NET 10 C# Design"
type: skill
tags:
  - skills
  - dotnet
  - csharp
  - design
  - oop
  - language
status: draft
version: 0.1.0
last_reviewed: 2026-05-13
tooling: agnostic
inputs:
  - approved work package
  - feature or module scope
  - integration boundaries
outputs:
  - idiomatic C# structure
  - explicit contracts
  - DI-friendly types
---

# Summary

Apply idiomatic C# design for **.NET 10** targets (for example `net10.0`) so public surfaces are explicit, nullability is honest, dependencies are constructor-injected, and async and error models stay consistent across libraries and apps.

## Use When

- Authoring or reviewing C# code for class libraries, ASP.NET Core, workers, or Lambda projects on .NET 10.
- Choosing between records and classes, interface boundaries, and where async belongs.
- Aligning new code with nullable reference types and modern C# features without weakening safety for convenience.

## Inputs

- Required:
  - approved objective and scope
  - target framework moniker (expect `net10.0` unless the brief states otherwise)
- Optional:
  - existing solution conventions
  - analyzer or style rules already enforced in the repo

## Method

1. Prefer **file-scoped namespaces** and one primary type per file when it improves readability.
2. Model **boundaries as interfaces**. Public behavior for a feature lives behind an interface implemented by a focused class; avoid static service locators and hidden singletons.
3. Use **constructor injection** for collaborators (`ILogger<T>`, repositories, HTTP clients wrapped in typed abstractions). Register services at the composition root (`Program.cs` or equivalent), not inside domain logic.
4. Enable and honor **nullable reference types**. Use `required` members, `init` accessors, or constructors to establish invariants. Prefer `null`-forbidden references in domain code; use optional patterns (`Maybe`, nullable value types, or explicit option types) where absence is meaningful.
5. Use **`record` types** for immutable data transfer and value-like DTOs; use **`class`** for entities and services with identity, lifecycle, or polymorphic behavior. Do not use records as dumping grounds for mutable state.
6. Prefer **`async`/`await`** end-to-end with `CancellationToken` threaded through public APIs. Avoid `async void` except for UI event handlers (rare in backend/Lambda).
7. Model failures with **typed exceptions** or **discriminated result types** (`Result<T>`) at boundaries; do not swallow exceptions or use exceptions for ordinary control flow.
8. Keep **pure static helpers** small and internal to a feature when they are pure transformations; the primary surface remains the implementing class behind its interface.

## Object-oriented default

- Default unit of behavior is a **class implementing an explicit interface** at module or feature boundaries.
- Stateful services, orchestration, persistence access, and adapters are **classes** with injected dependencies.
- **Composition** is through constructors and explicit wiring at startup, not through service location or ambient context.

Allowed exceptions, narrow and explicit:

- Small pure functions for formatting, parsing, or mapping when kept `internal` to the feature assembly.
- Framework-required entry points (for example Lambda handler methods) remain thin and delegate immediately to injected services.

## Failure modes

- Turning DTO `record`s into mutable bags of settable properties.
- Disabling nullable warnings (`!`, `#nullable disable`) to silence the compiler instead of fixing contracts.
- Blocking async calls with `.Result` or `.Wait()` in request or Lambda paths.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
- Treat deserialized JSON and message payloads as **untrusted** until validated into strong types at the boundary.
