[Home](../README.md) · [AI.md](../AI.md) · [Agents](../agents/README.md) · [Skills](../skills/README.md) · [Prompts](../prompts/README.md) · [Workflows](../workflows/README.md) · [Knowledge](../knowledge/README.md) · [Templates](./README.md)

# Templates

Starter files for new artifacts. Each one carries the frontmatter schema below, a fixed section order, and authoring comments to delete before committing.

## Available templates

| Template | Use for |
| --- | --- |
| [agent-template.md](./agent-template.md) | A delivery role with modes, a quality bar, and a return package → [../agents/](../agents/README.md) |
| [skill-template.md](./skill-template.md) | One atomic capability an agent or prompt loads on demand → [../skills/](../skills/README.md) |
| [prompt-template.md](./prompt-template.md) | A copyable prompt plus the wrapper that documents it → [../prompts/](../prompts/README.md) |
| [workflow-template.md](./workflow-template.md) | A multi-step sequence where the ordering is the value → [../workflows/](../workflows/README.md) |
| [knowledge-template.md](./knowledge-template.md) | A shared contract other artifacts cite instead of restating → [../knowledge/](../knowledge/README.md) |

## Choosing a template

| The thing you are writing | Template |
| --- | --- |
| A repeatable technique or judgement, reusable across tasks | skill |
| A role someone or something plays, with boundaries and a hand-back | agent |
| Text a human copies and sends to an executor | prompt |
| An ordering of steps across roles, with checkpoints | workflow |
| A rule set two or more artifacts must share | knowledge |

Two tests before adding anything:

- **One concept per file.** If the draft needs the word "also", it is probably two artifacts.
- **No second source of truth.** If a rule already lives in `knowledge/`, link it; never restate it.

## Frontmatter schema

Every artifact starts with this block. Fields appear in this order.

| Field | Required | Values |
| --- | --- | --- |
| `title` | yes | Quoted title case; must match the document's H1 |
| `type` | yes | `agent`, `skill`, `prompt`, `workflow`, `knowledge`, `template` |
| `summary` | yes | One sentence, at most 160 characters, enough to route on without opening the file |
| `tags` | yes | Lowercase kebab-case list |
| `status` | yes | `draft`, `reviewed`, `deprecated` |
| `version` | yes | Semantic version of the artifact |
| `last_reviewed` | yes | ISO date (`YYYY-MM-DD`) |
| `capabilities` | yes | Closed list below; `[]` for reference documents that only get read |
| `effort` | agents only | `light`, `standard`, `deep` |
| `inputs` | yes | What the artifact consumes |
| `outputs` | yes | What it produces |

### Capabilities

What an executor must be able to do to run the artifact. It describes the capability, never the product, and adapter permissions are derived from it.

| Value | Meaning |
| --- | --- |
| `read-files` | Read and search the target's files |
| `edit-files` | Create or modify files |
| `run-commands` | Execute shell commands, builds, or tests |
| `web-access` | Fetch external network resources |
| `delegate` | Dispatch work to another agent and collect its result |
| `ask-user` | Put a question to the human and wait for the answer |

### Effort

A hint for executors that can vary reasoning depth per dispatch. `light` for mechanical work, `standard` for ordinary delivery, `deep` for design, security, and verification judgement.

## Body rules

1. The H1 is the title from the frontmatter. Every other heading is H2.
2. Follow the template's section order. Optional sections may be dropped, never reordered or renamed.
3. Cross-references are relative links in a `## Related` section. No bare backtick filenames.
4. Every `## Safety` section links both [safety-policy.md](../knowledge/safety-policy.md) and [scoped-context-discipline.md](../knowledge/scoped-context-discipline.md), and restates neither.
5. Keep artifacts dense. Prefer tables and imperative bullets over prose; every line should change what the reader does.

## How to contribute

1. Pick the smallest fitting folder, per [AI.md](../AI.md).
2. Copy the matching template and fill the frontmatter first.
3. Write the body, delete the authoring comments, and keep the section order.
4. Link the artifact from that folder's README index.

---

[↑ Back to AI-Hub](../README.md)
