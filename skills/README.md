[Home](../README.md) · [AI.md](../AI.md) · [Agents](../agents/README.md) · [Skills](./README.md) · [Prompts](../prompts/README.md) · [Workflows](../workflows/README.md) · [Knowledge](../knowledge/README.md) · [Templates](../templates/README.md)

# Skills

Atomic capabilities reusable across agents, prompts, and workflows. Each one names when it applies, when it does not, the method, and the quality bar its output must clear.

Prefer names that describe visible behavior over names that imply hidden model internals.

New skills: copy [../templates/skill-template.md](../templates/skill-template.md).

## Available skills

### Delivery

Role-independent of any stack; used by the team in [../agents/README.md](../agents/README.md).

| Skill | Purpose |
| --- | --- |
| [request-triage.md](./request-triage.md) | Classify, decompose, and size a request, then recommend the lightest sufficient path |
| [task-brief-normalization.md](./task-brief-normalization.md) | Turn a request into a brief with scope, labeled assumptions, and a definition of done |
| [acceptance-criteria-authoring.md](./acceptance-criteria-authoring.md) | Observable criteria with stable `AC-1…n` IDs, marked explicit or derived |
| [contract-first-work-breakdown.md](./contract-first-work-breakdown.md) | Fix contracts, then split work into packages with disjoint owned paths |
| [acceptance-evidence-traceability.md](./acceptance-evidence-traceability.md) | Map each criterion to cited evidence and name the gaps |
| [acceptance-test-authoring.md](./acceptance-test-authoring.md) | Black-box tests written from criteria and contract, one named scenario per criterion |
| [independent-verification.md](./independent-verification.md) | Decide completion from real runs and cited artifacts, not from claims |
| [validation-disposition.md](./validation-disposition.md) | Route a verification outcome: accept, rework, replan, or escalate |

### Review

| Skill | Purpose |
| --- | --- |
| [change-set-review.md](./change-set-review.md) | Correctness, design fit, and scope drift, plus routing to the specialist reviews |
| [secure-code-review.md](./secure-code-review.md) | Trust boundaries, authorization, injection sinks, secrets, supply chain |
| [performance-review.md](./performance-review.md) | Complexity, I/O and query patterns, allocation, concurrency, caching, with measurement |
| [test-suite-quality-review.md](./test-suite-quality-review.md) | Whether tests would fail if behavior broke: assertions, coverage, seams, flakiness |

### Context economy

| Skill | Purpose |
| --- | --- |
| [token-budget-planning.md](./token-budget-planning.md) | Effort, context, and stop rules per step, so spend tracks risk |
| [context-pack-construction.md](./context-pack-construction.md) | Pointer sets that let another role start without re-exploring |
| [artifact-token-audit.md](./artifact-token-audit.md) | Waste in instruction artifacts, with savings and the cost of each cut |

### Frontend (stack-agnostic)

| Skill | Purpose |
| --- | --- |
| [frontend-component-design.md](./frontend-component-design.md) | Thin views, injected services, deliberate state placement |
| [frontend-api-client-seam.md](./frontend-api-client-seam.md) | One typed client boundary, validated responses, mockable before the backend exists |
| [frontend-ui-states-and-accessibility.md](./frontend-ui-states-and-accessibility.md) | Every reachable state designed; keyboard and assistive-technology support |
| [frontend-component-testing.md](./frontend-component-testing.md) | User-visible behavior tested at the component seam, mapped to criteria |

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
| [dotnet-options-and-http.md](./dotnet-options-and-http.md) | Validated options, factory-managed HTTP clients, logging, shutdown |

### AWS Lambda (.NET)

| Skill | Purpose |
| --- | --- |
| [aws-lambda-dotnet-handler-composition.md](./aws-lambda-dotnet-handler-composition.md) | Thin entry, DI bootstrap, trigger-correct responses |
| [aws-lambda-dotnet-serialization-and-reuse.md](./aws-lambda-dotnet-serialization-and-reuse.md) | Serializer options, cold-start reuse, `RemainingTime` budget |

### xUnit

| Skill | Purpose |
| --- | --- |
| [dotnet-10-xunit-seam-testing.md](./dotnet-10-xunit-seam-testing.md) | Behavior at seams, criteria mapping, async tests |
| [dotnet-10-xunit-fixtures-and-fakes.md](./dotnet-10-xunit-fixtures-and-fakes.md) | Fixtures, substitutes, integration hosting |

## Composition

Skills are loaded on demand: name the ones a task needs, by path, and the executor follows them for that task. Load only what the task requires — see [../knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md).

In a delivery run, each role in [../agents/README.md](../agents/README.md) lists its default skills, and the dispatch packet's `SKILLS` key adds the task-specific ones — typically the stack skills for one work package. A specialist loads only what the packet names.

Shared contracts live under [../knowledge/](../knowledge/README.md); skills link them rather than restating them.

---

[↑ Back to AI-Hub](../README.md)
