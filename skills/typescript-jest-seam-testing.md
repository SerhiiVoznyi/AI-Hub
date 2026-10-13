---
title: "TypeScript Jest Seam Testing"
type: skill
tags:
  - skills
  - typescript
  - jest
  - testing
  - validation
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: tool-assisted
inputs:
  - acceptance criteria
  - changed classes and interfaces
outputs:
  - test strategy
  - criterion-to-scenario mapping
---

# Summary

Decide which Jest tests to write for TypeScript code so each acceptance criterion maps to a named scenario exercised through a stable public seam.

## Use When

- Planning testable acceptance criteria for a TypeScript change.
- Choosing which behaviors of a class-based feature deserve tests.
- Judging whether existing test evidence supports a completion claim.

## Inputs

- Required:
  - approved acceptance criteria
  - changed classes, interfaces, and module boundaries
- Optional:
  - existing Jest setup and conventions
  - risk notes from planning

## Method

1. Map each important acceptance criterion to at least one named test scenario or another explicit evidence source. Keep the mapping visible in the test name or a traceability table.
2. Test behavior at stable seams. For class-based code, that is the public interface of the class, not its private methods.
3. Construct the class under test with test doubles for its dependencies and exercise it through that interface.
4. Cover more than the happy path: invalid inputs, downstream failures, empty and boundary conditions, and contract-sensitive cases.
5. For Lambda work, target the service class rather than the handler export; keep handler coverage limited to parsing and response mapping.
6. State what the tests prove and what still relies on other evidence such as configuration review, deployment assumptions, or manual verification.

## Failure Modes

- Tests that mirror implementation steps, asserting internal call order rather than observable behavior.
- Hidden coupling to private methods or module internals, forcing churn on every refactor.
- Broad suites that never trace back to a specific acceptance criterion.
- Use `typescript-jest-fixtures-and-mocks.md` for how to build fixtures and where to mock.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
