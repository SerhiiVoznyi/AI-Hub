---
title: "TypeScript Jest Fixtures and Mocks"
type: skill
summary: "Build typed fixtures and test doubles at injected interfaces, so tests stay bound to production contracts."
tags:
  - skills
  - typescript
  - jest
  - testing
  - mocking
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - system under test and its dependencies
  - representative inputs
outputs:
  - typed fixtures
  - deliberate mock boundaries
---

# TypeScript Jest Fixtures and Mocks

## Summary

Build Jest fixtures and test doubles for TypeScript so tests stay typed against production contracts and mocking happens at injected interfaces rather than inside the code under test.

## Use When

- Writing or reviewing test setup for a class with injected dependencies.
- Deciding what to mock when a test touches an SDK, HTTP client, or repository.
- Fixing brittle tests that break on every refactor because they stub internals.

## Do Not Use When

- The question is which scenarios to test — use [typescript-jest-seam-testing.md](./typescript-jest-seam-testing.md).
- The code under test is a UI component — use [frontend-component-testing.md](./frontend-component-testing.md).
- The runtime is .NET — use [dotnet-10-xunit-fixtures-and-fakes.md](./dotnet-10-xunit-fixtures-and-fakes.md).

## Inputs

- Required:
  - the class under test and its constructor dependencies
- Optional:
  - representative input payloads
  - mocking constraints for external SDKs or services
  - existing fake or factory helpers in the repo

## Method

1. Type fixtures explicitly against the same types production code consumes. Do not redefine looser shapes for convenience.
2. Mock at the dependency interfaces injected into the class under test. Do not reach inside the class or stub language built-ins.
3. Prefer class-based fakes implementing the same interface over partial mocks. Fakes are reusable and drift from the contract less easily.
4. Never mock an SDK inside business code. Production code that takes an SDK directly should be refactored to take an interface first.
5. Control nondeterminism (clock, randomness, IDs) through injected abstractions rather than global patches.
6. Use synthetic data in fixtures. Never use real PII, production payloads, or live credentials.

## Quality Bar

- Every fixture is typed against the production type, not a local lookalike.
- Substitution happens only at injected interfaces.
- Clock, randomness, and ID generation are injected, not globally patched.
- No fixture contains real data, payloads, or credentials.

## Failure Modes

- Over-mocking until the test no longer represents the production contract; tests pass while integration breaks.
- Redefining fixture types locally so a production contract change leaves tests green.
- Patching modules globally instead of injecting a fake, creating cross-test interference.

## Related

- [typescript-jest-seam-testing.md](./typescript-jest-seam-testing.md) — choosing the scenarios these doubles serve.
- [typescript-oop-design.md](./typescript-oop-design.md) — the injected interfaces that make substitution possible.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Fixtures must use synthetic data; treat real payloads as sensitive material.
