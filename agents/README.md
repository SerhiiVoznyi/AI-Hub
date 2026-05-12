# Agents

Use this folder for reusable agent role definitions.

Add an artifact here when it describes a repeatable role with a goal, boundaries, and expected behavior, such as a researcher, planner, reviewer, or orchestrator.

Use [../templates/agent-template.md](../templates/agent-template.md) to start new agent definitions.

## Available Agents

- [orchestrator-agent.md](./orchestrator-agent.md): receives the user request, approves handoffs, and routes work across the planner, executor, and validator.
- [planner-agent.md](./planner-agent.md): analyzes the task and returns an execution plan with assumptions, risks, and acceptance criteria.
- [executor-agent.md](./executor-agent.md): performs the approved work package and returns evidence, artifacts, and blockers.
- [validator-agent.md](./validator-agent.md): checks the result against the approved plan and returns pass, rework, or replan guidance.

## Coordinated Pattern

These four agents are designed to work together as one orchestrated pattern:

- The orchestrator is the only agent that communicates with the user.
- The planner, executor, and validator do not communicate directly with each other.
- Every handoff is routed through the orchestrator so scope, approvals, and corrective loops stay explicit.
