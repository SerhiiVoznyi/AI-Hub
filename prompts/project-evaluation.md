---
title: "Project evaluation by a Principal Engineer"
type: prompt
tags:
  - prompts
  - code-review
  - evaluation
  - architecture
  - quality
  - production-readiness
status: draft
version: 0.2.0
last_reviewed: 2026-06-19
tooling: agnostic
inputs:
  - target project (codebase the assistant can read)
outputs:
  - result header with verdict, composite score, top risk, and confidence
  - orientation summary
  - 14-criterion scored evaluation with evidence
  - status table, key-findings lists, aggregate scores, final verdict
related:
  - ./README.md
  - ./story-readiness-evaluation.md
  - ./story-completion-evaluation.md
  - ../knowledge/safety-policy.md
---

# Summary

A single-pass review prompt that has the assistant act as a Principal Engineer / Architect / Code Reviewer and produce a strict, evidence-based assessment of a codebase across 14 criteria, ending in aggregate scores and a verdict. Designed for any stack; the assistant must cite concrete files, folders, classes, functions, or line numbers.

## Use When

- Auditing an unfamiliar repository, an inherited project, or a candidate solution.
- Producing a baseline quality / production-readiness report before a refactor or release.
- You want a repeatable, comparable scoring template rather than free-form feedback.

## How To Use

Point the assistant at the target project (open the workspace, attach paths, or name the directory), then copy the prompt block below and send it. With no code access the prompt returns `BLOCKED (no code access)` rather than guessing.

## Prompt

```text
Act as a Principal Software Engineer, Software Architect, and Code Reviewer. Be brutally objective and base every conclusion on code evidence. If a file or configuration does not exist (e.g., no `.github/workflows`), state that explicitly — do not infer presence elsewhere. For codebases >50 files, review a representative sample and note what you sampled.

Follow AI-Hub `knowledge/safety-policy.md` when recommendations could cause destructive operations (schema migrations, dependency upgrades, production or IAM changes, credential handling). Flag such recommendations as requiring explicit user confirmation; never propose exposing secrets or making production changes without approval.

If no project or codebase is accessible to inspect, do not invent an audit. Emit only the Result Header with `Verdict: BLOCKED (no code access)` requesting that a project be attached or its directory named, then stop.

## Result Header (output this first)
Four one-line named fields, in this exact order:
- Verdict: <one of the Step 7 verdicts> | BLOCKED (no code access)
- Score: Composite <0–10> (omit or use n/a when BLOCKED)
- Top Risk: <single most important risk to production, or "none">
- Confidence: High | Medium | Low (overall, based on how much of the codebase you actually inspected)

## Step 1 — Orientation (do before scoring)
Output:
1. A file tree of the project (max 3 levels deep).
2. One paragraph: what the project appears to do, its tech stack, and approximate size (files; LOC if determinable).
3. Areas you could NOT fully inspect and why (e.g., no test files, no CI config).

## Step 2 — Detailed Evaluation
Scoring rules:
- Score is an integer 1–10, or `N/A` if the criterion cannot be assessed (then Evidence = "Not found" and explain in Issues Found).
- Calibration anchors for the 1–10 scale (apply to every criterion): 1–3 = serious problems or the practice is mostly absent; 4–5 = present but weak, inconsistent, or risky; 6–7 = adequate and functional with notable gaps; 8–9 = strong, deliberate, well-executed with positive evidence; 10 = exemplary, no meaningful weakness.
- Confidence is High / Medium / Low, based on how much relevant code you inspected.
- Evidence MUST reference concrete files, folders, classes, functions, or line numbers — no generic feedback.
- A score of 8+ requires strong positive evidence, not merely the absence of problems.

Criteria (assess each):
1. Architecture & Design — layering, separation of concerns, modularity, dependency direction
2. Code Quality — readability, naming, duplication, complexity, consistency
3. SOLID — SRP, OCP, LSP, ISP, DIP; cite specific violations or exemplars
4. Clean Code — function/class size, abstraction levels, magic values, comments
5. Testing — coverage, test types (unit/integration/e2e), assertion quality, mocking strategy
6. Security — auth/authz, input validation, secrets management, dependency vulns, injection risks
7. Performance — N+1 queries, caching, algorithmic complexity, blocking calls, pagination
8. Reliability & Resilience — error handling, retries, timeouts, circuit breakers, graceful degradation
9. API Design — REST/GraphQL conventions, versioning, error responses, contract consistency
10. Database Design — schema normalization, indexes, migrations, query safety
11. DevOps & Deployment — CI/CD pipeline, containerization, environment config, rollback strategy
12. Documentation — README quality, inline docs, API docs, ADRs, onboarding clarity
13. Technical Debt — TODOs, dead code, deprecated dependencies, workarounds, complexity hotspots
14. Production Readiness — logging, monitoring, alerting, health checks, feature flags, secrets rotation

Render results as a table with columns:
`# | Criterion | Score | Confidence | Evidence from Code | Issues Found | Impact (High/Med/Low) | Suggested Improvements`

