---
title: "Validation Disposition"
type: skill
summary: "Turn verification results into one routing decision: accept, rework, replan, or escalate, by classifying the kind of defect."
tags:
  - skills
  - delivery
  - validation
  - decision-making
status: draft
version: 0.3.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - verification results
  - review findings
  - approved plan
outputs:
  - disposition
  - smallest useful next action
---

# Validation Disposition

## Summary

Turn verification results into one routing decision — accept, rework, replan, or escalate — by separating implementation defects from planning defects and from missing information.

## Use When

- Verification came back short and the next step is not obvious.
- A result is partly correct and "needs changes" would hide which kind of change.
- A loop needs an exit condition instead of another round.

## Do Not Use When

- The verdict itself is still unsettled — use [independent-verification.md](./independent-verification.md).
- The question is how to classify an incoming request — use [request-triage.md](./request-triage.md).

## Inputs

- Required:
  - the approved plan and criteria
  - the verification verdict, findings, and evidence
- Optional:
  - prior dispositions for the same issue
  - risks recorded during planning
  - client clarifications

## Method

1. Re-read the approved scope first, so the disposition does not quietly widen the task.
2. Classify each outstanding item: missing proof, incorrect behavior within a sound plan, or a flaw in the plan itself.
3. **Accept** only when every critical criterion is met with evidence the verifier could cite.
4. **Rework** when the plan still holds and the implementation, tests, or evidence are incomplete. Send only the findings, to the specialist that produced the work.
5. **Replan** when the plan omitted necessary work, rested on an assumption that failed, or no longer matches the real task. Rework cannot fix a planning defect.
6. **Escalate** when the blocker is a decision, contract, credential, access, or environment the team cannot supply, or when the same issue has survived its rework budget.
7. Name the smallest useful next action, addressed to one owner, so the routing needs no interpretation.

## Quality Bar

- Every outstanding item is classified into exactly one category.
- The disposition names one owner and one next action.
- A rework decision lists only findings, never fixes.
- An escalation names exactly what is missing and who supplies it.

## Failure Modes

- Writing feedback that implicitly performs the fix instead of classifying it.
- Returning rework for a problem that only a plan change can solve, then repeating the round.
- Accepting a result because it looks plausible while the deciding evidence is missing.
- Escalating without naming exactly what is missing and who supplies it.

## Related

- [independent-verification.md](./independent-verification.md) — settling the verdict this routes.
- [../knowledge/orchestrated-delivery-protocol.md](../knowledge/orchestrated-delivery-protocol.md) — rework and escalation limits.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
