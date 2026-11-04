---
title: ".NET 10 xUnit Seam Testing"
type: skill
summary: "Decide which xUnit tests to write so each acceptance criterion maps to a named test exercising behavior through a public seam."
tags:
  - skills
  - dotnet
  - csharp
  - xunit
  - testing
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
  - run-commands
inputs:
  - acceptance criteria
  - interfaces and classes under test
outputs:
  - xUnit test strategy
  - criterion-to-test mapping
---

# .NET 10 xUnit Seam Testing

## Summary

Decide which xUnit tests to write for **.NET 10** C# code so each acceptance criterion maps to a named test exercising observable behavior through a public seam.

## Use When

- Planning testable acceptance criteria for a C# change.
- Choosing which behaviors of a service, handler, or endpoint deserve tests.
- Judging whether test output is sufficient evidence for validation.

## Do Not Use When

- The question is how to build fixtures, substitutes, or `WebApplicationFactory` setup — use [dotnet-10-xunit-fixtures-and-fakes.md](./dotnet-10-xunit-fixtures-and-fakes.md).
- The task is judging an existing suite's strength — use [test-suite-quality-review.md](./test-suite-quality-review.md).
- The runtime is TypeScript — use [typescript-jest-seam-testing.md](./typescript-jest-seam-testing.md).

## Inputs

- Required:
  - approved acceptance criteria
  - interfaces and classes under test
- Optional:
  - existing test project layout and collection definitions
  - risk notes from planning

## Method

1. Map each important acceptance criterion to at least one named test so the evidence trail is explicit.
2. Test observable behavior through public methods on the system under test, not private implementation details.
3. Rely on constructor injection of interfaces in production code so tests can supply substitutes without reflection.
4. Use async test methods with `await` for asynchronous code; avoid blocking with `.GetAwaiter().GetResult()` except in documented legacy interop cases.
5. For Lambda work, unit-test the handler service with synthetic events; reserve a small number of integration tests for serialization and response mapping where risk warrants it.
6. Name tests after behavior and criteria (`MethodName_Scenario_ExpectedOutcome` or clear sentence-style display names).

## Quality Bar

- Every important criterion maps to a named test whose name states the behavior.
- No test asserts on a log message, a private field, or an internal call order.
- Async code is tested with async tests, without blocking calls.
- Integration tests are reserved for what a seam-level unit test cannot prove.

## Failure Modes

- Asserting on log messages or private fields instead of outcomes.
- Test suites that grow without tracing back to a specific acceptance criterion.
- Integration tests used for logic that a fast unit test at the service seam would cover.

## Related

- [dotnet-10-xunit-fixtures-and-fakes.md](./dotnet-10-xunit-fixtures-and-fakes.md) — fixtures, substitutes, and integration hosting.
- [acceptance-test-authoring.md](./acceptance-test-authoring.md) — deriving scenarios from criteria first.
- [typescript-jest-seam-testing.md](./typescript-jest-seam-testing.md) — the TypeScript equivalent.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
