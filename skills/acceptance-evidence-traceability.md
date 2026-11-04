---
title: "Acceptance Evidence Traceability"
type: skill
summary: "Map each acceptance criterion to the artifact that proves it, so a completion claim rests on citations rather than a summary."
tags:
  - skills
  - delivery
  - validation
  - evidence
status: draft
version: 0.3.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
inputs:
  - acceptance criteria
  - work result and artifacts
outputs:
  - criterion-to-evidence map
  - named evidence gaps
---

# Acceptance Evidence Traceability

## Summary

Map each acceptance criterion to the concrete artifact that proves it, so a completion claim rests on cited evidence instead of a summary.

## Use When

- An implementer is packaging a result for verification.
- A verifier needs to see what each criterion is actually backed by.
- A change has many moving parts and a broad "done" would hide a gap.

## Do Not Use When

- The task is judging someone else's evidence — use [independent-verification.md](./independent-verification.md).
- The criteria do not exist yet — use [acceptance-criteria-authoring.md](./acceptance-criteria-authoring.md).

## Inputs

- Required:
  - the acceptance criteria
  - the artifacts produced: changed files, tests, recorded runs
- Optional:
  - logs, fixtures, or review notes
  - known limitations and untested assumptions

## Method

1. List every criterion separately. One combined success statement proves nothing about any individual criterion.
2. Attach concrete evidence to each: `path:line` with the symbol, the test name that exercises it, or the recorded command output.
3. Quote evidence from artifacts produced or opened in this run. Do not reconstruct code or results from memory.
4. Mark a criterion with missing, partial, or assumption-based evidence as exactly that. Weaken the claim, never the evidence.
5. Keep the mapping traceable to the approved package, so a gap can be classified as implementation, planning, or missing information.
6. State what the evidence does not cover: manual steps, environment assumptions, behavior only observable at runtime.

## Quality Bar

- Every criterion has either a citation or an explicit gap statement; none is left implied.
- Test evidence names the test, not only its file.
- Every citation points at a path and line that exist in this run.
- Uncovered ground is listed, so the verifier knows the edge of the claim.

## Failure Modes

- Global claims such as "tests pass" with no statement of which criterion that proves.
- Citing a test by file instead of by name, so no one can tell which assertion matters.
- Mixing evidence with new scope decisions that were never approved.
- Burying an assumption or a manual check inside a confident summary.

## Related

- [independent-verification.md](./independent-verification.md) — judging evidence rather than assembling it.
- [acceptance-criteria-authoring.md](./acceptance-criteria-authoring.md) — the criteria being traced.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Never place a secret in evidence; cite `path:line` and mark the value `REDACTED`.
