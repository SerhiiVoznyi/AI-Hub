# Skills

Use this folder for atomic capabilities that can be reused across prompts, agents, and workflows.

Prefer names that describe visible behavior, such as `structured-reasoning.md` or `evidence-synthesis.md`, rather than names that imply hidden model internals.

Use [../templates/skill-template.md](../templates/skill-template.md) to start new skill definitions.

## Available Skills

- [story-brief-normalization.md](./story-brief-normalization.md): turns a user story into a clarified brief with boundaries, assumptions, and observable completion criteria for orchestrator and planner use.
- [aws-lambda-change-planning.md](./aws-lambda-change-planning.md): helps the planner sequence Lambda work across handlers, integrations, configuration, risks, and acceptance criteria.
- [serverless-operability-checks.md](./serverless-operability-checks.md): adds production-minded checks for retries, idempotency, timeout safety, observability, and configuration risk.
- [typescript-design.md](./typescript-design.md): language-level TypeScript rules with strict typing and an object-oriented default for feature surfaces and boundaries.
- [nodejs-backend-implementation.md](./nodejs-backend-implementation.md): Node.js runtime concerns including composition root, dependency injection through classes, configuration, and lifecycle.
- [aws-lambda-implementation.md](./aws-lambda-implementation.md): Lambda execution discipline using a thin handler adapter and an injected service class with typed event contracts.
- [typescript-jest-test-design.md](./typescript-jest-test-design.md): Jest coverage for TypeScript code at stable seams, with typed fixtures and deliberate mocking at injected interfaces.
- [acceptance-evidence-traceability.md](./acceptance-evidence-traceability.md): maps each approved criterion to concrete evidence so completion claims and review decisions stay aligned.
- [validation-disposition.md](./validation-disposition.md): helps the validator distinguish `pass`, `rework`, and `replan` based on evidence quality, implementation defects, and planning gaps.

## Suggested Composition

- Planner: `story-brief-normalization`, `aws-lambda-change-planning`, `serverless-operability-checks`, `typescript-jest-test-design`
- Executor: `typescript-design`, `nodejs-backend-implementation`, `aws-lambda-implementation`, `typescript-jest-test-design`, `acceptance-evidence-traceability`, `serverless-operability-checks`
- Validator: `validation-disposition`, `acceptance-evidence-traceability`, `serverless-operability-checks`, `typescript-jest-test-design`
