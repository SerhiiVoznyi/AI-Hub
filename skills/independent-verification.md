---
title: "Independent Verification"
type: skill
summary: "Decide completion from real runs and cited artifacts rather than the implementer's account, letting thin evidence lower the verdict."
tags:
  - skills
  - delivery
  - verification
  - evidence
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - run-commands
inputs:
  - acceptance criteria
  - change set and test commands
outputs:
  - per-criterion verdict with evidence
  - defects
---

# Independent Verification

## Summary

Decide whether work is actually complete without relying on the implementer's account of it: run the real checks, cite the real artifacts, and let thin evidence lower the verdict.

## Use When

- A result is being checked before it is accepted, merged, or reported as done.
- The checker must reach its own conclusion rather than confirm someone else's.
- A "done" claim needs testing against the code and the test run.

## Do Not Use When

- You are assembling your own evidence — use [acceptance-evidence-traceability.md](./acceptance-evidence-traceability.md).
- The verdict exists and the task is deciding what happens next — use [validation-disposition.md](./validation-disposition.md).
- The concern is whether the tests themselves are any good — use [test-suite-quality-review.md](./test-suite-quality-review.md).

## Inputs

- Required:
  - the acceptance criteria
  - the change set and the commands that exercise it
- Optional:
  - the approved plan and contracts
  - prior defect reports
  - known environment limitations

## Method

1. Work from the criteria, the diff, and the runnable checks. Treat any narrative about the work as a claim to test, not as input.
2. Run the real commands. A result you did not observe is not evidence, and a suite you could not run is a blocker, not a pass.
3. Judge each criterion on its own and cite what decides it: `path:line`, a test name, or recorded output.
4. Probe past the happy path: error branches, boundary values, permissions, and behavior adjacent to the change that could have regressed.
5. Where evidence is missing, say what you searched and where. Absence is a finding, not a silence.
6. Let the weakest criterion set the verdict. One unproven criterion is enough to withhold a pass.
7. Report each defect with reproduction steps, expected versus actual, and the suspected location — enough to act on without a follow-up question.

## Quality Bar

- Every criterion has a verdict backed by a citation or a stated search scope.
- Recorded pass, fail, and skip counts come from a run observed in this session.
- No criterion is marked met on inference from code appearance alone.
- Each defect is reproducible from its report without further questions.

## Failure Modes

- Accepting a summary of a test run instead of a run.
- Marking a criterion met because the code looks like it should work.
- Fixing the problem instead of reporting it, which removes the independent check.
- Reinterpreting a criterion so the current behavior satisfies it.

## Related

- [acceptance-evidence-traceability.md](./acceptance-evidence-traceability.md) — assembling evidence rather than judging it.
- [validation-disposition.md](./validation-disposition.md) — routing the outcome once the verdict exists.
- [test-suite-quality-review.md](./test-suite-quality-review.md) — whether a green suite proves anything.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Never run verification against production systems or real credentials.
