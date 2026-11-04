---
title: "Frontend API Client Seam"
type: skill
summary: "Put every backend call behind one typed client interface so the UI depends on the contract and can be built and tested before the backend exists."
tags:
  - skills
  - frontend
  - boundary
  - integration
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - API contract
  - UI work package
outputs:
  - typed client boundary
  - mockable seam
  - boundary error handling
---

# Frontend API Client Seam

## Summary

Put every call to the backend behind one typed client interface, so the UI depends on the contract rather than on transport details, and can be built and tested before the backend exists.

## Use When

- A UI work package depends on an API that is agreed but not yet built.
- Fetch calls, URLs, or response shapes are spreading through components.
- Backend responses need validating before they reach the view.

## Do Not Use When

- The concern is where the client is owned and injected — use [frontend-component-design.md](./frontend-component-design.md).
- The concern is how failures are presented — use [frontend-ui-states-and-accessibility.md](./frontend-ui-states-and-accessibility.md).
- The boundary is server-side; for Node.js service boundaries use [typescript-boundary-typing.md](./typescript-boundary-typing.md).

## Inputs

- Required:
  - the agreed API contract: paths, payloads, status codes, error shapes
  - the project's existing client, auth, and error-handling conventions
- Optional:
  - generated types or schema definitions
  - retry, caching, or offline requirements

## Method

1. Define the seam as an interface in the UI's own terms — one method per operation the UI needs, taking and returning domain shapes, not transport envelopes.
2. Implement that interface once against the real transport. Keep base URLs, headers, auth, serialization, and status handling inside it.
3. Treat responses as untrusted input. Validate and narrow at the seam, and reject unknown shapes there rather than letting them reach components; see [typescript-boundary-typing.md](./typescript-boundary-typing.md).
4. Translate transport failures into a small set of typed outcomes the UI can render: not found, unauthorized, validation rejected, conflict, transport failure. Components should never branch on a status code.
5. Implement a contract-faithful fake of the same interface when the backend is not ready, and build the UI against it. A fake that drifts from the contract hides integration defects, so change both together.
6. Keep cross-cutting policy — timeouts, retries, cancellation on unmount or navigation, token refresh — in the implementation, not in components.
7. Never put a secret or long-lived credential in client code or build-time configuration.

## Quality Bar

- No component references a URL, header, status code, or transport envelope.
- Every response is narrowed at the seam before a component sees it.
- Every failure the contract allows maps to a typed outcome the UI can render.
- The fake and the real implementation satisfy the same interface and the same contract.

## Failure Modes

- Fetch calls inline in components, so the contract has no single owner and no single place to mock.
- Passing raw transport responses into the view, which couples rendering to backend wire format.
- A hand-written mock that returns shapes the contract does not allow, producing a UI that breaks on first integration.
- Retry or refresh logic duplicated per call site, with inconsistent behavior.

## Related

- [frontend-component-design.md](./frontend-component-design.md) — where the client is injected and owned.
- [frontend-ui-states-and-accessibility.md](./frontend-ui-states-and-accessibility.md) — how each outcome is presented.
- [typescript-boundary-typing.md](./typescript-boundary-typing.md) — narrowing and typed failures.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Treat every backend response, URL parameter, and stored value as untrusted input.
