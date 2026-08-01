# Agents

Use this folder for reusable agent role definitions.

Add an artifact here when it describes a repeatable role with a goal, boundaries, and expected behavior, such as a researcher, planner, reviewer, or orchestrator.

Use [../templates/agent-template.md](../templates/agent-template.md) to start new agent definitions.

## Available Agents

- [orchestrator-agent.md](./orchestrator-agent.md): receives the user request, approves handoffs, and routes work across the planner, executor, and validator.
- [planner-agent.md](./planner-agent.md): analyzes the task and returns an execution plan with assumptions, risks, and acceptance criteria.
- [executor-agent.md](./executor-agent.md): performs the approved work package and returns evidence, artifacts, and blockers.
- [validator-agent.md](./validator-agent.md): checks the result against the approved plan and returns pass, rework, or replan guidance.
- [philosopher-agent.md](./philosopher-agent.md): **panel member** — examines meaning, ethics, hidden assumptions, reasoning quality, and conceptual consistency.
- [ai-expert-agent.md](./ai-expert-agent.md): **panel member** — owns model behavior, data, evaluation methodology, and AI-specific safety and limitations.
- [software-engineer-agent.md](./software-engineer-agent.md): **panel member** — owns code structure, tests, delivery, correctness, maintainability, and performance.

## Coordinated Pattern

These four agents form one orchestrated pattern. Topology, return shapes, and output brevity live in knowledge—do not restate them in prompts:

- [../knowledge/orchestrated-handoff-protocol.md](../knowledge/orchestrated-handoff-protocol.md)
- [../knowledge/agent-return-contracts.md](../knowledge/agent-return-contracts.md)
- [../knowledge/execution-output-discipline.md](../knowledge/execution-output-discipline.md)
- [../knowledge/safety-policy.md](../knowledge/safety-policy.md)

Skill binding is prompt-driven via the **task skills manifest**; see [../prompts/orchestrated-execution-with-skills.md](../prompts/orchestrated-execution-with-skills.md).

## Peer Review Panel

The philosopher, ai-expert, and software-engineer form a separate pattern. They are peers who review each other directly, with a chair chosen per task rather than a fixed orchestrator mediating every exchange—so the orchestrated topology above does not apply to them.

- [../knowledge/peer-review-panel-protocol.md](../knowledge/peer-review-panel-protocol.md): rounds, objection admissibility, chair selection, and termination.
- [../prompts/peer-review-panel.md](../prompts/peer-review-panel.md): launches a panel run; skill binding is optional and prompt-supplied.

Return shapes ([../knowledge/agent-return-contracts.md](../knowledge/agent-return-contracts.md)), output brevity, and safety are shared with the orchestrated pattern.
