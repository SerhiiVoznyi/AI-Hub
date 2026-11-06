---
title: "Context Pack Construction"
type: skill
summary: "Build a pointer set that lets another role start work immediately without re-exploring or receiving pasted file bodies."
tags:
  - skills
  - context
  - tokens
  - orchestration
status: draft
version: 0.1.2
last_reviewed: 2026-11-05
capabilities:
  - read-files
inputs:
  - task or work package
  - target repository
outputs:
  - context pack of pointers
  - known gaps
---

# Context Pack Construction

## Summary

Assemble the smallest set of pointers — path, line range, symbol, and why it matters — that lets a specialist with no prior context start work without rediscovering the codebase.

## Use When

- A specialist will start with an empty context and must not re-explore what someone already mapped.
- Several specialists need the same orientation, and each exploring separately would repeat the cost.
- A repository is large or unfamiliar enough that unguided exploration would dominate the run.

## Do Not Use When

- The work touches two or three files the dispatcher can already name — a pack adds overhead with no saving.
- The question is how much to spend overall — use [token-budget-planning.md](./token-budget-planning.md).
- The target is an artifact's own verbosity — use [artifact-token-audit.md](./artifact-token-audit.md).

## Inputs

- Required:
  - the task or work package, with its criteria
  - read access to the target repository
- Optional:
  - repository knowledge files (`AGENTS.md`, a `docs/` knowledge base, per-project docs) or existing architecture notes
  - gaps reported by a previous pack

## Method

1. Work from the task's criteria. A pointer earns its place by serving a criterion, not by being interesting.
2. Locate before reading: glob and bounded search first, then open only the ranges a match names, per [../knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md).
3. Write each entry as `path:line-range (symbol) — why it matters in one line`. Never paste the code; the specialist opens what it needs.
4. Order entries so a reader can start at the top: the `AGENTS.md` and `docs/README.md` of each project in scope when present, then the entry point, the modules it calls, contracts, tests, and configuration.
5. Include the negative space: name what you searched for and did not find, with the search scope. An absence saves a specialist a fruitless hunt.
6. Mark anything uncertain as inferred, with the clue that suggested it. A confident pointer that is wrong costs more than an honest one that is vague.
7. Keep the pack shorter than the reading it replaces. If it approaches the size of the files it points at, the task did not need a pack.
8. Record what the pack deliberately omits, so a specialist knows the edge rather than assuming completeness.

## Quality Bar

- Every entry has a real path and a real line range, verified in this run, plus a reason tied to a criterion.
- No entry contains a pasted file body, and nothing is reconstructed from memory.
- Every criterion has at least one pointer, or an explicit statement that its landing zone is unknown.
- Searched-and-absent findings name both the pattern and the scope.

## Failure Modes

- A pack that is a file listing: paths with no line ranges and no reason, so the specialist reads everything anyway.
- Pasting code "to save a read", which defeats the point and goes stale on the first edit.
- Pointers from a naming convention or a README rather than a file actually opened.
- Omitting the negative space, so each specialist repeats the same failed search.

## Related

- [../knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md) — the read limits this skill operationalizes.
- [token-budget-planning.md](./token-budget-planning.md) — how much each step may spend.
- [../prompts/repository-knowledge-graph-creation.md](../prompts/repository-knowledge-graph-creation.md) — durable per-project docs and a dependency graph, when packs are needed repeatedly.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Never point at a secret-bearing file's contents; cite `path:line` and mark the value `REDACTED`.
