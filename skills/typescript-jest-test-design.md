---
title: "TypeScript Jest Test Design"
type: skill
tags:
  - skills
  - typescript
  - jest
  - testing
  - validation
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: tool-assisted
inputs:
  - acceptance criteria
  - code change scope
  - module boundaries
outputs:
  - test strategy
  - typed fixtures
  - evidence expectations
related:
  - ../skills/README.md
  - ../skills/typescript-design.md
  - ../skills/nodejs-backend-implementation.md
  - ../skills/aws-lambda-implementation.md
  - ../skills/acceptance-evidence-traceability.md
  - ../agents/planner-agent.md
  - ../agents/executor-agent.md
  - ../agents/validator-agent.md
  - ../knowledge/safety-policy.md
---

# Summary

Design Jest coverage for TypeScript code so tests prove the approved acceptance criteria at stable seams, with typed fixtures and deliberate mocking. Runtime-specific concerns belong to the linked Node and Lambda skills, not here.

## Use When

- Planning testable acceptance criteria for a TypeScript change.
- Deciding which Jest tests to add or update for a class-based feature.
- Judging whether test evidence is convincing enough to support a completion claim.

## Inputs

- Required:
  - approved acceptance criteria
  - changed classes, interfaces, and module boundaries
- Optional:
  - existing Jest setup and conventions
  - representative input fixtures
  - mocking constraints for external SDKs or services

## Method

1. Map each important acceptance criterion to at least one named test scenario or other explicit evidence source. Keep the mapping visible in the test name or in a traceability table.
2. Test behavior at stable seams. For OOP code, that is the public interface of a class, not its private methods. Construct the class with test doubles for its dependencies and exercise the interface.
3. Type fixtures explicitly. Reuse the same types the production code consumes; do not redefine looser shapes for convenience.
4. Cover more than the happy path: invalid inputs, downstream failures, empty and boundary conditions, and contract-sensitive cases.
5. Mock deliberately at the dependency interfaces injected into the class under test. Do not reach inside the class or stub language built-ins.
6. State what the tests prove and what still relies on other evidence such as config review, deployment assumptions, or manual verification.

## Mocking Boundaries

- Mock injected interfaces (logger, repository, HTTP client, AWS adapter), never the SDK directly inside business code. Production code that takes an SDK directly should be refactored to take an interface first.
- Prefer class-based fakes that implement the same interface over partial mocks. Fakes are easier to reuse and harder to drift from the contract.
- For Lambda-specific seams (event parsing, AWS SDK adapters, context handling) see `aws-lambda-implementation.md` for the recommended composition. Tests target the service class, not the handler export.

## Failure Modes

- Tests that mirror implementation steps, asserting internal call order rather than observable behavior.
- Over-mocking until the test no longer represents the production contract; tests pass while integration breaks.
- Hidden coupling to private methods or module internals, which forces churn on every refactor.
- Using real PII, production payloads, or live credentials in fixtures. Use synthetic data per `../knowledge/safety-policy.md`.
- Use `acceptance-evidence-traceability.md` instead when the immediate task is packaging evidence rather than designing tests.
