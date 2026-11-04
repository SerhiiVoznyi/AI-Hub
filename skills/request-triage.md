---
title: "Request Triage"
type: skill
summary: "Classify an incoming request by type, uncertainty, and blast radius, then recommend the smallest path that still verifies the result."
tags:
  - skills
  - delivery
  - intake
  - routing
status: draft
version: 0.1.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - client request
outputs:
  - request classification
  - decomposition
  - recommended path
---

# Request Triage

## Summary

Decide what kind of work a request actually is, split it when it is several requests wearing one sentence, and recommend the lightest path that still produces a verified result.

## Use When

- A request arrives and the amount of process it deserves is not obvious.
- One sentence contains several deliverables, or a question wrapped around a change.
- The cost of over-processing a small request, or under-processing a risky one, is real.

## Do Not Use When

- The goal is clear and the task is to write the brief — use [task-brief-normalization.md](./task-brief-normalization.md).
- The criteria are the deliverable — use [acceptance-criteria-authoring.md](./acceptance-criteria-authoring.md).
- The request is a bug and the next question is the root cause, not the path.

## Inputs

- Required:
  - the request as stated
- Optional:
  - the target project, enough to judge blast radius
  - prior related requests, and how they went

## Method

1. Classify the request by what it asks for: a question, an investigation, a defect, a change, or a new capability. Classify by the outcome wanted, not by the verb used.
2. Split compound requests. Each part gets its own classification, and parts that can fail independently are separate work.
3. Score two axes, each high or low:
   - **Uncertainty:** is it clear what "done" means, and where the work lands?
   - **Blast radius:** what breaks if it is wrong — one screen, one service, or every caller?
4. Recommend a path from the two scores. Low and low needs one implementer and verification. High on either axis needs analysis and design first. High on both needs a client decision before anything else.
5. Name the parts that need no process at all. A question answered from one file should never enter a delivery cycle.
6. Detect disguised requests: a "quick fix" that changes a public contract, a "question" whose answer requires a migration. Classify by consequence, not by the asking.
7. List blocking questions only. A question is blocking when a plausible answer changes the classification or the path.

## Quality Bar

- Every part of the request has exactly one classification, and nothing is left unassigned.
- The recommended path names which steps to skip, not only which to run.
- Both axes are scored with a one-line reason each, pointing at evidence where the repository decides it.
- Blocking questions carry a suggested default; non-blocking observations are recorded separately, not asked.

## Failure Modes

- Classifying by the words used, so "just add a field" skips the contract review it needed.
- Routing everything down the full path because that feels safe; the cost lands on every small request.
- Splitting a single coherent change into parts that cannot be verified independently.
- Asking the client questions whose answers would not change anything.

## Related

- [task-brief-normalization.md](./task-brief-normalization.md) — once the path is chosen, turn the request into a brief.
- [token-budget-planning.md](./token-budget-planning.md) — convert the chosen path into per-step budgets.
- [../workflows/orchestrated-delivery.md](../workflows/orchestrated-delivery.md) — the routing table this skill feeds.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Triage reads to classify; it never starts the work it is classifying.
