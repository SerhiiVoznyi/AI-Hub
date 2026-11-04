---
title: "Agent Template"
type: template
summary: "Starter for a principal-level delivery role: mission, expertise, modes, quality bar, escalation, and return package."
tags:
  - templates
  - agents
  - starter
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities: []
effort: standard
inputs:
  - dispatch packet
outputs:
  - return package
---

# Agent Template

<!-- Copy into agents/. Filename is <role>-agent.md. The file stays executor-agnostic: no vendor names, no tool-specific tool names, no absolute paths. -->
<!-- Set frontmatter `capabilities` to what the role genuinely needs; adapters derive their permissions from it. Set `effort` to light, standard, or deep. -->
<!-- Section order below is fixed. Optional sections may be dropped, never reordered. Delete every comment before committing. -->

## Mission

<!-- Two or three sentences: the outcome this role owns, and who it answers to. State the seniority the role is written for. -->

## Expertise

<!-- What a principal in this role knows that a competent one does not. Judgement and trade-off rules, not a tool list. These are the lines that raise output quality, so make them decidable. -->

- Competency, and the judgement it produces.
- Decision heuristic: when X and Y conflict, prefer Z because of W.

## Responsibilities

**Owns**

- The decisions and artifacts this role is accountable for.

**Does not own**

- Adjacent work that belongs to another role, named.

## Operating Modes

<!-- Omit when the role has exactly one mode. Otherwise name each mode the dispatch packet can request, with what changes between them. -->

| Mode | Purpose | Returns |
| --- | --- | --- |
| `mode-name` | What it does | Which return keys it fills |

## Inputs

- Required: what the dispatch packet must carry for this role to start.
- Optional: what improves the result when supplied.

## Method

<!-- Numbered and decidable. Include the stop condition: when to return done, blocked, or a question. -->

1. First step.
2. Decision point and the rule that settles it.
3. Stop condition.

## Quality Bar

<!-- Verified before returning. A reviewer can check each line against the return package alone. -->

- Condition that must hold before this role returns `done`.

## Escalation

<!-- When to stop and hand back instead of pressing on. Name the trigger and the recipient. -->

- Trigger, and what the role returns instead of continuing.

## Constraints

- Hard limits: scope, owned paths, read-only, no client contact, no self-approval.

## Return

<!-- Role-specific keys only. Common keys and their values live in the protocol. -->

| Key | Meaning |
| --- | --- |
| `status` | Per [../knowledge/orchestrated-delivery-protocol.md](../knowledge/orchestrated-delivery-protocol.md) |

## Skills

<!-- Default skills as relative links. The dispatch packet's SKILLS key adds task-specific ones; load only what is named. Replace the example below. -->

- `[../skills/example-skill.md](../skills/example-skill.md)` — what it contributes here.

## Safety

- Follow [../knowledge/safety-policy.md](../knowledge/safety-policy.md) and [../knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Obey [../knowledge/orchestrated-delivery-protocol.md](../knowledge/orchestrated-delivery-protocol.md) for topology, packets, and loop limits.
- Add a clause here only when this role carries a risk the policies do not already cover.
