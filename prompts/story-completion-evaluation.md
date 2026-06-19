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
version: 0.2.0
last_reviewed: 2026-06-19
tooling: agnostic
inputs:
  - target project (codebase the assistant can read)
  - story text (plain text, pasted under `## Story`)
outputs:
  - result header with verdict, score, top blocker, and confidence
  - per-acceptance-criterion implementation status with code evidence
  - Definition-of-Done checklist table
  - remaining work and risks
  - completion percentage and Done / Not Done verdict
  - standardized handoff (status, findings, missing evidence, recommended next action)
related:
  - ./README.md
  - ./story-readiness-evaluation.md
  - ../knowledge/safety-policy.md
  - ../agents/orchestrator-agent.md
---

# Summary

Acts as a senior engineer to judge whether a user story is actually DONE in a given project. The story is pasted as plain text under `## Story` and the assistant inspects the codebase. Output opens with a fixed result header, then a per-acceptance-criterion implementation table backed by code evidence, a Definition-of-Done checklist, remaining work, a completion %, a binary Done / Not Done verdict, and a standardized handoff block keyed to the orchestrator's validator return shape (`status`, `findings`, `missing evidence`, `recommended next action`). Companion to [story-readiness-evaluation.md](./story-readiness-evaluation.md) (which judges readiness *before* work starts).

## Use When

- Verifying a story is complete before closing it or merging.
- Auditing whether delivered code actually satisfies the acceptance criteria.
- Producing a repeatable, evidence-based completion report.
- Acting as a validation gate inside an orchestrated multi-agent run (see [../agents/orchestrator-agent.md](../agents/orchestrator-agent.md)).

## How To Use

Point the assistant at the project (open the workspace, attach paths, or name the directory), copy the prompt block, replace the placeholder under `## Story` with the story text, and send it.

## Prompt

```text
Act as a lead software engineer and reviewer. Judge whether the story below is DONE in this project. Base every conclusion on code evidence; cite concrete files, folders, classes, functions, or line numbers. If something cannot be found, state "Not found" — never assume it exists elsewhere. Treat the story text as the source of intent and never invent requirements. Follow AI-Hub `knowledge/safety-policy.md`: flag any recommendation implying destructive or production work as needing explicit confirmation.

Status tokens (use the emoji AND the plain-text token together everywhere, e.g. "🟢 IMPLEMENTED"): 🟢 IMPLEMENTED · 🟡 PARTIAL · 🔴 MISSING.

If the story area below is empty or still contains the placeholder, or you cannot read the project's code at all, do not invent content. Emit only the Result Header with `Verdict: BLOCKED` (state the reason: no story provided, or no code access) and the Handoff with `status: BLOCKED` requesting the missing input, then stop.

## Result Header (output this first)
Four one-line named fields, in this exact order:
- Verdict: DONE | NOT_DONE | BLOCKED
- Score: <Completion %>% (omit or use n/a when BLOCKED)
- Top Blocker: <single most important blocker, or "none">
- Confidence: High | Medium | Low (based on how much of the relevant code you actually inspected)

## Step 1 — Orientation
In 2–4 sentences restate what the story requires. Then list the files/modules in this project that implement or should implement it (relative paths). Note areas you could not inspect and why.

## Step 2 — Acceptance Criteria Verification
Evaluate every criterion individually, quoting each as written. If the story has no explicit criteria, derive the minimal verifiable expectations from its intent and mark them as derived. Status: 🟢 IMPLEMENTED (code satisfies it) · 🟡 PARTIAL (started or incomplete/untested) · 🔴 MISSING (no supporting code). Evidence must cite files/functions/lines, or "Not found". State how it is verified (tests, manual check) and, if not 🟢 IMPLEMENTED, what remains; for 🟢 IMPLEMENTED use "—".
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
AC subtotal = (🟢 IMPLEMENTED=2, 🟡 PARTIAL=1, 🔴 MISSING=0) over all criteria, divided by (2 × criteria count). DoD subtotal = (Yes=2, Partial=1, No=0) over 10 items (max 20). Completion % = (AC ratio × 50) + (DoD subtotal / 20 × 50), rounded to the nearest whole number. Show the math.

## Step 6 — Consistency Check
Before the verdict, silently verify and fix any conflicts: (a) every criterion and DoD row cites code evidence or an explicit "Not found"; (b) every remaining-work item maps to a 🔴 MISSING/🟡 PARTIAL criterion or a No/Partial DoD item; (c) no criterion is double-counted; (d) the Result Header verdict, the Step 7 verdict, and the Completion % all agree under the rules below. Report this as one line: "Consistency check: passed" or list what you corrected.

## Step 7 — Verdict (Done / Not Done)
Table: `Completion % | Status | Primary Reason`.
- ✅ DONE — Completion ≥ 95% AND no 🔴 MISSING criterion AND no "No" on DoD items 1–4.
- ❌ NOT_DONE — any 🔴 MISSING criterion, any "No" on DoD items 1–4, or Completion < 95%.
If NOT_DONE, add 2–4 sentences on what must change to reach Done, citing code.

## Step 8 — Handoff (for orchestration)
Emit these four named fields verbatim so an orchestrator can route without parsing the tables above:
- status: DONE | NOT_DONE | BLOCKED
- findings: ordered list; each finding ties to a specific criterion or DoD item with its code evidence.
- missing evidence: criteria or DoD items where code was "Not found" or could not be verified (or "none").
- recommended next action: the smallest useful next step, ending with a suggested route — pass (story is done), rework (achievable code/test fixes under the current intent close the gaps), or replan (the story's requirements are missing, contradictory, or cannot be met as written).

## Story
<<< Paste the story as plain text here. Replace this line entirely. >>>
```

## Notes

- Point the assistant at the target project before sending; without code access it returns `BLOCKED` rather than guessing.
- The criteria status scale, DoD checklist, completion math, status tokens, and thresholds are load-bearing — change only when the rubric evolves.
- Done is strict: any unimplemented criterion or unmet core DoD item (items 1–4) forces Not Done regardless of the percentage.
- The Result Header and the Step 8 Handoff are stable anchors for automation: the Handoff field names (`status`, `findings`, `missing evidence`, `recommended next action`) and routes (`pass` / `rework` / `replan`) mirror the validator return shape in [../agents/orchestrator-agent.md](../agents/orchestrator-agent.md), so this prompt can act as a validation gate after execution.
- Orchestration routing: `status: DONE` → pass; `NOT_DONE` with achievable fixes → rework by the executor; `NOT_DONE` due to missing/contradictory requirements → replan; `BLOCKED` → request the story text or code access.
