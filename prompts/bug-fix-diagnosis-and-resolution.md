---

## title: "Bug fix diagnosis and resolution"
type: prompt
tags:
  - prompts
  - bug-fix
  - debugging
  - root-cause-analysis
  - code-review
status: draft
version: 0.2.0
last_reviewed: 2026-07-22
tooling: agnostic
inputs:
  - target project (codebase the assistant can read)
  - bug report (plain text, pasted under `## Bug Report`)
outputs:
  - result header with verdict, root cause file, and confidence
  - validity verdict with justification
  - table of files/code causing the bug
  - table of proposed fix, gated fix application
related:
  - ./README.md
  - ./story-completion-evaluation.md
  - ../knowledge/safety-policy.md
# Summary

Assistant acts as a Lead Software Engineer: scans the codebase, decides if a reported bug is real, explains the root cause, tables the offending files/code, and proposes a fix. Fix is applied only if explicitly authorized.

## Use When

- A bug report needs triage before anyone commits to fixing it.
- You need a cited yes/no on whether a bug is real.
- You need a scoped root-cause + fix proposal for a simple bug.

## How To Use

Open the target project, copy the prompt, replace the placeholder under `## Bug Report`, and send. No report or no code access → `BLOCKED`. Say "apply the fix" to have Step 6 applied.

## Prompt

```text
# Stage
Act as a Lead Software Engineer. 
Decide if the bug below is real and reproducible in this codebase. 
Cite evidence — files, functions, lines — for every claim. 
Say "Not found" rather than guess.

Follow AI-Hub `knowledge/safety-policy.md`.
Don't edit files until Step 6 authorizes it, and don't touch files beyond the root cause without flagging it.

If the bug report is empty/placeholder, or you have no code access, output only the Result Header with `Verdict: BLOCKED` (state why) and stop.

## Result Header (output first)
- Verdict: CONFIRMED | NOT_REPRODUCIBLE | INVALID | BLOCKED
- Root Cause: <file:line, or "none">
- Confidence: High | Medium | Low

## Bug description

## Step 1 — Scan & Locate
List files/functions involved: entry point, call chain, config, related tests. One line each on why relevant. Note gaps.

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
```





## Notes

- No code access or bug report → `BLOCKED`.
- Fix is proposed only; Step 6 is a hard gate needing explicit confirmation.
- `NOT_REPRODUCIBLE`/`INVALID` are valid outcomes — don't force a confirmation.