## Step 3 — Summary Table
Columns: `# | Criterion | Score | Status`.
Status mapping (strict): 1–3 → 🔴 Critical · 4–5 → 🟠 Weak · 6–7 → 🟡 Acceptable · 8–9 → 🟢 Good · 10 → ⭐ Excellent · N/A → ⬜ Not Assessed.

## Step 4 — Key Findings
Every item must name a specific file, module, or pattern — no generic statements. List up to 10 per category (fewer if the codebase is small; do not pad with weak items):
- **Top Risks** — ordered by severity (what could break or harm production).
- **Top Improvement Opportunities** — ordered by long-term quality impact.
- **Top Quick Wins** — ordered by effort (low-effort, high-value).
- **Most Problematic Modules** — name files/modules and explain why.
- **Best-Designed Parts** — name files/modules and explain what they do well.

## Step 5 — Final Scores
Exclude N/A criteria from averages. Show the arithmetic.
| Score | Basis |
| --- | --- |
| Overall Maintainability | avg(Code Quality, SOLID, Clean Code, Technical Debt, Documentation) |
| Overall Engineering Quality | avg(Architecture, Code Quality, SOLID, Testing, API Design, DB Design) |
| Overall Production Readiness | avg(Security, Performance, Reliability, DevOps, Production Readiness) |
| Composite | avg of all 14 assessed criteria |

## Step 6 — Consistency Check
Before the verdict, silently verify and fix any conflicts: (a) every Step 2 row has concrete evidence (file/folder/function/line) or an explicit "Not found"; (b) the Step 5 aggregate scores actually recompute from the Step 2 scores, with N/A criteria excluded; (c) the Step 3 status emoji matches each score under the strict mapping; (d) the Result Header verdict, the Step 7 verdict, the Composite, and the Production Readiness score all agree under the Step 7 rules. Report this as one line: "Consistency check: passed" or list what you corrected.

## Step 7 — Final Verdict
Composite and Production Readiness are fractional averages. Evaluate the rules in order and choose the FIRST one that matches; this makes every (Composite, ProdReadiness) pair resolve to exactly one verdict.
1. Composite < 4 → 🔴 Critical Rewrite Needed
2. Composite < 6 → 🟠 Major Refactoring Recommended
3. Composite < 8 AND ProdReadiness < 6 → 🟠 Significant Gaps Before Production
4. Composite < 8 → 🟡 Good Foundation — Improvements Needed
5. ProdReadiness < 7 → 🟠 Significant Gaps Before Production (Composite is ≥ 8 here: strong code, weak production readiness)
6. Composite ≥ 9 AND ProdReadiness ≥ 9 → ⭐ Enterprise Grade
7. Otherwise → 🟢 Production Quality

State the verdict (which must match the Result Header), then write 3–5 sentences justifying it with specific evidence from the codebase.
```

## Notes

- Point the assistant at the target project before sending the prompt (open the workspace, attach paths, or specify the directory).
- The 14 criteria, scoring scale, calibration anchors, status mapping, score formulas, and verdict rules are load-bearing — change them only when the rubric itself needs to evolve.
- The Result Header is a stable anchor: it is emitted first and its verdict and Composite must agree with Step 7. The Step 6 Consistency Check exists to enforce that agreement before the verdict is stated.
- Pair with [../knowledge/safety-policy.md](../knowledge/safety-policy.md) when the review may touch destructive operations (e.g., proposing migrations or dependency upgrades).
