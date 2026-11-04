[Home](../README.md) · [AI.md](../AI.md) · [Agents](../agents/README.md) · [Skills](../skills/README.md) · [Prompts](./README.md) · [Workflows](../workflows/README.md) · [Knowledge](../knowledge/README.md) · [Templates](../templates/README.md)

# Prompts

Reusable prompt patterns: the copyable block, plus the wrapper that documents what it needs and what it returns.

Each prompt runs as a single executor acting as a Principal Software Engineer: every claim cited, reads scoped, and any change gated behind explicit authorization.

New prompts: copy [../templates/prompt-template.md](../templates/prompt-template.md).

## Available prompts

| Prompt | Purpose | Capabilities |
| --- | --- | --- |
| [project-evaluation.md](./project-evaluation.md) | Codebase audit across 14 criteria, with scored evidence, a tokenized verdict, and a dated report file | read, write |
| [story-acceptance-criteria-confirmation.md](./story-acceptance-criteria-confirmation.md) | Can this project build the story? Per-criterion feasibility, prerequisites, and a gated plan | read |
| [story-development-completion-evaluation.md](./story-development-completion-evaluation.md) | Was it built? Per-criterion status with verbatim code evidence, and what is left | read |
| [bug-fix-diagnosis-and-resolution.md](./bug-fix-diagnosis-and-resolution.md) | Bug triage with root cause, offending-code table, and a gated fix | read, write, run |
| [repository-knowledge-graph-creation.md](./repository-knowledge-graph-creation.md) | Builds or refreshes a `kb/` knowledge graph so agents navigate a repository without reading it all | read, write, run |

## Related

- Skills: [../skills/README.md](../skills/README.md)
- Contracts: [../knowledge/README.md](../knowledge/README.md)
- Agents: [../agents/README.md](../agents/README.md) — delivery roles reuse these prompts as procedures. The business analyst runs the feasibility prompt, QA the completion prompt, and the architect the bug-fix prompt, rather than duplicating them.

---

[↑ Back to AI-Hub](../README.md)
