---
title: "Peer review panel"
type: prompt
tags:
  - prompts
  - peer-panel
  - review
  - multi-agent
status: draft
version: 0.1.0
last_reviewed: 2026-08-01
tooling: agnostic
inputs:
  - topic under review
  - optional chair
  - optional skills manifest
outputs:
  - consensus or no_consensus verdict with disputed points
---

# Summary

Launch the three-agent peer review panel — philosopher, ai-expert, software-engineer — over one contested question. Peers review each other directly; a chair aggregates the final answer. Paths are repository-root relative.

## Use When

- The decision is contested across domains, the trade-offs are ambiguous, or the choice is high-stakes or irreversible — three independent passes plus adversarial review earn their roughly threefold cost only when a wrong answer is expensive to undo.
- You want disagreement recorded rather than smoothed away, including an explicit `no_consensus` outcome.
- **Not** for routine implementation, single-domain questions, or work already served by the orchestrated pattern in [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md).

## Prompt

```text
You are running the AI-Hub peer review panel. Load and follow from the repository root:

Agents (peers, no orchestrator):
- agents/philosopher-agent.md
- agents/ai-expert-agent.md
- agents/software-engineer-agent.md

Knowledge (do not restate; obey):
- knowledge/safety-policy.md
- knowledge/peer-review-panel-protocol.md
- knowledge/agent-return-contracts.md
- knowledge/execution-output-discipline.md

## Topic

{{TOPIC}}

## Chair

{{CHAIR}}

## Skills manifest (optional)

Optional. If present, it is authoritative for this run; resolve paths from the repository root.
Keys: philosopher_skills, ai_expert_skills, software_engineer_skills.
Each agent applies only its own list. An absent or empty manifest means no skill binding — it is not a blocker.

philosopher_skills:
ai_expert_skills:
software_engineer_skills:

## Start

Each agent analyzes the topic independently first, prefixing every turn with its own keyword. Then run at most three review rounds per the panel protocol. Emit packages per agent-return-contracts.md; keep outputs short per execution-output-discipline.md. Only the chair emits the final response.
```

## Notes

- Replace `{{TOPIC}}` with the concrete question, the options already on the table, and any hard constraints.
- Replace `{{CHAIR}}` with one role name, or delete the section to let the protocol pick the owner of the primary deliverable.
- Fill a skills list only when a document genuinely guides that role; today only `software_engineer_skills` has hub coverage.
- The panel decides; it does not implement. Authorize implementation explicitly in `{{TOPIC}}` if you want code written after consensus.
- `knowledge/safety-policy.md` always applies.
