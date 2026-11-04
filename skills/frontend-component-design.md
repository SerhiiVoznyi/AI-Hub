---
title: "Frontend Component Design"
type: skill
summary: "Keep views thin and declarative, pushing decisions, I/O, and shared state behind named units the component depends on."
tags:
  - skills
  - frontend
  - design
  - components
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - approved work package
  - UI scope
outputs:
  - component boundaries
  - placement of state and logic
---

# Frontend Component Design

## Summary

Keep view components thin and declarative, and push decisions, I/O, and shared state behind named units the component depends on, so logic is testable without rendering.

## Use When

- Deciding how to split a screen or a feature into components.
- Choosing where a piece of state, a rule, or a fetch belongs.
- Reviewing a component that has grown past what one reader can hold.

## Do Not Use When

- The concern is the boundary to the backend — use [frontend-api-client-seam.md](./frontend-api-client-seam.md).
- The concern is what the user sees and can operate — use [frontend-ui-states-and-accessibility.md](./frontend-ui-states-and-accessibility.md).
- The code is not a UI component; for service-layer structure use [typescript-oop-design.md](./typescript-oop-design.md).

## Inputs

- Required:
  - the approved work package and its criteria
  - the project's existing component and state conventions
- Optional:
  - design mockups
  - existing shared components and layout primitives

## Method

1. Separate the two kinds of component the project already distinguishes: view components that render props and emit events, and container components that own state and talk to services.
2. Keep business rules, validation, formatting decisions, and data shaping out of the view. Put them in a unit the view calls, so a rule can be tested without a render.
3. Depend on an injected interface rather than reaching for a module-level client. In TypeScript this follows [typescript-oop-design.md](./typescript-oop-design.md): the service is a class behind an interface, and the component receives it through the project's own provider or props.
4. Give each component one responsibility and one source of truth for its state. State needed by two siblings moves up or into shared state; state needed by one stays local.
5. Reuse the project's existing components, layout primitives, styling system, routing, and state management. Introducing a second way to do any of these is a plan-level decision, not an implementation detail.
6. Keep the props surface small and typed at the boundary. A prop list that keeps growing is usually two components.
7. Let the existing directory and naming conventions decide placement; do not invent a parallel structure for one feature.

## Quality Bar

- Every business rule in the change can be tested without rendering a component.
- No component both owns state and renders a complex view without a stated reason.
- No new styling, state, or routing mechanism was introduced outside the plan.
- Each component's props are typed and justified by its single responsibility.

## Failure Modes

- A view component that fetches, validates, formats, and renders, so none of it can be tested in isolation.
- Business rules duplicated across components because no unit owns them.
- Shared state lifted into a global store when only two siblings need it.
- A new styling or state library added for one screen, splitting the project's conventions.

## Related

- [frontend-api-client-seam.md](./frontend-api-client-seam.md) — the boundary the container depends on.
- [frontend-ui-states-and-accessibility.md](./frontend-ui-states-and-accessibility.md) — what each state must render.
- [frontend-component-testing.md](./frontend-component-testing.md) — proving the resulting structure.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
