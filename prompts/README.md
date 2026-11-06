[Home](../README.md) · [AI.md](../AI.md) · [Agents](../agents/README.md) · [Skills](../skills/README.md) · [Prompts](./README.md) · [Workflows](../workflows/README.md) · [Knowledge](../knowledge/README.md) · [Templates](../templates/README.md)

# Prompts

Reusable prompt patterns: the copyable block, plus the wrapper that documents what it needs and what it returns.

Each prompt runs as a single executor acting as a Principal Software Engineer: every claim cited, reads scoped, and any change gated behind explicit authorization. There are two exceptions. [orchestrated-story-execution.md](./orchestrated-story-execution.md)'s executor is the orchestrator: it spawns the delivery team from [../agents/](../agents/README.md) and coordinates rather than implements. [documentation-and-ai-setup-benchmark.md](./documentation-and-ai-setup-benchmark.md)'s executor sends each benchmark item to a fresh sub-agent and grades the result, but never answers an item itself.

New prompts: copy [../templates/prompt-template.md](../templates/prompt-template.md).

## Available prompts

| Prompt | Purpose | Capabilities |
| --- | --- | --- |
| [project-evaluation.md](./project-evaluation.md) | Codebase audit across 14 criteria, with scored evidence, a tokenized verdict, and a dated report file | read, write |
| [documentation-evaluation.md](./documentation-evaluation.md) | Documentation-only audit across 8 criteria, returned as one table of score, confidence, evidence, and references, with checked claims, navigation probes, a tokenized verdict, and a dated report file | read, write |
| [documentation-and-ai-setup-benchmark.md](./documentation-and-ai-setup-benchmark.md) | Live benchmark of a project's docs and agent setup: a generated kit of 10 questions and 1 coding task, each run in a fresh sub-agent with a pause for you after every item, timed, graded against an answer key, and reported as tables with token columns from the provider usage page | read, write, run, delegate, ask |
| [story-acceptance-criteria-confirmation.md](./story-acceptance-criteria-confirmation.md) | Can this project build the story? Per-criterion feasibility, prerequisites, and a gated plan | read |
| [story-development-completion-evaluation.md](./story-development-completion-evaluation.md) | Was it built? Per-criterion status with verbatim code evidence, and what is left | read |
| [orchestrated-story-execution.md](./orchestrated-story-execution.md) | Delivers a pasted story with the agent team: the orchestrator staffs the run to the story, spawns sub-agents in waves, gates writes on approval, and closes on independent evidence | read, write, run, delegate, ask |
| [bug-fix-diagnosis-and-resolution.md](./bug-fix-diagnosis-and-resolution.md) | Bug triage with root cause, offending-code table, and a gated fix | read, write, run |
| [repository-knowledge-graph-creation.md](./repository-knowledge-graph-creation.md) | Builds or refreshes a project root's documentation layer from the folder as it exists now — a `docs/` knowledge base with the projects table and graph, a `README.md` and `docs/` per project, and a docs-first `AGENTS.md` — so agents navigate without searching it all | read, write |

## Related

- Skills: [../skills/README.md](../skills/README.md)
- Contracts: [../knowledge/README.md](../knowledge/README.md)
- Agents: [../agents/README.md](../agents/README.md) — delivery roles reuse these prompts as procedures. The business analyst runs the feasibility prompt, QA the completion prompt, and the architect the bug-fix prompt, rather than duplicating them. [orchestrated-story-execution.md](./orchestrated-story-execution.md) works the other way round: one prompt that drives the whole team.

---

[↑ Back to AI-Hub](../README.md)
