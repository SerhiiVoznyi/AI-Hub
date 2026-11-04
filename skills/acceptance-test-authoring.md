---
title: "Acceptance Test Authoring"
type: skill
summary: "Write tests from the criteria and contract alone, so they encode what was agreed rather than what the implementation happens to do."
tags:
  - skills
  - delivery
  - testing
  - acceptance-criteria
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
  - run-commands
inputs:
  - acceptance criteria
  - contracts
outputs:
  - criterion-to-test mapping
  - black-box acceptance tests
---

# Acceptance Test Authoring

## Summary

Write acceptance tests from the criteria and the contract alone, so the tests encode what was agreed rather than what the implementation happens to do.

## Use When

- Criteria are approved and tests can be written before or alongside the implementation.
- Verification must be independent of how the feature was built.
- A story needs tests that stay valid across a refactor.

## Do Not Use When

- The tests exist and the task is judging them — use [test-suite-quality-review.md](./test-suite-quality-review.md).
- The question is whether the criteria are met — use [independent-verification.md](./independent-verification.md).
- The criteria are not settled — use [acceptance-criteria-authoring.md](./acceptance-criteria-authoring.md).

## Inputs

- Required:
  - the acceptance criteria with their IDs
  - the contract the feature exposes
  - the project's existing test runner and conventions
- Optional:
  - fixtures and factories the project already has
  - known environment constraints

## Method

1. Derive every test from the criterion and the contract. Do not read the implementation; a test shaped by the code cannot disprove it.
2. Map each criterion to at least one named test and carry the `AC-ID` in the test name, so traceability survives in the test report.
3. Exercise the feature through its contract — the endpoint, the public interface, the rendered component — never through an internal.
4. Cover the criterion's negative half: rejected input, unauthorized access, empty and boundary data, downstream failure.
5. Use the project's existing runner, fixtures, and conventions. Introducing a second testing style is a change the plan must have approved.
6. Keep each test's failure message specific enough to identify the broken criterion without opening the test.
7. Say plainly which tests are expected to fail until the implementation lands.

## Quality Bar

- Every criterion maps to at least one named test carrying its ID.
- No test was written after reading the implementation it checks.
- Each test exercises a contract surface, not an internal.
- Negative cases are present for every criterion that implies one.

## Failure Modes

- Tests written after reading the implementation, which pass by construction.
- Asserting internal call order or private state, so a refactor breaks a green suite.
- One large test covering several criteria, so a failure cannot be attributed.
- Mocking the thing under test, leaving the criterion unproven.

## Related

- [typescript-jest-seam-testing.md](./typescript-jest-seam-testing.md), [dotnet-10-xunit-seam-testing.md](./dotnet-10-xunit-seam-testing.md), [frontend-component-testing.md](./frontend-component-testing.md) — how to structure the tests per stack.
- [test-suite-quality-review.md](./test-suite-quality-review.md) — judging the resulting suite.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Use synthetic data only; no real credentials, production data, or production endpoints in tests or fixtures.
