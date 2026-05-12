---
title: "Story Brief Normalization"
type: skill
tags:
  - skills
  - planning
  - user-stories
  - decomposition
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - user story
  - scope constraints
  - business context
outputs:
  - clarified task brief
  - explicit assumptions
  - observable completion criteria
related:
  - ../skills/README.md
  - ../agents/orchestrator-agent.md
  - ../agents/planner-agent.md
---

# Summary

Turn a user story into a precise task brief with scope boundaries, assumptions, and completion criteria that can drive planning and validation.

## Use When

- A user story is underspecified, ambiguous, or mixes goals with implementation ideas.
- The planner needs a clean brief before breaking work into steps.
- The orchestrator needs to separate confirmed facts from assumptions before routing work.

## Inputs

- Required:
  - user story or task request
  - known scope boundaries and non-goals
- Optional:
  - business motivation
  - architecture context
  - deadlines, priorities, or operational constraints

## Method

1. Rewrite the request as an outcome-oriented objective, not as a loose list of wishes.
2. Extract explicit scope boundaries, non-goals, and constraints such as stack, services, timelines, or quality expectations.
3. Separate confirmed facts from assumptions. Label assumptions so the orchestrator can approve them or ask the user to clarify.
4. Translate vague success language into observable completion criteria that can later be tested or evidenced.
5. Call out missing information that blocks responsible planning instead of guessing.
6. Return a brief that is short enough to execute against and specific enough to validate.

## Failure Modes

- Jumping into implementation details before the goal and boundaries are stable.
- Leaving non-goals implicit, which causes avoidable scope creep later.
- Writing completion criteria that are not observable in tests, artifacts, or review evidence.
- Use `aws-lambda-change-planning.md` instead when the brief is already clear and the main task is sequencing Lambda-specific implementation work.
