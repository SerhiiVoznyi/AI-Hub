---
title: ".NET 10 xUnit Fixtures and Fakes"
type: skill
tags:
  - skills
  - dotnet
  - csharp
  - xunit
  - testing
  - mocking
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: tool-assisted
inputs:
  - system under test and its dependencies
  - test project conventions
outputs:
  - deterministic fixtures
  - substitute boundaries
---

# Summary

Build xUnit fixtures and test doubles for **.NET 10** C# so tests stay isolated and deterministic, substituting at injected interfaces rather than mocking framework internals.

## Use When

- Setting up shared state, async initialization, or substitutes for a C# test suite.
- Deciding between a hand-written fake, `Moq`/`NSubstitute`, and a real dependency.
- Adding integration tests that need the ASP.NET Core pipeline.

## Inputs

- Required:
  - the class under test and its constructor dependencies
- Optional:
  - existing fixture and collection conventions
  - `WebApplicationFactory<TProgram>` usage in the repo

## Method

1. Substitute at the interfaces injected into the system under test, using the project's standard tool (`Moq`, `NSubstitute`, or hand-written fakes) consistently.
2. Prefer hand-written fakes implementing the interface when the same behavior is reused across tests; reserve mocks for interaction assertions that genuinely matter.
3. Use `IAsyncLifetime` for asynchronous setup and teardown rather than constructor hacks or blocking calls.
4. Use fresh fixtures per test when isolation matters; avoid sharing mutable static state across tests.
5. Abstract clock, randomness, and identifiers behind injected interfaces so tests are deterministic.
6. For ASP.NET Core, use `WebApplicationFactory<TProgram>` (or the minimal hosting equivalent) for integration tests that need the real pipeline; keep unit tests fast and isolated.

## Failure Modes

- Over-mocking the framework so tests only mirror the implementation.
- Flaky tests from real clock, randomness, or network access without abstractions.
- Shared collection fixtures that leak mutable state between tests.
- Use `dotnet-10-xunit-seam-testing.md` when the question is which scenarios to test rather than how to build doubles.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
- Do not commit secrets into test `appsettings`; use user secrets or CI-injected values for local-only runs.
