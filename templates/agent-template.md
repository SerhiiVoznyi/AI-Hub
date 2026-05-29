---
title: "Agent Template"
type: template
tags:
  - agents
  - starter
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - task goal
outputs:
  - completed task
related:
  - ../agents/README.md
---

# Summary

Describe the agent's purpose in one short paragraph.

## Responsibilities

- Primary responsibilities
- Decision boundaries
- Expected outputs

## Inputs

- Required context
- Optional context

## Process

1. Describe the default operating sequence.
2. Note any checkpoints or escalation paths.
3. Define when the agent should stop or hand off.

## Constraints

- What the agent must avoid
- Tooling assumptions, if any

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) for destructive operations, secrets, scope and approvals, supply chain, AWS safety, untrusted-input handling, and the OOP-default coding posture.
- Add role-specific enforcement only when it is not already covered in the policy **Enforcement** section.

## Skills

For orchestrated multi-agent use, skill binding is supplied by the **task skills manifest** in the triggering prompt (see `prompts/orchestrated-execution-with-skills.md`). List here only non-manifest conventions if this agent is ever used standalone.
