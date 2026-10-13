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
version: 0.2.0
last_reviewed: 2026-10-12
tooling: agnostic
inputs:
  - planned or completed lambda change
  - runtime expectations
  - production constraints
outputs:
  - operability checklist
  - risk notes
  - missing evidence list
---

# Summary

Apply production-minded checks to Lambda work so functional success does not hide reliability, observability, or configuration gaps.

## Use When

- A story changes Lambda behavior in ways that could affect retries, idempotency, timeout safety, or runtime diagnostics.
- Operational risks need capturing before implementation starts.
- A compact operability checklist is needed alongside implementation or review evidence.

## Inputs

- Required:
  - the planned change or the completed work
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
5. Record only the highest-value operability risks and missing evidence, so they can change what gets built or what gets accepted.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.

## Failure Modes

- Treating a passing happy-path test as proof that the change is production-ready.
- Turning the checklist into a generic platform review unrelated to the actual story.
- Requiring ideal observability for every small change instead of focusing on material risks.
- Use `aws-lambda-change-planning.md` instead when the main need is sequencing the change rather than judging its operability.
