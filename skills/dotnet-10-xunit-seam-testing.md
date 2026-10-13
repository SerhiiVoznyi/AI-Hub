---
title: ".NET 10 xUnit Seam Testing"
type: skill
tags:
  - skills
  - dotnet
  - csharp
  - xunit
  - testing
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: tool-assisted
inputs:
  - acceptance criteria
  - interfaces and classes under test
outputs:
  - xUnit test strategy
  - criterion-to-test mapping
---

# Summary

Decide which xUnit tests to write for **.NET 10** C# code so each acceptance criterion maps to a named test exercising observable behavior through a public seam.

## Use When

- Planning testable acceptance criteria for a C# change.
- Choosing which behaviors of a service, handler, or endpoint deserve tests.
- Judging whether test output is sufficient evidence for validation.

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

## Failure Modes

- Asserting on log messages or private fields instead of outcomes.
- Test suites that grow without tracing back to a specific acceptance criterion.
- Integration tests used for logic that a fast unit test at the service seam would cover.
- Use `dotnet-10-xunit-fixtures-and-fakes.md` for fixtures, substitutes, and `WebApplicationFactory` setup.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
