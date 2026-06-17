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
version: 0.1.0
last_reviewed: 2026-06-17
tooling: agnostic
inputs:
  - story text (plain text, pasted under `## Story`)
outputs:
  - INVEST + Definition-of-Ready scored tables with evidence
  - per-acceptance-criterion status table with examples and remediation
  - blocking gaps, clarifying questions
  - readiness percentage and Done / Not Done verdict
related:
  - ./README.md
  - ../knowledge/safety-policy.md
---

# Summary

Acts as a senior Product Owner to judge whether a user story is sprint-ready. The story is pasted as plain text under `## Story`; output is INVEST and Definition-of-Ready score tables, a per-acceptance-criterion table, gaps and questions, a readiness %, and a binary Done / Not Done verdict.

## Use When

- Triaging backlog items before refinement or sprint planning.
- Deciding if a story has enough detail to estimate and start.
- Producing a repeatable, comparable readiness score.

## How To Use

Copy the prompt block, replace the placeholder under `## Story` with the story text (title, description, criteria, notes — whatever exists), and send it.

## Prompt

```text
Act as a senior Product Owner and Agile delivery lead. Judge whether the story below is READY for a sprint. Base every conclusion only on the story text; never invent requirements or context. Treat anything missing as a gap, not an assumption. Follow AI-Hub `knowledge/safety-policy.md`: flag any recommendation implying destructive or production work as needing explicit confirmation.

## Step 1 — Understanding
In 2–4 sentences restate the ask, the user, and the intended outcome using only what the story states. List ambiguous terms or scope.

## Step 2 — INVEST
Score each 1–5 (5 = fully met). Evidence must quote the relevant story text, or "Not stated".
Independent · Negotiable · Valuable · Estimable · Small · Testable
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
Evaluate every criterion individually, quoting each as written. If none exist, say so (Step 5 proposals apply). Status: 🟢 Ready (specific, testable) · 🟡 Needs Work (vague/incomplete) · 🔴 Not Ready (missing/contradictory/unverifiable). Give a concrete verification example (Given/When/Then or input → expected output). If not 🟢, state why and the exact fix; for 🟢 use "—".
Table: `# | Criterion (as written) | Status | Concrete Example | Why Not Ready | What To Do`

## Step 5 — Gaps & Questions
- Blocking Gaps: issues preventing start, ordered by severity, each referencing the weak/missing part.
- Clarifying Questions: actionable questions for the author to close gaps.
- Suggested Criteria: if criteria are missing/weak, propose Given/When/Then derived only from stated intent, marked as proposals needing confirmation.

## Step 6 — Readiness %
INVEST subtotal = sum of 6 scores (max 30). DoR subtotal = (Yes=2, Partial=1, No=0) over 10 items (max 20). Readiness % = (INVEST + DoR) / 50 × 100. Show the math.

## Step 7 — Verdict (Done / Not Done)
Table: `Readiness % | Status | Primary Reason`.
- ✅ Done — Readiness ≥ 80% AND no blocking gaps AND no 🔴 criterion.
- ❌ Not Done — any blocking gap, any 🔴 criterion, or Readiness < 80%.
If Not Done, add 2–4 sentences on why and what must change, citing the story.

## Story
<<< Paste the story as plain text here. Replace this line entirely. >>>
```

## Notes

- The story goes under `## Story` as plain text; the assistant must not pull in outside context.
- INVEST set, DoR checklist, scoring math, and thresholds are load-bearing — change only when the rubric evolves.
- Suggested acceptance criteria are always proposals needing author confirmation.
