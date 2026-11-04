---
title: "Task Brief Normalization"
type: skill
summary: "Turn a request into a brief with an outcome, scope boundaries, labeled assumptions, and an observable definition of done."
tags:
  - skills
  - delivery
  - intake
  - decomposition
status: draft
version: 0.3.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - client request or task
  - known constraints
outputs:
  - clarified brief
  - labeled assumptions
  - blocking questions
---

# Task Brief Normalization

## Summary

Turn a request into a precise brief: one outcome, explicit boundaries, assumptions separated from facts, and a definition of done that later work can be measured against.

## Use When

- A request is underspecified, ambiguous, or mixes the goal with an implementation idea.
- Work is about to be delegated and the recipient will have no conversation history.
- Confirmed facts and inferences need separating before anyone commits to the work.

## Do Not Use When

- The question is which path the request deserves — use [request-triage.md](./request-triage.md) first.
- The goal is already clear and the deliverable is the criteria — use [acceptance-criteria-authoring.md](./acceptance-criteria-authoring.md).
- The request is a defect report, where the next question is the root cause.

## Inputs

- Required:
  - the request as stated
  - known scope boundaries and non-goals
- Optional:
  - business motivation, priorities, deadlines
  - architectural or operational constraints

## Method

1. Rewrite the request as an outcome, not a list of wishes. One sentence on what becomes true when it is done.
2. Extract scope boundaries and non-goals explicitly. An unstated non-goal becomes scope creep later.
3. Separate what the requester stated from what you inferred, and label every inference as an assumption so it can be confirmed or rejected.
4. Translate vague success language into a definition of done that is observable in code, tests, or artifacts.
5. Name what is missing and whether it blocks. A blocking gap is a question with a suggested default, never a guess.
6. Write the brief so a reader with no history can act on it: no "as discussed", no pronouns pointing outside the text.
7. Keep it short enough to act on and specific enough to verify against.

## Quality Bar

- The outcome is one sentence and names a state, not an activity.
- Every assumption is labeled, and no inference is presented as a requirement.
- The definition of done could be checked by someone who did not write the brief.
- Each blocking question carries a suggested default; non-blocking observations are recorded rather than asked.

## Failure Modes

- Settling implementation details before the goal and boundaries are stable.
- Leaving assumptions unlabeled, so a guess reads as a requirement.
- A definition of done that no test or artifact could ever prove.
- Questions whose answers would not change the work.

## Related

- [request-triage.md](./request-triage.md) — classify and route before normalizing.
- [acceptance-criteria-authoring.md](./acceptance-criteria-authoring.md) — turn the brief into criteria.
- [contract-first-work-breakdown.md](./contract-first-work-breakdown.md) — turn criteria into dispatchable packages.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
