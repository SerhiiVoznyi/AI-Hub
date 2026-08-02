---
title: "Story readiness evaluation"
type: prompt
tags:
  - prompts
  - agile
  - user-story
  - evaluation
  - definition-of-ready
  - invest
status: draft
version: 0.2.0
last_reviewed: 2026-06-19
tooling: agnostic
inputs:
  - story text (plain text, pasted under `## Story`)
outputs:
  - result header with verdict, score, top blocker, and confidence
  - INVEST + Definition-of-Ready scored tables with evidence
  - per-acceptance-criterion status table with examples and remediation
  - blocking gaps, clarifying questions
  - readiness percentage and Ready / Not Ready verdict
  - standardized handoff (status, findings, missing evidence, recommended next action)
---

# Summary

Acts as a senior Product Owner to judge whether a user story is sprint-ready. The story is pasted as plain text under `## Story`; output opens with a fixed result header, then INVEST and Definition-of-Ready score tables, a per-acceptance-criterion table, gaps and questions, a readiness %, a binary Ready / Not Ready verdict, and a standardized handoff block keyed to the orchestrator's validator return shape (`status`, `findings`, `missing evidence`, `recommended next action`).

## Use When

- Triaging backlog items before refinement or sprint planning.
- Deciding if a story has enough detail to estimate and start.
- Producing a repeatable, comparable readiness score.
- Acting as a readiness gate inside an orchestrated multi-agent run (see [../agents/orchestrator-agent.md](../agents/orchestrator-agent.md)).

## How To Use

Copy the prompt block, replace the placeholder under `## Story` with the story text (title, description, criteria, notes — whatever exists), and send it.

## Prompt

```text
Act as a senior Product Owner and Agile delivery lead. Judge whether the story below is READY for a sprint. Base every conclusion only on the story text; never invent requirements or context. Treat anything missing as a gap, not an assumption. Follow AI-Hub `knowledge/safety-policy.md`: flag any recommendation implying destructive or production work as needing explicit confirmation.

Status tokens (use the emoji AND the plain-text token together everywhere, e.g. "🟢 READY"): 🟢 READY · 🟡 NEEDS_WORK · 🔴 NOT_READY.

If the story area below is empty or still contains the placeholder, do not invent content. Emit only the Result Header with `Verdict: BLOCKED (no story provided)` and the Handoff with `status: BLOCKED` requesting the story text, then stop.

## Result Header (output this first)
Four one-line named fields, in this exact order:
- Verdict: READY | NOT_READY | BLOCKED (no story provided)
- Score: <Readiness %>% (omit or use n/a when BLOCKED)
- Top Blocker: <single most important blocker, or "none">
- Confidence: High | Medium | Low (based on how complete and unambiguous the story text is)

## Step 1 — Understanding
In 2–4 sentences restate the ask, the user, and the intended outcome using only what the story states. List ambiguous terms or scope.

## Step 2 — INVEST
Score each 1–5 (5 = fully met). Evidence must quote the relevant story text, or "Not stated".
Independent · Negotiable · Valuable · Estimable · Small · Testable
Calibration anchors (apply to every dimension): 1 = not stated or contradicted by the text; 3 = partially addressed but vague, implicit, or incomplete; 5 = explicitly and unambiguously satisfied by quoted text. Use 2 and 4 for in-between cases.
Table: `Dimension | Score (1–5) | Evidence | Gap`

## Step 3 — Definition of Ready
For each item: Yes / Partial / No + one-line justification referencing the story.
1. Clear, outcome-focused title
2. Description with persona and goal ("As a … I want … so that …")
3. Specific, testable acceptance criteria
4. Scope boundaries (in and out of scope)
5. Dependencies and assumptions
6. Non-functional requirements where relevant (performance, security, accessibility, compliance)
7. Edge cases and error/failure behavior
8. Data/API/UI details sufficient to start
9. No blocking open questions
10. Estimable by the team
Table: `# | Item | Status (Yes/Partial/No) | Justification`

## Step 4 — Acceptance Criteria
Evaluate every criterion individually, quoting each as written. If none exist, say so (Step 5 proposals apply). Status: 🟢 READY (specific, testable) · 🟡 NEEDS_WORK (vague/incomplete) · 🔴 NOT_READY (missing/contradictory/unverifiable). Give a concrete verification example (Given/When/Then or input → expected output). If not 🟢 READY, state why and the exact fix; for 🟢 READY use "—".
Table: `# | Criterion (as written) | Status | Concrete Example | Why Not Ready | What To Do`

## Step 5 — Gaps & Questions
- Blocking Gaps: issues preventing start, ordered by severity, each referencing the weak/missing part.
- Clarifying Questions: actionable questions for the author to close gaps.
- Suggested Criteria: if criteria are missing/weak, propose Given/When/Then derived only from stated intent, marked as proposals needing confirmation.

## Step 6 — Readiness %
INVEST subtotal = sum of 6 scores (max 30). DoR subtotal = (Yes=2, Partial=1, No=0) over 10 items (max 20). Readiness % = (INVEST + DoR) / 50 × 100, rounded to the nearest whole number. Show the math.

## Step 7 — Consistency Check
Before the verdict, silently verify and fix any conflicts: (a) every INVEST and DoR row has quoted evidence or an explicit "Not stated"; (b) every blocking gap maps to a 🔴 NOT_READY criterion or a No/Partial DoR item; (c) no item is double-counted; (d) the Result Header verdict, the Step 8 verdict, and the Readiness % all agree under the rules below. Report this as one line: "Consistency check: passed" or list what you corrected.

## Step 8 — Verdict (Ready / Not Ready)
Table: `Readiness % | Status | Primary Reason`.
- ✅ READY — Readiness ≥ 80% AND no blocking gaps AND no 🔴 NOT_READY criterion.
- ❌ NOT_READY — any blocking gap, any 🔴 NOT_READY criterion, or Readiness < 80%.
If NOT_READY, add 2–4 sentences on why and what must change, citing the story.

## Step 9 — Handoff (for orchestration)
Emit these four named fields verbatim so an orchestrator can route without parsing the tables above:
- status: READY | NOT_READY | BLOCKED
- findings: ordered list; each finding ties to a specific criterion, INVEST dimension, or DoR item.
- missing evidence: the blocking gaps and clarifying questions that must be closed (or "none").
- recommended next action: the smallest useful next step, ending with a suggested route — proceed (story is ready), clarify (author must answer questions/close gaps), or replan (story must be rewritten or split).

## Story
<<< Paste the story as plain text here. Replace this line entirely. >>>
```

## Notes

- The story goes under `## Story` as plain text; the assistant must not pull in outside context.
- INVEST set, DoR checklist, scoring math, status tokens, and thresholds are load-bearing — change only when the rubric evolves.
- Suggested acceptance criteria are always proposals needing author confirmation.
- The Result Header and the Step 9 Handoff are stable anchors for automation: the Handoff field names (`status`, `findings`, `missing evidence`, `recommended next action`) mirror the validator return shape in [../agents/orchestrator-agent.md](../agents/orchestrator-agent.md), so this prompt can act as a readiness gate before planning.
- Orchestration routing: `status: READY` → proceed to planning; `NOT_READY` with answerable questions → clarify with the author; `NOT_READY` due to fundamental scope/structure problems → replan (rewrite or split the story); `BLOCKED` → request the story text.
