---
title: "Acceptance Evidence Traceability"
type: skill
tags:
  - skills
  - validation
  - evidence
  - traceability
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - acceptance criteria
  - work result
  - supporting artifacts
outputs:
  - criterion-to-evidence map
  - evidence gaps
  - completion summary
---

# Summary

Map each approved acceptance criterion to concrete evidence so executor claims and validator decisions stay aligned.

## Use When

- The executor is packaging work results for review.
- The validator needs to assess whether the submitted evidence is sufficient for each approved criterion.
- A task has multiple moving parts and broad completion claims could otherwise hide gaps.

## Inputs

- Required:
  - approved acceptance criteria
  - produced artifacts, diffs, or test results
- Optional:
  - screenshots, logs, fixtures, or reviewer notes
  - known limitations or untested assumptions

## Method

1. List each acceptance criterion separately instead of summarizing them into one broad success statement.
2. Attach concrete evidence to each criterion, such as updated tests, changed files, example inputs and outputs, or explicit review findings.
3. Mark criteria with missing, partial, or assumption-based evidence instead of treating them as complete.
4. Keep evidence traceable to the approved plan so the validator can decide whether the gap is implementation, planning, or missing information.
5. Return a compact summary that makes the remaining uncertainty visible to the orchestrator.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.

## Failure Modes

- Providing global claims like "tests pass" without stating which criterion that proves.
- Mixing evidence with new scope decisions that were not part of the approved work package.
- Hiding assumptions or manual checks inside a generic completion summary.
- Use the stack’s test-design skill (`typescript-jest-test-design.md` or `dotnet-10-csharp-test-design.md`) when the missing piece is which tests to design rather than how to map evidence to criteria.
