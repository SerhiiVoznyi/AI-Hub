---
title: "Orchestrated Handoff Protocol"
type: knowledge
tags:
  - knowledge
  - orchestration
  - handoff
  - multi-agent
status: reviewed
version: 0.1.0
last_reviewed: 2026-08-01
tooling: agnostic
inputs:
  - orchestrated multi-agent run
outputs:
  - topology and loop rules
---

# Summary

Compact topology for the four-agent orchestrated pattern. Agents and prompts link here instead of restating communication rules.

# Topology

- Only the **orchestrator** communicates with the user.
- Planner, executor, and validator **never** communicate with each other; every exchange is orchestrator-mediated.
- Clarifications, blockers, and rework always return to the orchestrator.

# Allowed loop

1. Normalize brief (orchestrator) → plan (planner) → review/approve (orchestrator).
2. Execution gate: if acceptance criteria and validator rules are jointly unsatisfiable, resolve with user or planner — do not start the executor.
3. Execute (executor) → validate (validator).
4. On `pass`: final user response. On `rework`: focused executor request. On `replan`: planner with failed assumptions. On missing user input: ask the user.

# Task skills manifest

- Triggering prompt supplies `orchestrator_skills`, `planner_skills`, `executor_skills`, `validator_skills` (repo-root paths).
- Orchestrator attaches the **full** manifest unchanged on every specialist handoff.
- Specialists apply **only** their role list; empty list → clarification/blocker, no invented methodology.
- Manifest changes need user approval via the orchestrator.

# Package shapes

Emit packages per [agent-return-contracts.md](./agent-return-contracts.md). Keep runtime text short per [execution-output-discipline.md](./execution-output-discipline.md).
