---
title: ".NET 10 C# Nullability and Async"
type: skill
tags:
  - skills
  - dotnet
  - csharp
  - async
  - nullability
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: agnostic
inputs:
  - feature or module scope
  - external contract definitions
outputs:
  - honest nullability contracts
  - consistent async and failure model
---

# Summary

Keep **.NET 10** C# contracts honest about absence, threaded with cancellation end to end, and explicit about failure, so the compiler and call sites carry the guarantees instead of comments.

## Use When

- Defining the signatures of a public C# API, service method, or DTO.
- Deciding how a failure should surface: typed exception or result type.
- Reviewing code that silences nullable warnings or blocks on async calls.

## Inputs

- Required:
  - the boundary being typed and its expected failure cases
- Optional:
  - existing result or error conventions in the solution
  - serialization contracts from producers

## Method

1. Enable and honor nullable reference types. Fix contracts instead of silencing warnings with `!` or `#nullable disable`.
2. Use `required` members, `init` accessors, or constructors to establish non-null invariants at construction time.
3. Where absence is meaningful, express it explicitly with nullable types or an option-like type rather than sentinel values.
4. Use `async`/`await` end to end and thread `CancellationToken` through public asynchronous APIs. Avoid `async void` outside UI event handlers.
5. Model failures with typed exceptions or discriminated result types (`Result<T>`) at boundaries. Do not use exceptions for ordinary control flow or swallow them.
6. Validate deserialized JSON and message payloads into strong types at the boundary before domain logic runs.

## Failure Modes

- Disabling nullable warnings to silence the compiler instead of fixing contracts.
- Blocking async calls with `.Result` or `.Wait()` in request or Lambda paths.
- Catching broad exceptions and returning a default value, hiding the failure from callers.
- Use `dotnet-10-csharp-oop-design.md` for class, interface, and record structure.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
- Treat deserialized JSON and message payloads as untrusted until validated into strong types at the boundary.
