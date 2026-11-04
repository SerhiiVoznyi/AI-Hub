---
title: "Test Suite Quality Review"
type: skill
summary: "Judge whether tests would actually catch a regression: assertion strength, criterion coverage, seam choice, and flakiness."
tags:
  - skills
  - testing
  - code-review
  - quality
status: draft
version: 0.1.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - run-commands
inputs:
  - test files in a change set
  - acceptance criteria
outputs:
  - test quality findings with severity
---

# Test Suite Quality Review

## Summary

Decide whether a change's tests would fail if the behavior broke. A passing suite proves the code runs; this review asks what it would still prove if the implementation were wrong.

## Use When

- A change adds or modifies tests, and the suite is about to become the regression safety net.
- Coverage is high but defects still reach production.
- A review lead has routed a diff whose risk is concentrated in test quality.

## Do Not Use When

- No tests exist yet and the task is deciding what to write — use [acceptance-test-authoring.md](./acceptance-test-authoring.md).
- The question is whether criteria are met — use [independent-verification.md](./independent-verification.md).
- The concern is production code quality — use [change-set-review.md](./change-set-review.md).

## Inputs

- Required:
  - the test files in the change set, and the code they exercise
  - the acceptance criteria the tests claim to cover
- Optional:
  - the project's test conventions and fixtures
  - CI history showing intermittent failures

## Method

1. Apply the mutation question to each test: if the implementation were subtly wrong — an inverted condition, an off-by-one, a skipped validation, a swallowed error — would this test fail? A test that survives every plausible mutation asserts nothing useful.
2. Judge assertion strength. Asserting that a call happened, that a result is not null, or that no exception was thrown is weak. Assert the value, the state change, and the observable effect.
3. Check the seam. Tests should exercise a stable public surface, not private methods or internal call order. A test that must change on every refactor imposes a tax and will eventually be deleted or weakened.
4. Check what is mocked. Mocking the unit under test, or so much of its environment that only the mock is exercised, produces a test that passes regardless of the code.
5. Map tests to criteria in both directions: every criterion has a test that could fail for it, and every test traces to a criterion or an explicit regression it guards.
6. Check the negative space: invalid input, authorization failure, empty and boundary data, downstream errors, and concurrent or repeated calls. A suite that only proves the happy path proves the least interesting case.
7. Look for flakiness sources: real clocks, real sleeps, real network, shared mutable fixtures, test interdependence, and reliance on iteration or map ordering. Flaky tests are worse than missing ones, because they train the team to ignore failures.
8. Check the failure message. When a test fails, does its name and assertion identify the broken behavior without opening the file?
9. Treat broad snapshots with suspicion: they assert everything and therefore nothing in particular, and they are routinely re-recorded to make a failure go away.
10. Run the suite where possible and record the real result. Note skipped and pending tests; a skipped test is absent coverage wearing a green badge.

## Quality Bar

- Every finding cites the test by `path:line` and names the mutation that would survive it.
- Criterion-to-test mapping is stated in both directions, with gaps named.
- Flakiness findings name the specific source, not a general suspicion.
- Where the suite was run, the real pass, fail, and skip counts are recorded; where it was not, that is stated.

## Failure Modes

- Accepting coverage percentage as evidence of quality; coverage shows execution, not assertion.
- Flagging missing tests for trivial code while a weakly asserted test guards the risky path.
- Rewriting tests during the review, which removes the independent judgement the review exists for.
- Ignoring skipped and pending tests when reporting what the suite covers.

## Related

- [acceptance-test-authoring.md](./acceptance-test-authoring.md) — writing the tests this review judges.
- [independent-verification.md](./independent-verification.md) — deciding whether criteria are met.
- [typescript-jest-seam-testing.md](./typescript-jest-seam-testing.md), [dotnet-10-xunit-seam-testing.md](./dotnet-10-xunit-seam-testing.md), [frontend-component-testing.md](./frontend-component-testing.md) — the seam conventions per stack.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Review tests; do not modify them. A fix is a finding for the author.
- Never run a suite that touches production systems or real credentials.
