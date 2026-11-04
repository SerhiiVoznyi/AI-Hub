[Home](../README.md) · [AI.md](../AI.md) · [Agents](../agents/README.md) · [Skills](../skills/README.md) · [Prompts](../prompts/README.md) · [Workflows](../workflows/README.md) · [Knowledge](./README.md) · [Templates](../templates/README.md)

# Knowledge

Stable concepts and shared contracts. Agents, prompts, skills, and workflows **link** these documents and cite their numbered rules instead of restating them.

New knowledge docs: copy [../templates/knowledge-template.md](../templates/knowledge-template.md).

## Available knowledge

| Document | Purpose |
| --- | --- |
| [safety-policy.md](./safety-policy.md) | Operational guardrails: destructive operations, secrets, scope and approvals, supply chain, AWS, untrusted input, coding posture |
| [scoped-context-discipline.md](./scoped-context-discipline.md) | What may be read or searched into context, and how to bound it |
| [orchestrated-delivery-protocol.md](./orchestrated-delivery-protocol.md) | Delivery topology, dispatch packet, return packages, budgets, output economy, rework limits, final report |

## Who should link what

| Consumer | Prefer these |
| --- | --- |
| Anything that changes systems | [safety-policy.md](./safety-policy.md) |
| Anything that reads a repository | [scoped-context-discipline.md](./scoped-context-discipline.md) |
| Any role in [../agents/](../agents/README.md) | all three |

Cite a clause by number — "safety policy rule 12" — rather than quoting it.

---

[↑ Back to AI-Hub](../README.md)
