---
title: "Contract First Work Breakdown"
type: skill
summary: "Fix the crossing contracts, then split work into packages with one owner, disjoint paths, and explicit dependencies."
tags:
  - skills
  - delivery
  - architecture
  - planning
status: draft
version: 0.2.1
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - approved acceptance criteria
  - target project structure
outputs:
  - fixed contracts
  - work packages with owned paths
  - dependency order
---

# Contract First Work Breakdown

## Summary

Fix the contracts first, then split the work into packages that can be dispatched independently: one owner, disjoint file ownership, explicit dependencies, and a done-when condition each.

## Use When

- Several roles must work on the same story without blocking or overwriting each other.
- A change crosses a boundary — service to service, backend to UI, producer to consumer.
- Work will be dispatched to executors that cannot negotiate with each other mid-task.

## Do Not Use When

- One person touches a handful of files in one layer; the breakdown costs more than it saves.
- The sequencing concern is Lambda-specific — use [aws-lambda-change-planning.md](./aws-lambda-change-planning.md).
- The criteria are not settled yet — use [acceptance-criteria-authoring.md](./acceptance-criteria-authoring.md) first.

## Inputs

- Required:
  - approved acceptance criteria
  - the modules, layers, and extension points the criteria touch
- Optional:
  - existing contracts and schemas
  - repository knowledge files (`AGENTS.md`, `AI.md` cards, a `kb/` graph)
  - operational or performance constraints

## Method

1. Define every crossing contract before any package that consumes it: endpoint shapes, payloads, events, schema changes, error cases. A contract is fixed when a consumer could be built against it without asking a question.
2. Cut packages along ownership, not along convenience. Each package names exactly one owning role.
3. Assign owned paths so no two packages that may run in parallel can edit the same file. If paths must overlap, sequence the packages instead.
4. Give each package the criteria it satisfies, so no criterion is orphaned and none is claimed twice.
5. State dependencies explicitly, by package ID. A package with no unmet dependency is dispatchable now.
6. Bind each package to the hub skills its stack needs, so the implementer loads rules rather than inventing them.
7. Give each package a done-when condition that someone else can check without reading the implementation.
8. Flag every package that touches a public contract, a migration, IAM, infrastructure, a new dependency, or a destructive step.

## Quality Bar

- Every criterion appears in exactly one package.
- No two packages marked parallel share an owned path.
- Every contract a package consumes is defined before that package is dispatchable.
- Each package's done-when condition is checkable without reading its implementation.

## Failure Modes

- Starting the consumer before its contract is fixed, which turns one change into two rewrites.
- Overlapping owned paths, which produces conflicts no single package owner can resolve.
- Packages sized to a role's convenience rather than to a verifiable outcome.
- A criterion that appears in no package, or in two.

## Related

- [acceptance-criteria-authoring.md](./acceptance-criteria-authoring.md) — the criteria this breakdown consumes.
- [aws-lambda-change-planning.md](./aws-lambda-change-planning.md) — serverless sequencing within a package.
- [context-pack-construction.md](./context-pack-construction.md) — the pointers each package is dispatched with.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- A plan may propose a flagged step; it may not assume approval for one.
