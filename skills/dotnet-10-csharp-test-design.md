---
title: ".NET 10 C# xUnit Test Design"
type: skill
tags:
  - skills
  - dotnet
  - csharp
  - xunit
  - testing
  - validation
status: draft
version: 0.1.0
last_reviewed: 2026-05-13
tooling: tool-assisted
inputs:
  - acceptance criteria
  - code change scope
  - seams and interfaces
outputs:
  - xUnit test strategy
  - fixture and mock boundaries
  - evidence expectations
related:
  - ../skills/README.md
  - ../skills/dotnet-10-csharp-design.md
  - ../skills/dotnet-backend-implementation.md
  - ../skills/aws-lambda-dotnet-implementation.md
  - ../skills/acceptance-evidence-traceability.md
  - ../knowledge/safety-policy.md
---

# Summary

Design **xUnit** coverage for **.NET 10 C#** code so tests prove approved acceptance criteria at **stable seams** (interfaces and injected collaborators), with deterministic fixtures and deliberate substitutes (`Moq`, `NSubstitute`, or hand-written fakes as the project standard).

## Use When

- Planning testable acceptance criteria for a C# change.
- Adding or reviewing tests for services, handlers, and API endpoints.
- Judging whether test output is sufficient evidence for validation.

## Inputs

- Required:
  - approved acceptance criteria
  - interfaces and classes under test
- Optional:
  - existing test project layout (`xunit.runner.visualstudio`, collection definitions)
  - WebApplicationFactory usage for integration tests

## Method

1. Test **observable behavior** through public methods on the system under test, not private implementation details.
2. Prefer **constructor injection of interfaces** in production code so tests can pass fakes without reflection.
3. Use **`IAsyncLifetime`** or async test methods with `await` for asynchronous code; avoid blocking with `.GetAwaiter().GetResult()` in tests except in documented legacy interop cases.
4. For ASP.NET Core, use **`WebApplicationFactory<TProgram>`** (or the minimal hosting equivalent) for integration tests that need the real pipeline; keep unit tests fast and isolated.
5. For Lambda handlers, unit-test the **handler service** with synthetic events; reserve a small number of integration tests for serialization and response mapping if warranted by risk.
6. Name tests after **behavior and criteria** (`MethodName_Scenario_ExpectedOutcome` or clear sentence-style display names).
7. Avoid sharing mutable static state across tests; use **fresh fixtures** per test when isolation matters.

## Failure modes

- Asserting on log messages or private fields instead of outcomes.
- Over-mocking the framework so tests only mirror the implementation.
- Flaky tests from real clock, random, or network without abstractions.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) for destructive operations, secrets, scope and approvals, supply chain, AWS safety, untrusted-input handling, and the OOP-default coding posture.
- Do not commit secrets into test appsettings; use user secrets or CI-injected values for local-only runs.
