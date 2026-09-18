[Home](../README.md) · [AI.md](../AI.md) · [Agents](../agents/README.md) · [Skills](./README.md) · [Prompts](../prompts/README.md) · [Workflows](../workflows/README.md) · [Knowledge](../knowledge/README.md) · [Templates](../templates/README.md)

# Skills

Atomic capabilities reusable across prompts, agents, and workflows.

Prefer names that describe visible behavior (e.g. `structured-reasoning.md`, `evidence-synthesis.md`) over names that imply hidden model internals.

New skills: copy [../templates/skill-template.md](../templates/skill-template.md).

## Available skills

### Story & validation

| Skill | Purpose |
| --- | --- |
| [story-brief-normalization.md](./story-brief-normalization.md) | Clarified brief with boundaries, assumptions, and observable completion criteria |
| [acceptance-evidence-traceability.md](./acceptance-evidence-traceability.md) | Maps each approved criterion to concrete evidence |
| [validation-disposition.md](./validation-disposition.md) | Distinguishes `pass`, `rework`, and `replan` from evidence quality |

### TypeScript / Node.js / Lambda

| Skill | Purpose |
| --- | --- |
| [typescript-design.md](./typescript-design.md) | Strict typing and OOP default for TypeScript surfaces |
| [nodejs-backend-implementation.md](./nodejs-backend-implementation.md) | Composition root, DI through classes, configuration, lifecycle |
| [aws-lambda-implementation.md](./aws-lambda-implementation.md) | Node.js/TS thin handler + injected service with typed events |
| [aws-lambda-change-planning.md](./aws-lambda-change-planning.md) | Sequences Lambda work across handlers, integrations, and risks |
| [serverless-operability-checks.md](./serverless-operability-checks.md) | Retries, idempotency, timeouts, observability, config risk |
| [typescript-jest-test-design.md](./typescript-jest-test-design.md) | Jest at stable seams with typed fixtures and deliberate mocks |

### .NET / C#

| Skill | Purpose |
| --- | --- |
| [dotnet-10-csharp-design.md](./dotnet-10-csharp-design.md) | Idiomatic C# for .NET 10 (`net10.0`) |
| [dotnet-backend-implementation.md](./dotnet-backend-implementation.md) | ASP.NET Core / generic hosting composition and lifecycle |
| [aws-lambda-dotnet-implementation.md](./aws-lambda-dotnet-implementation.md) | C# Lambda thin adapter with injectable services |
| [dotnet-10-csharp-test-design.md](./dotnet-10-csharp-test-design.md) | xUnit strategies at interface seams for .NET 10 |

## Composition

Skill binding for the orchestrated planner / executor / validator flow is **prompt-driven**. Supply a per-role **task skills manifest** (paths like `skills/foo.md`); the orchestrator forwards it on every handoff.

Start from [orchestrated-execution-with-skills.md](../prompts/orchestrated-execution-with-skills.md) (includes TypeScript/Node/Lambda and .NET 10 C# Lambda example manifests).

Shared contracts live under [../knowledge/](../knowledge/README.md) — skills should link them, not restate them.

---

[↑ Back to AI-Hub](../README.md)
