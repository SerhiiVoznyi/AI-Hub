---
title: "Workflow Template"
type: template
summary: "Starter for a multi-step sequence: roles, routing, steps with exit criteria, checkpoints, and failure handling."
tags:
  - templates
  - workflows
  - starter
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities: []
inputs:
  - task request
outputs:
  - repeatable process
---

# Workflow Template

<!-- Copy into workflows/. Use a workflow only when the sequence itself is the value; a single-actor procedure belongs in prompts/ or skills/. -->
<!-- Section order below is fixed. Optional sections may be dropped, never reordered. Delete every comment before committing. -->

## Summary

<!-- One short paragraph: what the sequence delivers end to end, and who owns the sequence. -->

## Use When

- Situation that justifies the full sequence rather than a single step.

## Roles

<!-- Who performs each part. Link agent files when the workflow runs on a team. -->

| Role | Responsibility in this workflow |
| --- | --- |
| `[example-agent.md](../agents/example-agent.md)` | What it contributes |

## Inputs

- Required: what must exist before step 1.
- Optional: what shortens or sharpens the run.

## Routing

<!-- Optional but strongly preferred: size the sequence to the request so small work does not pay for the full run. -->

| Request | Path |
| --- | --- |
| Small case | Which steps apply |
| Full case | All steps |

## Steps

<!-- Each step names an owner, its input, its output, and the exit criterion that lets the next step begin. -->

1. **Step name.** Owner. Input. Output. Exit criterion.

## Checkpoints

<!-- Where a human decides. Name the trigger and what cannot proceed without approval. -->

- Approval point, and what is blocked until it is granted.

## Failure Handling

<!-- What happens when a step fails: retry, rework, replan, or escalate, with the limit on each loop. -->

- Failure case, the response, and the loop limit.

## Outputs

- What exists when the workflow completes.

## Related

<!-- Relative links only. Replace the example below. -->

- `[../knowledge/example-contract.md](../knowledge/example-contract.md)` — the rules this sequence relies on.

## Safety

- Follow [../knowledge/safety-policy.md](../knowledge/safety-policy.md) and [../knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
