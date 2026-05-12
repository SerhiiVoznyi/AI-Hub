---
title: "Node TypeScript Backend Implementation"
type: skill
tags:
  - skills
  - nodejs
  - typescript
  - backend
  - execution
status: draft
version: 0.1.0
last_reviewed: 2026-05-12
tooling: agnostic
inputs:
  - approved work package
  - codebase conventions
  - integration boundaries
outputs:
  - implementation approach
  - change summary
  - completion evidence
related:
  - ../skills/README.md
  - ../agents/executor-agent.md
  - ./jest-backend-test-design.md
  - ./acceptance-evidence-traceability.md
  - ./serverless-operability-checks.md
---

# Summary

Implement backend story work in Node.js and TypeScript with small seams, clear typing, and evidence that maps to the approved plan.

## Use When

- The executor is implementing Lambda handlers, backend services, adapters, or supporting utilities in Node.js and TypeScript.
- The work package is approved and the remaining task is disciplined delivery within scope.
- The story needs code changes that remain maintainable under testing and review.

## Inputs

- Required:
  - approved objective and ordered steps
  - codebase conventions and module boundaries
- Optional:
  - event payload examples
  - downstream service contracts
  - prior validation findings or rework instructions

## Method

1. Confirm the approved scope, then change the smallest useful seam instead of refactoring unrelated areas.
2. Keep Lambda handlers thin by isolating business rules, transport translation, and side-effect boundaries into focused functions or services.
3. Use explicit TypeScript types at inputs, outputs, and integration boundaries. Narrow unknown data early instead of passing loose shapes through the system.
4. Make error handling intentional: define expected failure paths, preserve useful context, and avoid hidden fallthrough behavior.
5. Gather evidence while implementing, including changed artifacts, relevant test updates, and any limits or blockers that still matter to validation.

## Failure Modes

- Putting business logic, validation, and infrastructure concerns directly into the handler with no clear seams.
- Introducing `any`, unclear data contracts, or silent error swallowing in code that depends on external inputs.
- Expanding scope through opportunistic refactors without orchestrator approval.
- Use `aws-lambda-change-planning.md` instead when the work is still at planning stage rather than implementation.
