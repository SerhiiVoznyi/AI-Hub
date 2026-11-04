---
title: "Frontend Component Testing"
type: skill
summary: "Test UI behavior the way a user reaches it, mapping each criterion to a named scenario that survives a refactor."
tags:
  - skills
  - frontend
  - testing
  - validation
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
  - run-commands
inputs:
  - acceptance criteria
  - component boundaries
outputs:
  - test strategy
  - criterion-to-scenario mapping
---

# Frontend Component Testing

## Summary

Test UI behavior the way a user reaches it — rendered output and interaction — so each acceptance criterion maps to a named scenario that survives a refactor.

## Use When

- Planning which tests a UI work package needs.
- Deciding what belongs in a component test versus an end-to-end test.
- Judging whether existing UI tests support a completion claim.

## Do Not Use When

- The tests must be derived from criteria before implementation — use [acceptance-test-authoring.md](./acceptance-test-authoring.md).
- The task is judging an existing suite's strength — use [test-suite-quality-review.md](./test-suite-quality-review.md).
- The code under test is server-side; use the stack's seam-testing skill instead.

## Inputs

- Required:
  - the acceptance criteria
  - the components and the client seam they depend on
  - the project's existing test runner and utilities
- Optional:
  - shared fixtures and render helpers
  - accessibility requirements from the criteria

## Method

1. Use the runner and testing utilities the project already has. Adding a second testing stack is a plan-level decision, not a test-writing one.
2. Map each important criterion to at least one named scenario, and carry the `AC-ID` in the test name so the report traces back to the story.
3. Query the way a user perceives the UI: by role, label, and visible text. Querying by class name or internal structure couples the test to markup that is free to change.
4. Drive behavior through real interaction — click, type, submit, keyboard — rather than by calling handlers directly.
5. Substitute at the client seam, not inside the component. Give the component a fake implementation of the API interface so the test controls outcomes without touching transport; see [frontend-api-client-seam.md](./frontend-api-client-seam.md).
6. Cover each designed state: loading, empty, every error, unauthorized, and success. A state with no test is a state nobody has seen.
7. Test the accessibility expectations the criteria state: accessible names, keyboard operability, focus movement, and announced changes.
8. Keep end-to-end tests for flows that cross real boundaries, and let component tests carry the per-criterion detail.
9. Assert on what the user would observe. Snapshot comparisons that assert everything assert nothing in particular, so keep them narrow and intentional.

## Quality Bar

- Every criterion maps to a named scenario carrying its ID.
- No test queries by class name or reaches into component internals.
- Every designed state, including each error, has a test.
- Substitution happens at the client seam, never inside the component under test.

## Failure Modes

- Tests that reach into component internals or state, breaking on every refactor.
- Mocking the component under test, or so much of its environment that the criterion is no longer exercised.
- Only the success path covered, leaving the error and empty states unproven.
- Broad snapshots re-recorded whenever they fail, which turns a failure into a formality.

## Related

- [acceptance-test-authoring.md](./acceptance-test-authoring.md) — deriving scenarios from criteria before implementation.
- [frontend-ui-states-and-accessibility.md](./frontend-ui-states-and-accessibility.md) — what each state must do.
- [test-suite-quality-review.md](./test-suite-quality-review.md) — judging the resulting suite.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Use synthetic fixture data; never real user data, tokens, or production endpoints.
