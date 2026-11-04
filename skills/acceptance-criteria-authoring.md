---
title: "Acceptance Criteria Authoring"
type: skill
summary: "Write criteria that describe observable behavior, carry stable IDs, and can each be proved or disproved by one test."
tags:
  - skills
  - delivery
  - requirements
  - acceptance-criteria
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - clarified brief or story
outputs:
  - acceptance criteria AC-1..n
  - explicit and derived markings
  - open questions
---

# Acceptance Criteria Authoring

## Summary

Write acceptance criteria that describe observable behavior, carry stable IDs, and can each be proved or disproved by a single test or cited artifact.

## Use When

- A story needs criteria before anyone sizes, designs, or builds it.
- Existing criteria are untestable, overlapping, or describe implementation instead of behavior.
- The implied error, permission, and boundary cases need surfacing before they are discovered mid-build.

## Do Not Use When

- The goal itself is unclear — use [task-brief-normalization.md](./task-brief-normalization.md) first.
- The criteria exist and the task is turning them into tests — use [acceptance-test-authoring.md](./acceptance-test-authoring.md).
- The question is whether criteria are met — use [independent-verification.md](./independent-verification.md).

## Inputs

- Required:
  - the clarified brief or story
- Optional:
  - existing criteria to normalize
  - domain rules, regulatory constraints, prior related stories

## Method

1. Assign stable IDs `AC-1…n` in story order. Never renumber, merge, or split an ID once assigned; downstream work cites it.
2. State each criterion as observable behavior. Given/When/Then helps when a precondition matters; plain assertions are fine when it does not.
3. Keep one assertion per criterion. Two behaviors joined by "and" are two criteria, because they can fail independently.
4. Mark each criterion `explicit` when the client stated it, or `derived` when you inferred the minimum verifiable expectation from stated intent. Derived criteria are proposals awaiting confirmation, never commitments.
5. Add the cases the request implies but does not state: invalid input, unauthorized access, empty and boundary data, downstream failure, and any non-functional expectation the client would notice.
6. Describe behavior, not mechanism. Naming a class, endpoint, or library inside a criterion locks the design before the architect sees it.
7. Flag anything you could not make testable as an open question rather than writing a criterion no one can verify.

## Quality Bar

- Every criterion has a stable ID, one assertion, and an `explicit` or `derived` marking.
- Each criterion names an observable outcome a test could target, without naming the implementation.
- The negative cases the request implies are present or explicitly declared out of scope.
- Nothing inferred reaches the build unmarked.

## Failure Modes

- Criteria that restate the title in different words and assert nothing.
- Compound criteria that force a partial status because one half passes.
- Implementation written as a requirement, which removes the architect's choices.
- Deriving criteria silently, so an inference reaches the build as if the client had asked for it.

## Related

- [task-brief-normalization.md](./task-brief-normalization.md) — settle the goal before writing criteria.
- [acceptance-test-authoring.md](./acceptance-test-authoring.md) — turn criteria into named scenarios.
- [acceptance-evidence-traceability.md](./acceptance-evidence-traceability.md) — map criteria to evidence once work is done.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
