# Skills

Use this folder for atomic capabilities that can be reused across prompts, agents, and workflows.

Prefer names that describe visible behavior, such as `structured-reasoning.md` or `evidence-synthesis.md`, rather than names that imply hidden model internals.

Use [../templates/skill-template.md](../templates/skill-template.md) to start new skill definitions.

## Available Skills

- [story-brief-normalization.md](./story-brief-normalization.md): turns a user story into a clarified brief with boundaries, assumptions, and observable completion criteria for orchestrator and planner use.
- [aws-lambda-change-planning.md](./aws-lambda-change-planning.md): helps the planner sequence Lambda work across handlers, integrations, configuration, risks, and acceptance criteria.
- [serverless-operability-checks.md](./serverless-operability-checks.md): adds production-minded checks for retries, idempotency, timeout safety, observability, and configuration risk.
- [node-typescript-backend-implementation.md](./node-typescript-backend-implementation.md): guides the executor on disciplined Node.js and TypeScript delivery within the approved work package.
- [jest-backend-test-design.md](./jest-backend-test-design.md): designs Jest coverage for backend and Lambda stories around behavior, edge cases, and traceable acceptance criteria.
- [acceptance-evidence-traceability.md](./acceptance-evidence-traceability.md): maps each approved criterion to concrete evidence so completion claims and review decisions stay aligned.
- [validation-disposition.md](./validation-disposition.md): helps the validator distinguish `pass`, `rework`, and `replan` based on evidence quality, implementation defects, and planning gaps.

## Suggested Composition

- Planner: `story-brief-normalization`, `aws-lambda-change-planning`, `serverless-operability-checks`, `jest-backend-test-design`
- Executor: `node-typescript-backend-implementation`, `jest-backend-test-design`, `acceptance-evidence-traceability`, `serverless-operability-checks`
- Validator: `validation-disposition`, `acceptance-evidence-traceability`, `serverless-operability-checks`, `jest-backend-test-design`
