# Skills

Use this folder for atomic capabilities that can be reused across prompts, agents, and workflows.

Prefer names that describe visible behavior (naming examples only: `structured-reasoning.md`, `evidence-synthesis.md`), rather than names that imply hidden model internals.

Use [../templates/skill-template.md](../templates/skill-template.md) to start new skill definitions.

## Available Skills

- [story-brief-normalization.md](./story-brief-normalization.md): turns a user story into a clarified brief with boundaries, assumptions, and observable completion criteria for orchestrator and planner use.
- [aws-lambda-change-planning.md](./aws-lambda-change-planning.md): helps the planner sequence Lambda work across handlers, integrations, configuration, risks, and acceptance criteria.
- [serverless-operability-checks.md](./serverless-operability-checks.md): adds production-minded checks for retries, idempotency, timeout safety, observability, and configuration risk.
- [typescript-design.md](./typescript-design.md): language-level TypeScript rules with strict typing and an object-oriented default for feature surfaces and boundaries.
- [nodejs-backend-implementation.md](./nodejs-backend-implementation.md): Node.js runtime concerns including composition root, dependency injection through classes, configuration, and lifecycle.
- [aws-lambda-implementation.md](./aws-lambda-implementation.md): **Node.js / TypeScript** Lambda thin handler adapter + injected service class with typed event contracts.
- [typescript-jest-test-design.md](./typescript-jest-test-design.md): Jest coverage for TypeScript code at stable seams, with typed fixtures and deliberate mocking at injected interfaces.
- [acceptance-evidence-traceability.md](./acceptance-evidence-traceability.md): maps each approved criterion to concrete evidence so completion claims and review decisions stay aligned.
- [validation-disposition.md](./validation-disposition.md): helps the validator distinguish `pass`, `rework`, and `replan` based on evidence quality, implementation defects, and planning gaps.
- [dotnet-10-csharp-design.md](./dotnet-10-csharp-design.md): idiomatic C# for .NET 10 (`net10.0`), nullable reference types, async, and DI-friendly class boundaries.
- [dotnet-backend-implementation.md](./dotnet-backend-implementation.md): ASP.NET Core and generic .NET hosting—composition root, options, logging, `HttpClient` factory, graceful shutdown.
- [aws-lambda-dotnet-implementation.md](./aws-lambda-dotnet-implementation.md): C# Lambda entry as a thin adapter with injectable services, serialization, and timeout-aware calls (does not require the TypeScript Lambda skill).
- [dotnet-10-csharp-test-design.md](./dotnet-10-csharp-test-design.md): xUnit strategies and evidence expectations at interface seams for .NET 10 C#.

## Composition

Skill binding for the orchestrated planner, executor, and validator flow is **prompt-driven**. The user or triggering prompt supplies a per-role **task skills manifest** (repository-root paths such as `skills/foo.md`); the orchestrator forwards the full manifest on every handoff. Start from [../prompts/orchestrated-execution-with-skills.md](../prompts/orchestrated-execution-with-skills.md), which includes example manifests for a TypeScript, Node.js, and Lambda stack and for a .NET 10 C# Lambda stack.

Shared contracts (handoffs, return shapes, output brevity, safety) live under [../knowledge/](../knowledge/)—skills should link them, not restate them.
