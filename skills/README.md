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

### TypeScript language

| Skill | Purpose |
| --- | --- |
| [typescript-oop-design.md](./typescript-oop-design.md) | Classes behind interfaces with constructor injection |
| [typescript-boundary-typing.md](./typescript-boundary-typing.md) | `unknown` narrowing, discriminated unions, typed errors, strictness |

### Node.js runtime

| Skill | Purpose |
| --- | --- |
| [nodejs-composition-root.md](./nodejs-composition-root.md) | Single composition root, injected adapters, side-effect-free imports |
| [nodejs-configuration.md](./nodejs-configuration.md) | Typed config loaded once with fail-fast validation |
| [nodejs-async-lifecycle.md](./nodejs-async-lifecycle.md) | Rejection handling, outbound timeouts, graceful shutdown |

### AWS Lambda (Node.js / TypeScript)

| Skill | Purpose |
| --- | --- |
| [aws-lambda-handler-composition.md](./aws-lambda-handler-composition.md) | Thin handler over an injected service with typed events |
| [aws-lambda-runtime-reuse.md](./aws-lambda-runtime-reuse.md) | Warm-start client reuse and invocation time budget |

### Jest

| Skill | Purpose |
| --- | --- |
| [typescript-jest-seam-testing.md](./typescript-jest-seam-testing.md) | Criteria mapped to scenarios at public seams |
| [typescript-jest-fixtures-and-mocks.md](./typescript-jest-fixtures-and-mocks.md) | Typed fixtures and interface-level test doubles |

### Serverless (stack-agnostic)

| Skill | Purpose |
| --- | --- |
| [aws-lambda-change-planning.md](./aws-lambda-change-planning.md) | Sequences Lambda work across handlers, integrations, and risks |
| [serverless-operability-checks.md](./serverless-operability-checks.md) | Retries, idempotency, timeouts, observability, config risk |

### .NET language

| Skill | Purpose |
| --- | --- |
| [dotnet-10-csharp-oop-design.md](./dotnet-10-csharp-oop-design.md) | Interfaces, constructor injection, records vs classes on `net10.0` |
| [dotnet-10-csharp-nullability-and-async.md](./dotnet-10-csharp-nullability-and-async.md) | Nullable reference types, cancellation, typed failures |

### .NET hosting

| Skill | Purpose |
| --- | --- |
| [dotnet-composition-and-di.md](./dotnet-composition-and-di.md) | One composition path with deliberate service lifetimes |
| [dotnet-options-and-http.md](./dotnet-options-and-http.md) | Validated options, `IHttpClientFactory`, logging, shutdown |

### AWS Lambda (.NET)

| Skill | Purpose |
| --- | --- |
| [aws-lambda-dotnet-handler-composition.md](./aws-lambda-dotnet-handler-composition.md) | Thin entry, DI bootstrap, trigger-correct responses |
| [aws-lambda-dotnet-serialization-and-reuse.md](./aws-lambda-dotnet-serialization-and-reuse.md) | Serializer options, cold-start reuse, `RemainingTime` budget |

### xUnit

| Skill | Purpose |
| --- | --- |
| [dotnet-10-xunit-seam-testing.md](./dotnet-10-xunit-seam-testing.md) | Behavior at seams, criteria mapping, async tests |
| [dotnet-10-xunit-fixtures-and-fakes.md](./dotnet-10-xunit-fixtures-and-fakes.md) | Fixtures, substitutes, `WebApplicationFactory` integration |

## Composition

Skill binding for the orchestrated planner / executor / validator flow is **prompt-driven**. Supply a per-role **task skills manifest** (paths like `skills/foo.md`); the orchestrator forwards it on every handoff.

Start from [orchestrated-execution-with-skills.md](../prompts/orchestrated-execution-with-skills.md) (includes TypeScript/Node/Lambda and .NET 10 C# Lambda example manifests).

Shared contracts live under [../knowledge/](../knowledge/README.md) — skills should link them, not restate them.

---

[↑ Back to AI-Hub](../README.md)
