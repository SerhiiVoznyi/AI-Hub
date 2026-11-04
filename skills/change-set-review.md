---
title: "Change Set Review"
type: skill
summary: "Review a diff for correctness, design fit, and scope drift against the approved plan, routing specialist depth to the review panel."
tags:
  - skills
  - delivery
  - code-review
  - correctness
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - run-commands
inputs:
  - change set or diff
  - approved plan
outputs:
  - findings with severity
  - routing decision for specialist review
  - approval decision
---

# Change Set Review

## Summary

Review a change set against the plan it was supposed to implement: correctness, design fit, and anything that drifted outside the approved scope. Depth in security, performance, and test quality belongs to the specialist skills this one routes to.

## Use When

- A change is being reviewed before acceptance or merge.
- A reviewer needs a consistent severity scale instead of a list of opinions.
- Scope drift needs catching while it is still cheap to unwind.

## Do Not Use When

- The concern is exploitability — use [secure-code-review.md](./secure-code-review.md).
- The concern is cost at scale — use [performance-review.md](./performance-review.md).
- The concern is whether the tests would catch a regression — use [test-suite-quality-review.md](./test-suite-quality-review.md).
- The question is whether the criteria are met — use [independent-verification.md](./independent-verification.md).

## Inputs

- Required:
  - the diff and the list of changed files
  - the approved plan or work packages
- Optional:
  - the acceptance criteria and verification results
  - the design skills the implementer was bound to
  - prior review findings

## Method

1. Read the diff first. Open other files only when a specific finding depends on them.
2. Triage the risk surface before reviewing in depth, and record which specialist reviews the change needs: an attacker-reachable boundary, a cost driver at scale, or tests carrying the regression safety net. Route those; do not duplicate them here.
3. Check conformance: does the change implement the approved packages, and does anything fall outside them? A file nobody owned is a finding.
4. Check correctness on the paths the diff touches: null and absent values, async and cancellation, error handling, concurrency, resource cleanup.
5. Check design against the project's existing patterns and the bound skills, not against personal preference.
6. Check the shallow pass on each specialist surface, enough to decide routing: an unvalidated input, an obvious call inside a loop, an assertion that proves nothing. Flag and route; leave the depth to the specialist.
7. Assign severity — `blocker`, `major`, `minor`, `nit` — and let only `blocker` and `major` withhold approval. Cite `path:line` and say why it matters.
8. Merge specialist findings when they return: drop duplicates, keep the highest severity for a shared root cause, and issue one verdict.

## Quality Bar

- Every finding cites `path:line`, carries a severity, and states the consequence.
- The routing decision is explicit, including specialist reviews deliberately skipped and why.
- Approval rests on the diff, never on the implementer's description.
- A merged verdict reports each finding once, with its origin.

## Failure Modes

- Approving on the description rather than the diff.
- Style preferences raised at a severity that blocks delivery.
- Re-opening the approved design as if it were an implementation defect; that is a scope concern for the plan owner.
- Doing a shallow security or performance pass and treating it as the specialist review.
- Listing findings with no severity, leaving the owner to guess what blocks.

## Related

- [secure-code-review.md](./secure-code-review.md), [performance-review.md](./performance-review.md), [test-suite-quality-review.md](./test-suite-quality-review.md) — the specialist reviews this one routes to.
- [serverless-operability-checks.md](./serverless-operability-checks.md) — operability surface for serverless changes.
- [../knowledge/orchestrated-delivery-protocol.md](../knowledge/orchestrated-delivery-protocol.md) — how a panel lead dispatches and merges.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- When a finding concerns a possible secret, cite `path:line` only and mark the value `REDACTED`.
