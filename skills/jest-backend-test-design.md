---
title: "Jest Backend Test Design"
type: skill
tags:
  - skills
  - jest
  - testing
  - backend
  - validation
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - acceptance criteria
  - code change scope
  - integration boundaries
outputs:
  - test strategy
  - coverage targets
  - evidence expectations
related:
  - ../skills/README.md
  - ../agents/planner-agent.md
  - ../agents/executor-agent.md
  - ../agents/validator-agent.md
  - ./acceptance-evidence-traceability.md
---

# Summary

Design Jest coverage for backend and Lambda stories so tests prove the approved acceptance criteria instead of merely mirroring the implementation.

## Use When

- A planner needs testable acceptance criteria for Node.js or Lambda work.
- The executor is deciding which Jest tests to add or update.
- The validator is judging whether test evidence is convincing enough for the claimed outcome.

## Inputs

- Required:
  - approved acceptance criteria
  - changed modules, handlers, or service boundaries
- Optional:
  - existing test patterns
  - event fixtures
  - mocking constraints for AWS SDK or downstream services

## Method

1. Map each important acceptance criterion to at least one test scenario or other explicit evidence source.
2. Default to testing behavior at stable seams: pure logic, service boundaries, handler translation, and failure handling. Avoid asserting private implementation details.
3. Cover more than the happy path. Include invalid inputs, downstream failures, empty or edge conditions, and contract-sensitive cases.
4. Mock external boundaries deliberately. Mock AWS or network dependencies at the seam where the behavior under test stays meaningful.
5. State what the tests prove and what still relies on other evidence such as config review, deployment assumptions, or manual verification.

## Failure Modes

- Writing tests that only restate the implementation or assert internal call order without proving behavior.
- Over-mocking until the test no longer represents the production contract.
- Claiming coverage is sufficient without showing how it maps back to the approved criteria.
- Use `acceptance-evidence-traceability.md` instead when the main task is packaging evidence rather than designing tests.
