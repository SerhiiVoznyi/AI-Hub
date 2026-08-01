---
title: "Execution Output Discipline"
type: knowledge
tags:
  - knowledge
  - tokens
  - output
  - discipline
status: reviewed
version: 0.1.0
last_reviewed: 2026-08-01
tooling: agnostic
inputs:
  - any AI execution package or handoff
outputs:
  - brevity rules for runtime outputs
---

# Summary

Token discipline for **runtime AI outputs** during execution (not only for writing hub artifacts). Pair with [agent-return-contracts.md](./agent-return-contracts.md).

# Rules

1. Prefer structured keys over narrative. Default to the return contracts for the active handoff.
2. Do not restate the task brief, safety policy, or skill documents in outputs.
3. Evidence: `path` + one line on what it proves. No full log dumps unless required to prove a criterion or the user asked.
4. Secrets: `REDACTED` only — see [safety-policy.md](./safety-policy.md).
5. Omit empty optional fields; do not write “None” / “N/A” placeholders.
6. Rework / disagreement: list **deltas only** (what failed, what to change). Do not dump a full re-plan unless status is `replan` and the planner package is required.
7. If a field would exceed ~20 lines, summarize and point to artifact paths.
8. One claim per bullet; no duplicate restating of the same finding under multiple headings.
