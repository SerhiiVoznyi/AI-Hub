---
title: "Validation Disposition"
type: skill
tags:
  - skills
  - validation
  - review
  - decision-making
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - approved plan
  - executor result
  - evidence package
outputs:
  - validation status
  - findings
  - recommended next action
related:
  - ../skills/README.md
  - ../agents/validator-agent.md
  - ./acceptance-evidence-traceability.md
  - ./serverless-operability-checks.md
---

# Summary

Classify a reviewed result as `pass`, `rework`, or `replan` by separating implementation defects, planning defects, and evidence gaps.

## Use When

- The validator needs to turn review findings into a crisp disposition for the orchestrator.
- A result is partially correct and the next action is not obvious.
- The team wants consistent validator outcomes instead of vague "needs changes" feedback.

## Inputs

- Required:
  - approved objective and acceptance criteria
  - executor work result and supporting evidence
- Optional:
  - prior validation findings
  - risk notes from planning
  - clarifications from the user or orchestrator

## Method

1. Review the approved scope first so the validator does not silently expand the task.
2. Compare each important criterion against the submitted evidence and note whether the gap is missing proof, incorrect behavior, or a flaw in the plan itself.
3. Return `pass` only when the critical criteria are satisfied with enough evidence.
4. Return `rework` when the plan is still sound but the implementation, tests, or evidence are incomplete.
5. Return `replan` when the approved plan omitted necessary work, depended on bad assumptions, or no longer matches the real task.
6. Recommend the smallest useful next action so the orchestrator can route the loop without reinterpretation.

## Failure Modes

- Writing validator feedback that implicitly fixes the issue instead of classifying it.
- Returning `rework` for a problem that actually requires a planning correction.
- Passing a result because it looks plausible even though the critical evidence is missing.
- Use `serverless-operability-checks.md` instead when the immediate task is surfacing operational risks rather than deciding the final validation status.
