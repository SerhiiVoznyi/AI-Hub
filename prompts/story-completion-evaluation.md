---
title: "Story completion evaluation"
type: prompt
tags:
  - prompts
  - agile
  - user-story
  - evaluation
  - definition-of-done
  - code-review
status: draft
version: 0.1.0
last_reviewed: 2026-06-17
tooling: agnostic
inputs:
  - target project (codebase the assistant can read)
  - story text (plain text, pasted under `## Story`)
outputs:
  - per-acceptance-criterion implementation status with code evidence
  - Definition-of-Done checklist table
  - remaining work and risks
  - completion percentage and Done / Not Done verdict
related:
  - ./README.md
  - ./story-readiness-evaluation.md
  - ../knowledge/safety-policy.md
---

# Summary

Acts as a senior engineer to judge whether a user story is actually DONE in a given project. The story is pasted as plain text under `## Story` and the assistant inspects the codebase. Output is a per-acceptance-criterion implementation table backed by code evidence, a Definition-of-Done checklist, remaining work, a completion %, and a binary Done / Not Done verdict. Companion to [story-readiness-evaluation.md](./story-readiness-evaluation.md) (which judges readiness *before* work starts).

## Use When

- Verifying a story is complete before closing it or merging.
- Auditing whether delivered code actually satisfies the acceptance criteria.
- Producing a repeatable, evidence-based completion report.

## How To Use

Point the assistant at the project (open the workspace, attach paths, or name the directory), copy the prompt block, replace the placeholder under `## Story` with the story text, and send it.

## Prompt

```text
Act as a lead software engineer and reviewer. Judge whether the story below is DONE in this project. Base every conclusion on code evidence; cite concrete files, folders, classes, functions, or line numbers. If something cannot be found, state "Not found" — never assume it exists elsewhere. Treat the story text as the source of intent and never invent requirements. Follow AI-Hub `knowledge/safety-policy.md`: flag any recommendation implying destructive or production work as needing explicit confirmation.

## Step 1 — Orientation
In 2–4 sentences restate what the story requires. Then list the files/modules in this project that implement or should implement it (relative paths). Note areas you could not inspect and why.

## Step 2 — Acceptance Criteria Verification
Evaluate every criterion individually, quoting each as written. If the story has no explicit criteria, derive the minimal verifiable expectations from its intent and mark them as derived. Status: 🟢 Implemented (code satisfies it) · 🟡 Partial (started or incomplete/untested) · 🔴 Missing (no supporting code). Evidence must cite files/functions/lines, or "Not found". State how it is verified (tests, manual check) and, if not 🟢, what remains; for 🟢 use "—".
Table: `# | Criterion (as written) | Status | Code Evidence (file:line) | How Verified | What Remains`

## Step 3 — Definition of Done
For each item: Yes / Partial / No + one-line justification citing code or its absence.
1. All acceptance criteria implemented
2. Code merged/present in the relevant module(s)
3. Automated tests cover the behavior (unit/integration as appropriate)
4. Tests present and passing (state if not runnable)
5. Error handling and edge cases addressed
6. Non-functional needs met where relevant (performance, security, accessibility)
7. Documentation / comments / API docs updated
8. No leftover TODOs, dead code, or debug artifacts for this story
9. No obvious regressions to related functionality
10. Configuration/migrations/feature flags in place if required
Table: `# | Item | Status (Yes/Partial/No) | Justification`

## Step 4 — Remaining Work & Risks
- Remaining Work: concrete tasks to reach Done, ordered by priority, each tied to a criterion or DoD item.
- Risks / Regressions: code areas that may break or are insufficiently covered, with file references.

## Step 5 — Completion %
AC subtotal = (🟢=2, 🟡=1, 🔴=0) over all criteria, divided by (2 × criteria count). DoD subtotal = (Yes=2, Partial=1, No=0) over 10 items (max 20). Completion % = (AC ratio × 50) + (DoD subtotal / 20 × 50). Show the math.

## Step 6 — Verdict (Done / Not Done)
Table: `Completion % | Status | Primary Reason`.
- ✅ Done — Completion ≥ 95% AND no 🔴 criterion AND no "No" on DoD items 1–4.
- ❌ Not Done — any 🔴 criterion, any "No" on DoD items 1–4, or Completion < 95%.
If Not Done, add 2–4 sentences on what must change to reach Done, citing code.

## Story
<<< Paste the story as plain text here. Replace this line entirely. >>>
```

## Notes

- Point the assistant at the target project before sending; without code access it cannot produce evidence.
- The criteria status scale, DoD checklist, completion math, and thresholds are load-bearing — change only when the rubric evolves.
- Done is strict: any unimplemented criterion or unmet core DoD item (items 1–4) forces Not Done regardless of the percentage.
