[Home](../README.md) · [AI.md](../AI.md) · [Skills](../skills/README.md) · [Prompts](../prompts/README.md) · [Workflows](../workflows/README.md) · [Knowledge](./README.md) · [Templates](../templates/README.md)

# Knowledge

Stable concepts, glossaries, mental models, and shared contracts. Prompts and skills should **link** these documents instead of restating them.

New knowledge docs: copy [../templates/knowledge-template.md](../templates/knowledge-template.md).

## Available knowledge

| Document | Purpose |
| --- | --- |
| [safety-policy.md](./safety-policy.md) | Operational guardrails (destructive ops, secrets, scope, supply chain, AWS, untrusted input, coding posture; points to scoped context for read thrift) |
| [scoped-context-discipline.md](./scoped-context-discipline.md) | Limit reads/searches to named or task-necessary paths (input token thrift) |

## Who should link what

| Consumer | Prefer these |
| --- | --- |
| Any prompt or skill that changes systems | [safety-policy.md](./safety-policy.md) |
| Any prompt or skill that reads a repository | [scoped-context-discipline.md](./scoped-context-discipline.md) |

---

[↑ Back to AI-Hub](../README.md)
