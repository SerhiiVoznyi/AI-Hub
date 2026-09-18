[Home](../README.md) · [AI.md](../AI.md) · [Agents](./README.md) · [Skills](../skills/README.md) · [Prompts](../prompts/README.md) · [Workflows](../workflows/README.md) · [Knowledge](../knowledge/README.md) · [Templates](../templates/README.md)

# Agents

Reusable agent role definitions: a repeatable role with a goal, boundaries, and expected behavior.

New agents: copy [../templates/agent-template.md](../templates/agent-template.md).

## Available agents

### Orchestrated roles

| Agent | Role |
| --- | --- |
| [orchestrator-agent.md](./orchestrator-agent.md) | Receives the user request, approves handoffs, and routes work across planner, executor, and validator |
| [planner-agent.md](./planner-agent.md) | Analyzes the task and returns an execution plan with assumptions, risks, and acceptance criteria |
| [executor-agent.md](./executor-agent.md) | Performs the approved work package and returns evidence, artifacts, and blockers |
| [validator-agent.md](./validator-agent.md) | Checks the result against the approved plan and returns pass, rework, or replan guidance |

### Peer review panel

| Agent | Role |
| --- | --- |
| [philosopher-agent.md](./philosopher-agent.md) | Examines meaning, ethics, hidden assumptions, reasoning quality, and conceptual consistency |
| [ai-expert-agent.md](./ai-expert-agent.md) | Owns model behavior, data, evaluation methodology, and AI-specific safety and limitations |
| [software-engineer-agent.md](./software-engineer-agent.md) | Owns code structure, tests, delivery, correctness, maintainability, and performance |

## Coordinated pattern

Topology, return shapes, and output brevity live in knowledge — do not restate them in prompts:

- [orchestrated-handoff-protocol.md](../knowledge/orchestrated-handoff-protocol.md)
- [agent-return-contracts.md](../knowledge/agent-return-contracts.md)
- [execution-output-discipline.md](../knowledge/execution-output-discipline.md)
- [safety-policy.md](../knowledge/safety-policy.md)

Skill binding is prompt-driven via the **task skills manifest** — see [orchestrated-execution-with-skills.md](../prompts/orchestrated-execution-with-skills.md).

## Peer review panel

The philosopher, AI expert, and software engineer are peers who review each other directly, with a chair chosen per task (no fixed orchestrator mediating every exchange).

- [peer-review-panel-protocol.md](../knowledge/peer-review-panel-protocol.md) — rounds, objection admissibility, chair selection, termination
- [peer-review-panel.md](../prompts/peer-review-panel.md) — launches a panel run; skill binding is optional and prompt-supplied

Return shapes ([agent-return-contracts.md](../knowledge/agent-return-contracts.md)), output brevity, and safety are shared with the orchestrated pattern.

---

[↑ Back to AI-Hub](../README.md)
