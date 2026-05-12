---
title: "Serverless Operability Checks"
type: skill
tags:
  - skills
  - aws
  - lambda
  - operability
  - serverless
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - planned or completed change
  - runtime expectations
  - production constraints
outputs:
  - operability checklist
  - risk notes
  - missing evidence list
related:
  - ../skills/README.md
  - ../agents/planner-agent.md
  - ../agents/executor-agent.md
  - ../agents/validator-agent.md
  - ./aws-lambda-change-planning.md
---

# Summary

Apply production-minded checks to Lambda work so functional success does not hide reliability, observability, or configuration gaps.

## Use When

- A story changes Lambda behavior in ways that could affect retries, idempotency, timeout safety, or runtime diagnostics.
- The planner needs to capture operational risks before execution starts.
- The executor or validator needs a compact operability checklist alongside implementation or review evidence.

## Inputs

- Required:
  - approved plan or work result
  - expected runtime behavior
- Optional:
  - timeout and memory limits
  - retry model and event source semantics
  - logging, metrics, and alerting expectations

## Method

1. Check invocation semantics: duplicate delivery, ordering assumptions, retry behavior, and how the function handles partial failure.
2. Check runtime safety: timeout budget, long-running work, initialization cost, network dependency behavior, and safe cleanup paths.
3. Check state and configuration handling: idempotency keys, environment variables, secrets, region-specific behavior, and deployment-time configuration assumptions.
4. Check observability: structured logs, enough context to debug failures, and evidence that critical behavior is visible in tests or review artifacts.
5. Record only the highest-value operability risks and missing evidence so they can influence planning, execution, or validation.

## Failure Modes

- Treating a passing happy-path test as proof that the change is production-ready.
- Turning the checklist into a generic platform review unrelated to the actual story.
- Requiring ideal observability for every small change instead of focusing on material risks.
- Use `validation-disposition.md` instead when the main need is deciding `pass`, `rework`, or `replan`.
