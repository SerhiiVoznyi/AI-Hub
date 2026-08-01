---
title: "Agent Return Contracts"
type: knowledge
tags:
  - knowledge
  - contracts
  - handoff
  - multi-agent
  - peer-panel
status: reviewed
version: 0.2.0
last_reviewed: 2026-08-01
tooling: agnostic
inputs:
  - orchestrated agent handoff
outputs:
  - keyed package fields
---

# Summary

Canonical keyed return shapes for orchestrated handoffs. Emit these keys; put free text only inside them. Do not invent parallel prose sections that repeat the same facts.

# Contracts

## planner → orchestrator

| Key | Meaning |
|-----|---------|
| `objective` | Outcome the plan delivers |
| `ordered_steps` | Actionable steps in order |
| `dependencies` | Prerequisites and blockers |
| `assumptions` | Explicit labeled assumptions |
| `risks` | Named risks (include safety flags) |
| `acceptance_criteria` | Observable checks for the validator |

## orchestrator → executor

| Key | Meaning |
|-----|---------|
| `approved_objective` | Approved goal |
| `approved_steps` | Steps the executor may run |
| `constraints` | Non-goals and hard limits |
| `required_evidence` | What must come back |
| `task_skills_manifest` | Full four-list manifest |

## executor → orchestrator

| Key | Meaning |
|-----|---------|
| `work_summary` | What was done |
| `artifacts` | Paths or outputs produced |
| `evidence` | Criterion → proof (path + one line) |
| `blockers` | What stopped progress |
| `follow_up_needs` | Optional next needs; omit if empty |

## validator → orchestrator

| Key | Meaning |
|-----|---------|
| `status` | `pass` \| `rework` \| `replan` |
| `findings` | Evidence-backed issues or confirmations |
| `missing_evidence` | Criteria still unproven |
| `scope_concerns` | Unapproved expansion or drift |
| `recommended_next_action` | Smallest useful next step |

## orchestrator → user (final)

| Key | Meaning |
|-----|---------|
| `outcome` | User-facing result state |
| `summary` | Short result narrative |
| `evidence_refs` | Paths proving the outcome |
| `open_risks` | Residual risks; omit if none |

## peer agent → panel

| Key | Meaning |
|-----|---------|
| `position` | Conclusion within the agent's own domain |
| `reasoning` | Why the position holds |
| `objections` | Target agent, claim, what would resolve it |
| `agreement` | `agree` \| `disagree` \| `conditional` |
| `unresolved` | Points still open after this round |

## chair → user (final)

| Key | Meaning |
|-----|---------|
| `outcome` | `consensus` \| `no_consensus` |
| `summary` | Short result narrative |
| `disputed_points` | Point, holder, resolving evidence; omit on consensus |
| `open_risks` | Residual risks; omit if none |

# Runtime rule

Omit empty optional keys. Prefer the field names above (snake_case) in structured packages so orchestrator routing stays unambiguous.
