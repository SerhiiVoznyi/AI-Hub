---
title: "Serverless Operability Checks"
type: skill
summary: "Check retries, idempotency, timeouts, configuration, and observability so functional success does not hide production gaps."
tags:
  - skills
  - aws
  - lambda
  - operability
  - serverless
status: draft
version: 0.3.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - planned or completed lambda change
  - runtime expectations
  - production constraints
outputs:
  - operability checklist
  - risk notes
  - missing evidence list
---

# Serverless Operability Checks

## Summary

Apply production-minded checks to Lambda work so functional success does not hide reliability, observability, or configuration gaps.

## Use When

- A story changes Lambda behavior in ways that could affect retries, idempotency, timeout safety, or runtime diagnostics.
- Operational risks need capturing before implementation starts.
- A compact operability checklist is needed alongside implementation or review evidence.

## Do Not Use When

- The main need is sequencing the change — use [aws-lambda-change-planning.md](./aws-lambda-change-planning.md).
- The concern is cost at scale rather than failure behavior — use [performance-review.md](./performance-review.md).
- The concern is exploitability — use [secure-code-review.md](./secure-code-review.md).

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

## Quality Bar

- Every risk recorded is tied to this change, not to the platform in general.
- Duplicate delivery and partial failure each have a stated handling, even if that handling is "not applicable, because".
- Missing evidence is named specifically enough to be produced.
- The list is short enough to act on, ranked by material impact.

## Failure Modes

- Treating a passing happy-path test as proof that the change is production-ready.
- Turning the checklist into a generic platform review unrelated to the actual story.
- Requiring ideal observability for every small change instead of focusing on material risks.

## Related

- [aws-lambda-change-planning.md](./aws-lambda-change-planning.md) — sequencing the change these risks apply to.
- [aws-lambda-runtime-reuse.md](./aws-lambda-runtime-reuse.md) — timeout budgeting specifics.
- [change-set-review.md](./change-set-review.md) — the review this feeds for serverless diffs.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
