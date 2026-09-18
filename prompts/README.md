[Home](../README.md) · [AI.md](../AI.md) · [Agents](../agents/README.md) · [Skills](../skills/README.md) · [Prompts](./README.md) · [Workflows](../workflows/README.md) · [Knowledge](../knowledge/README.md) · [Templates](../templates/README.md)

# Prompts

Reusable prompt patterns and task setups — wording, structure, and sequencing for recurring work.

New prompts: copy [../templates/prompt-template.md](../templates/prompt-template.md).

## Available prompts

### Orchestrated execution

| Prompt | Purpose |
| --- | --- |
| [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md) | Orchestrator → planner → executor → validator with a per-role task skills manifest |
| [orchestrated-aws-lambda-nodejs-story.md](./orchestrated-aws-lambda-nodejs-story.md) | Same flow, fixed Node.js / AWS Lambda manifest; story under `## Story` |
| [orchestrated-dotnet-10-csharp-task.md](./orchestrated-dotnet-10-csharp-task.md) | Same flow, fixed .NET 10 / C# 14 + xUnit manifest (no Lambda); task under `## Task` |
| [orchestrated-evaluation-remediation.md](./orchestrated-evaluation-remediation.md) | Four-agent remediation of a bounded slice of Key Findings from [project-evaluation.md](./project-evaluation.md) |

### Evaluation & review

| Prompt | Purpose |
| --- | --- |
| [project-evaluation.md](./project-evaluation.md) | Principal-Engineer codebase audit across 14 criteria with scored evidence and a tokenized verdict |
| [story-ready-for-dev-evaluation.md](./story-ready-for-dev-evaluation.md) | Sprint-readiness via INVEST + Definition of Ready; Ready / Not Ready verdict |
| [story-development-completion-evaluation.md](./story-development-completion-evaluation.md) | Done / Not Done audit against the codebase with acceptance-criterion evidence |
| [story-acceptance-criteria-confirmation.md](./story-acceptance-criteria-confirmation.md) | Feasibility of pasted acceptance criteria (`AC-1…n`) against the target project |
| [test-state-evaluation.md](./test-state-evaluation.md) | Skills-parameterized test-suite triage; fixes tests/mocks only (`{{TEST_SKILLS}}`) |
| [bug-fix-diagnosis-and-resolution.md](./bug-fix-diagnosis-and-resolution.md) | Bug-report triage with root cause, offending code table, and gated fix application |
| [peer-review-panel.md](./peer-review-panel.md) | Philosopher / AI expert / software engineer peer panel with bounded rounds |

## Related

- Agents: [../agents/README.md](../agents/README.md)
- Skills: [../skills/README.md](../skills/README.md)
- Contracts: [../knowledge/README.md](../knowledge/README.md)

---

[↑ Back to AI-Hub](../README.md)
