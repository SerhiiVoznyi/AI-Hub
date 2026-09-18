---
title: "TypeScript Jest Fixtures and Mocks"
type: skill
tags:
  - skills
  - typescript
  - jest
  - testing
  - mocking
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: tool-assisted
inputs:
  - system under test and its dependencies
  - representative inputs
outputs:
  - typed fixtures
  - deliberate mock boundaries
---

# Summary

Build Jest fixtures and test doubles for TypeScript so tests stay typed against production contracts and mocking happens at injected interfaces rather than inside the code under test.

## Use When

- Writing or reviewing test setup for a class with injected dependencies.
- Deciding what to mock when a test touches an SDK, HTTP client, or repository.
- Fixing brittle tests that break on every refactor because they stub internals.

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

## Failure Modes

- Over-mocking until the test no longer represents the production contract; tests pass while integration breaks.
- Redefining fixture types locally so a production contract change leaves tests green.
- Patching modules globally instead of injecting a fake, creating cross-test interference.
- Use `typescript-jest-seam-testing.md` when the question is which scenarios to test rather than how to build doubles.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
- Fixtures must use synthetic data; treat real payloads as sensitive material.
