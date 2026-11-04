---
title: "Bug Fix Diagnosis And Resolution"
type: prompt
summary: "Triages a bug report to a cited root cause and a proposed fix, applying the fix only on explicit authorization."
tags:
  - prompts
  - bug-fix
  - debugging
  - root-cause-analysis
  - code-review
status: draft
version: 0.3.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
  - run-commands
inputs:
  - target project the executor can read
  - bug report, pasted under `## Bug Report`
outputs:
  - result header with verdict, root cause location, and confidence
  - validity verdict with justification
  - table of files and code causing the bug
  - proposed fix, applied only when authorized
---

# Bug Fix Diagnosis And Resolution

## Summary

The executor acts as a Principal Software Engineer: traces the bug from the report through the smallest relevant call chain, decides whether it is real, explains the root cause, tables the offending code, and proposes a fix. The fix is applied only on explicit authorization.

## Use When

- A bug report needs triage before anyone commits to fixing it.
- You need a cited yes or no on whether a bug is real.
- You need a scoped root cause and fix proposal for a contained defect.

## Do Not Use When

- The defect is a missing feature — use [story-acceptance-criteria-confirmation.md](./story-acceptance-criteria-confirmation.md).
- The question is whether a story was implemented — use [story-development-completion-evaluation.md](./story-development-completion-evaluation.md).
- The whole codebase needs assessing — use [project-evaluation.md](./project-evaluation.md).

## Inputs

- Required: a target project the executor can read, and a bug report pasted under `## Bug Report`.
- Required capabilities: read files; write files and run commands only if you authorize the fix.
- Optional: reproduction steps, logs, or the environment where the behavior appears.

## Outputs

Result header, three one-line fields in this order:

- `Verdict` — `CONFIRMED`, `NOT_REPRODUCIBLE`, `INVALID`, or `BLOCKED`
- `Root Cause` — `file:line`, or "none"
- `Confidence` — High, Medium, or Low

Then: the located call chain, the validity verdict, the root cause, the offending-code table, the proposed fix, and whether it was applied.

## How To Use

1. Give the executor read access to the target project.
2. Copy the prompt block below and replace the placeholder under `## Bug Report`.
3. Send it. With no report or no code access it returns `BLOCKED`.
4. To have Step 6 applied, reply "apply the fix". Without that, the fix stays a proposal.

## Prompt

```text
# Stage
Act as a Principal Software Engineer.
Decide if the bug below is real and reproducible in this codebase.
Cite evidence — files, functions, lines — for every claim.
Say "Not found" rather than guess.

Follow AI-Hub `knowledge/safety-policy.md` and `knowledge/scoped-context-discipline.md`.
Start from symptoms in the bug report; open only files on the suspected call chain, related tests, and configs they require. Do not inventory the whole repo.
Don't edit files until Step 6 authorizes it, and don't touch files beyond the root cause without flagging it.

If the bug report is empty/placeholder, or you have no code access, output only the Result Header with `Verdict: BLOCKED` (state why) and stop.

## Result Header (output first)
- Verdict: CONFIRMED | NOT_REPRODUCIBLE | INVALID | BLOCKED
- Root Cause: <file:line, or "none">
- Confidence: High | Medium | Low

## Bug description
Restate the reported behavior in 1–2 sentences: trigger, expected result, actual result. Flag any ambiguity that would change the verdict.

## Step 1 — Locate (targeted)
From the report, list only the files/functions needed: entry point, call chain, config, related tests. One line each on why relevant. Do not broaden into unrelated modules. Note gaps.

## Step 2 — Validate
Pick one, with evidence:
- ✅ CONFIRMED — traced code path; shows why actual diverges from expected.
- ⚠️ NOT_REPRODUCIBLE — code looks correct; state what evidence would confirm it.
- ❌ INVALID — behavior is by design; cite the code/spec proving it.
If not CONFIRMED, skip to Step 5.

## Step 3 — Root Cause
(If CONFIRMED.) Plain-language explanation of why it happens, tracing execution from trigger to failure.

## Step 4 — Files & Code Causing the Bug
Table: `# | File:Line | Code Excerpt | Role in the Bug`

## Step 5 — Proposed Solution
Table: `# | File:Line | Current Code | Proposed Change | Why This Fixes It`
Note risks, tests to update, and flag any public-contract/migration/config impact per the safety policy.

## Step 6 — Apply Fix (only if explicitly authorized)
Apply only if told to (e.g. "apply it"). Otherwise write "Not applied — awaiting confirmation". If applied: show the diff, update tests, run them, report pass/fail.

## Step 7 — Summary
One sentence each: verdict, root cause (or why not confirmed), proposed fix, applied or not.

## Bug Report
<<< Paste the bug report as plain text here. Replace this line entirely. >>>
```

## Notes

- No code access or no bug report produces `BLOCKED`.
- The fix is proposed only; Step 6 is a hard gate needing explicit confirmation.
- `NOT_REPRODUCIBLE` and `INVALID` are valid outcomes — do not force a confirmation.

## Related

- [story-development-completion-evaluation.md](./story-development-completion-evaluation.md) — when the question is whether a story was built, not why it misbehaves.
- [../agents/solution-architect-agent.md](../agents/solution-architect-agent.md) — runs Steps 1–5 of this prompt in its diagnose mode.
- [../knowledge/safety-policy.md](../knowledge/safety-policy.md) — the gate behind Step 6.
