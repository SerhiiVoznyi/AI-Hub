---
title: "Frontend UI States And Accessibility"
type: skill
summary: "Make every reachable state a designed state, and every interaction operable by keyboard and announceable to assistive technology."
tags:
  - skills
  - frontend
  - accessibility
  - ux
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - UI work package
  - acceptance criteria
outputs:
  - complete state coverage
  - keyboard and assistive-technology support
---

# Frontend UI States And Accessibility

## Summary

Make every state a screen can reach a designed state, and make every interaction reachable without a mouse and announceable to assistive technology.

## Use When

- Building or reviewing any view that loads, submits, or fails.
- Acceptance criteria mention errors, permissions, empty data, or accessibility.
- A screen works when everything succeeds and is undefined when it does not.

## Do Not Use When

- The concern is component structure — use [frontend-component-design.md](./frontend-component-design.md).
- The concern is producing the typed outcomes — use [frontend-api-client-seam.md](./frontend-api-client-seam.md).
- The concern is proving the states — use [frontend-component-testing.md](./frontend-component-testing.md).

## Inputs

- Required:
  - the UI work package and its criteria
  - the outcomes the API client seam can return
- Optional:
  - the project's accessibility conventions and shared feedback components
  - design mockups for the non-happy states

## Method

1. Enumerate the states before writing the view: initial, loading, empty, partial, success, each distinct error, and unauthorized. Every state a component can reach needs a defined rendering.
2. Distinguish empty from failed. "No results" and "could not load" are different messages and different next actions for the user.
3. Make errors actionable: say what happened and what the user can do. Never render a raw exception, stack, or status code.
4. Keep submissions safe: disable or guard the control while in flight, show progress, and make a repeated submit harmless.
5. Preserve the user's input across a failure. Losing a filled form to a transient error is a defect, not a rare edge.
6. Use semantic elements first — buttons, links, lists, headings, native form controls. Reach for ARIA only when no semantic element expresses the role, and never to patch a non-semantic element that should have been semantic.
7. Give every control an accessible name, associate every input with a visible label, and never convey meaning by color alone.
8. Make everything operable by keyboard: logical tab order, visible focus, escape from overlays, and focus moved deliberately on route change, dialog open, and dialog close.
9. Announce asynchronous changes — validation errors, save results, loaded results — through a live region or by moving focus, so they are not silent to a screen reader.
10. Respect reduced-motion preferences, and keep text contrast within the project's accessibility target.

## Quality Bar

- Every state the component can reach has a defined rendering, including each distinct error.
- Every interactive element is reachable and operable by keyboard, with visible focus.
- Every control has an accessible name, and no meaning depends on color alone.
- Asynchronous outcomes are announced, not only rendered.

## Failure Modes

- Only the success path designed, leaving loading and error states as blank screens.
- A spinner that never resolves because the failure path forgot to clear it.
- A clickable element that is not focusable, so it cannot be reached or activated by keyboard.
- Focus left behind a closed dialog, stranding keyboard and screen-reader users.
- An error announced only by turning a field red.

## Related

- [frontend-api-client-seam.md](./frontend-api-client-seam.md) — the typed outcomes these states render.
- [frontend-component-testing.md](./frontend-component-testing.md) — proving each state and interaction.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Never surface internal diagnostics, tokens, or stack traces in user-visible error states.
