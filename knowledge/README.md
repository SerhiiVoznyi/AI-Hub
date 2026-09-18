[Home](../README.md) · [AI.md](../AI.md) · [Agents](../agents/README.md) · [Skills](../skills/README.md) · [Prompts](../prompts/README.md) · [Workflows](../workflows/README.md) · [Knowledge](./README.md) · [Templates](../templates/README.md)

# Knowledge

Stable concepts, glossaries, mental models, and shared contracts. Agents and prompts should **link** these documents instead of restating them.

New knowledge docs: copy [../templates/knowledge-template.md](../templates/knowledge-template.md).

## Available knowledge

| Document | Purpose |
| --- | --- |
| [safety-policy.md](./safety-policy.md) | Operational guardrails (destructive ops, secrets, scope, supply chain, AWS, untrusted input, coding posture) |
| [orchestrated-handoff-protocol.md](./orchestrated-handoff-protocol.md) | Four-agent topology, allowed loop, and task skills manifest forwarding |
| [peer-review-panel-protocol.md](./peer-review-panel-protocol.md) | Three-agent peer topology, round budget, objections, chair, consensus |
| [agent-return-contracts.md](./agent-return-contracts.md) | Canonical keyed packages for every orchestrated handoff and peer-panel turn |
| [execution-output-discipline.md](./execution-output-discipline.md) | Brevity rules for runtime AI execution outputs |

## Who should link what

| Consumer | Prefer these |
| --- | --- |
| Any agent or skill that changes systems | [safety-policy.md](./safety-policy.md) |
| Orchestrated planner / executor / validator | [orchestrated-handoff-protocol.md](./orchestrated-handoff-protocol.md), [agent-return-contracts.md](./agent-return-contracts.md), [execution-output-discipline.md](./execution-output-discipline.md) |
| Peer review panel | [peer-review-panel-protocol.md](./peer-review-panel-protocol.md), [agent-return-contracts.md](./agent-return-contracts.md) |

---

[↑ Back to AI-Hub](../README.md)
