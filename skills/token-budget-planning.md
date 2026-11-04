---
title: "Token Budget Planning"
type: skill
summary: "Allocate effort and context across a run's steps so spend tracks risk, with explicit stop rules instead of open-ended exploration."
tags:
  - skills
  - tokens
  - planning
  - orchestration
status: draft
version: 0.1.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - planned steps or work packages
  - risk profile
outputs:
  - budget class and effort per step
  - stop rules
  - steps to skip
---

# Token Budget Planning

## Summary

Decide what each step of a run is allowed to spend, in effort and in context, so the expensive depth lands on the risky decisions and the mechanical steps stay cheap.

## Use When

- A multi-step run is about to start and the steps differ sharply in risk.
- Exploration could expand without a natural stopping point.
- The same work will run repeatedly and the cost per run matters.

## Do Not Use When

- The run is a single bounded step; a budget adds ceremony without a decision.
- The need is the pointers themselves — use [context-pack-construction.md](./context-pack-construction.md).
- The cost lives in the artifacts rather than the run — use [artifact-token-audit.md](./artifact-token-audit.md).

## Inputs

- Required:
  - the planned steps or work packages, with their dependencies
- Optional:
  - repository size and familiarity
  - prior runs of the same shape and what they cost
  - a deadline or cost ceiling from the client

## Method

1. Rank the steps by consequence of error, not by size. A design decision and a rename are not the same spend even when both touch one file.
2. Assign each step a class:
   - **light** — mechanical, reversible, cheaply re-run.
   - **standard** — ordinary delivery work with a clear landing zone.
   - **deep** — design, security, and verification judgement, where being wrong is expensive and hard to detect.
3. Give each step a stop rule in observable terms: a search count, a file count, or a condition such as "report after the second failed hypothesis". A step with no stop rule has an unbounded budget.
4. Name the steps to skip for this request, and why. Skipping with a reason is a budget decision; skipping silently is a gap.
5. Protect the non-negotiable spend. Independent verification and the safety checks are never the place to economize, because a cheap pass is worth nothing.
6. Decide what is shared rather than repeated: one context pack serving several specialists beats each one exploring.
7. Set the escalation rule: what a specialist does when it will exceed its budget. The default is to report progress and the blocker, never to silently spend more.
8. State the expected shape of the run — which steps carry the depth — so a reviewer can see whether the spend matched the risk.

## Quality Bar

- Every planned step has a class, a stop rule, and a one-line justification.
- Skipped steps are listed with reasons, not omitted.
- No verification or safety step is classed `light` purely to save cost.
- The budget is expressed in observable limits, not in vague instructions to be efficient.

## Failure Modes

- Uniform budgets, which overspend on the trivial and underspend on the decisive.
- Economizing on verification, which converts a cost saving into an undetected defect.
- Stop rules a specialist cannot evaluate from inside its own task.
- Treating the budget as a cap to hit rather than a limit that triggers a report.

## Related

- [request-triage.md](./request-triage.md) — the classification this budget is built on.
- [context-pack-construction.md](./context-pack-construction.md) — the shared context the budget assumes.
- [../knowledge/orchestrated-delivery-protocol.md](../knowledge/orchestrated-delivery-protocol.md) — the `BUDGET` packet key this fills.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- A budget never overrides a safety clause or a required confirmation.
