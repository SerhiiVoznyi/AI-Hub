---
title: "Peer Review Panel Protocol"
type: knowledge
tags:
  - knowledge
  - peer-panel
  - review
  - multi-agent
status: draft
version: 0.1.0
last_reviewed: 2026-08-01
tooling: agnostic
inputs:
  - three-agent peer review run
outputs:
  - round budget and objection rules
  - consensus or no_consensus outcome
---

# Summary

Compact collaboration rules for the three-agent peer review panel. Agents and prompts link here instead of restating them.

# Topology

- Peers review each other directly; there is no mediating role.
- This is **not** the orchestrator-mediated topology in [orchestrated-handoff-protocol.md](./orchestrated-handoff-protocol.md). Do not apply that document to a panel run.
- Each turn starts with the emitting agent's keyword prefix so attribution stays clear when one runtime plays all three roles.

# Rounds

1. Each agent analyzes the task independently, before seeing any peer position.
2. Each agent then reviews peer reasoning and conclusions.
3. Challenge is expected: name unstated assumptions, weak reasoning, missing evidence, and disagree when warranted.
4. At most **three** review rounds after the independent pass.

# Objections

- Admissible only when it names a specific assumption, missing evidence, or trade-off. Objections raised to appear rigorous are inadmissible.
- Withdrawal requires the objector to state what satisfied it. Consensus is never reached by suppressing or yielding an objection.
- Cross-domain objections to reasoning quality are advisory: they do not block a domain conclusion the objector does not own.

# Chair

- The invoking prompt may name a chair. Otherwise the chair owns the task's primary deliverable: software-engineer for implementation, ai-expert for model or evaluation work, philosopher for normative or conceptual questions.
- Only the chair emits the final user-facing response. It aggregates and never overrides a standing objection.

# Termination

- `COMPLETE` only when all three agents explicitly agree within the round budget.
- Budget exhausted without unanimity → `no_consensus`, reporting which points remain disputed, which agent holds each objection, and what additional information would resolve it.

# Package shapes

Emit packages per [agent-return-contracts.md](./agent-return-contracts.md) (peer agent → panel, chair → user). Keep runtime text short per [execution-output-discipline.md](./execution-output-discipline.md).
