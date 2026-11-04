---
title: "Artifact Token Audit"
type: skill
summary: "Find and quantify wasted tokens in agent, prompt, and skill files without weakening the instructions that change behavior."
tags:
  - skills
  - tokens
  - artifacts
  - maintenance
status: draft
version: 0.1.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - artifact files
outputs:
  - waste findings with estimated savings
  - load-bearing content to keep
---

# Artifact Token Audit

## Summary

Audit instruction artifacts for content that costs context on every load without changing what the executor does, and separate it from the lines that are genuinely load-bearing.

## Use When

- Artifacts are loaded repeatedly and their size is a recurring cost.
- A file has grown by accretion and no one has asked what each line still does.
- Several artifacts restate the same contract instead of citing it.

## Do Not Use When

- The cost is in the run rather than the files — use [token-budget-planning.md](./token-budget-planning.md).
- The goal is orienting a specialist in a codebase — use [context-pack-construction.md](./context-pack-construction.md).
- The artifact is new and unproven; audit it after it has been used, not before.

## Inputs

- Required:
  - the artifact files to audit
- Optional:
  - how often each is loaded, and by which roles
  - the shared contracts they should be citing

## Method

1. Classify every section as load-bearing or not. Load-bearing means removing it would change what the executor does. Everything else is a candidate.
2. Find the five recurring wastes:
   - **Duplication of a shared contract** that should be a one-line citation.
   - **Restated inputs**, where the artifact repeats what its caller already supplies.
   - **Motivational text** that asserts care without specifying an action.
   - **Worked examples** that illustrate what the rule already states plainly.
   - **Near-duplicate rules** that differ only in wording.
3. Test every rule for decidability: can an executor tell whether it complied? A rule that cannot be checked is advice, and advice is the cheapest thing to cut.
4. Check cross-references for substance. A link that says "see X" with no statement of when X takes over makes the reader open X to find out.
5. Estimate the saving per finding in approximate tokens, and state what each cut gives up. A saving with no stated cost is not a trade-off, it is a guess.
6. Flag the opposite problem too: a missing stop rule, an unstated quality bar, or an absent failure mode costs far more in re-runs than it saves in length.
7. Rank findings by saving per unit of risk, so the safe cuts are obvious and the contentious ones are explicit.
8. Never propose cutting a safety clause, a confirmation gate, or an evidence rule. Those are the content the artifact exists for.

## Quality Bar

- Every finding names the file and the section, with an approximate saving and the cost of the cut.
- Load-bearing content is listed explicitly, so a later editor knows what was deliberately kept.
- No proposed cut touches a safety clause, a gate, or an evidence requirement.
- Findings about missing content are reported alongside the cuts, not treated as out of scope.

## Failure Modes

- Optimizing for length and removing the stop rules and quality bars that prevent re-runs.
- Cutting a duplicated contract without adding the citation that replaces it.
- Estimating savings with no stated cost, so a reviewer cannot judge the trade.
- Auditing an artifact against taste rather than against whether each line changes behavior.

## Related

- [token-budget-planning.md](./token-budget-planning.md) — the per-run counterpart to this per-artifact audit.
- [../templates/README.md](../templates/README.md) — the section order and body rules an artifact should already follow.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- This skill proposes edits; it does not apply them. Changes to shared contracts need the owner's approval.
