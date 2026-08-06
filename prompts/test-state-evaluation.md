---
title: "Test state evaluation"
type: prompt
tags:
  - prompts
  - testing
  - evaluation
  - diagnostics
  - remediation
  - skills
status: draft
version: 0.1.1
last_reviewed: 2026-08-06
tooling: tool-assisted
inputs:
  - target project (codebase the assistant can read and run)
  - test skills manifest (repo-root skill paths, under `## Test skills manifest`)
  - optional test command override
outputs:
  - result header with verdict, suite counts, top failure, and confidence
  - per-failure triage table with root-cause classification and evidence
  - suggested actions tagged test-side or code-side
  - test/mock-only fixes with before/after status and orchestration handoff
---

# Summary

A technology-agnostic prompt that runs a project's test suite, diagnoses why each failure occurs, suggests actions, and fixes failures whose fault is in the test or its mocks/fixtures. It edits only test files and test doubles — never production logic, config, or other non-test files. Genuine product bugs are reported, not patched. Tooling is supplied through the `{{TEST_SKILLS}}` manifest and the project's own test command. Opens with a fixed result header and ends with a standardized handoff so it can gate an orchestrated run (see [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md)).

## Use When

- A suite is red and you need to separate test/mock bugs from real code bugs.
- You want failing tests/mocks fixed with zero risk of source logic being changed to pass tests.
- You need a repeatable, evidence-based test-health report or a diagnostic gate in an orchestrated run.

## How To Use

Point the assistant at the project and use a mode that can run commands and edit files. Copy the prompt block, replace `{{TEST_SKILLS}}` with repo-root skill paths for the target stack (e.g. `skills/typescript-jest-test-design.md`), optionally set a test command, then send. With no runnable tests or an empty manifest it returns `BLOCKED` rather than guessing.

## Prompt

```text
Act as a principal test engineer. Run this project's test suite, diagnose every failure with evidence, suggest actions, and fix only failures whose fault is in the test or its mocks/fixtures. Base conclusions on real test output and code; cite files, functions, or line numbers. If something cannot be found or run, say so — never assume.

Follow AI-Hub knowledge/safety-policy.md; flag any destructive or production action as needing explicit confirmation.

## Hard scope guardrail (load-bearing)
- CREATE or EDIT ONLY: test files and test-only mocks, stubs, fakes, fixtures, snapshots, and test helpers.
- DO NOT change production/source/logic code, configuration, schemas, build files, CI, dependencies, or any non-test file.
- Never make a test pass by changing the code under test. If the production code is genuinely wrong (the test correctly encodes intended behavior), leave the test failing and report it as a product/logic defect — do not weaken, skip, or delete it. Deleting/skipping a test is allowed only when the test itself is invalid, with an explanation.

## Test skills manifest (authoritative)
Resolve each path from the repository root, read it, and apply it as test-design and diagnosis guidance. These define the stack, runner, and conventions — do not infer tooling beyond them and the project.

## Use skills

## Result Header (output first)
- Verdict: GREEN (all passed) | FIXED (remaining failures were test/mock defects, now pass) | CODE_DEFECT (genuine product/logic failures remain) | BLOCKED (no runnable tests, empty manifest, or no code access)
- Suite: <passed>/<total> passed (<failed> failed) — n/a when BLOCKED
- Top Failure: <most important failing test or root cause, or "none">
- Confidence: High | Medium | Low (how reliably you could run and inspect the suite)

## Step 1 — Discover & Run
Use TEST_COMMAND if given, else detect it. Run the full suite once, capture raw output, and report the command and baseline counts. If it cannot be run, emit Verdict: BLOCKED and stop. If all pass, emit Verdict: GREEN with evidence and skip to Step 4.

## Step 2 — Failure Triage
Classify each failing test as exactly one of:
- test-defect — the test is wrong (bad assertion/expected value/setup, outdated to a legitimate behavior change).
- mock/fixture-defect — a mock, stub, fake, fixture, or snapshot is wrong, stale, or misconfigured.
- flaky/environment — non-deterministic, ordering-, time-, or environment-dependent.
- product/logic-defect — the test correctly encodes intended behavior and the production code is wrong.
Table: `# | Test (file:line) | Symptom | Root Cause | Evidence | Why It Fails`. Each row cites concrete evidence (expected vs actual, file:line) or "Not found".

## Step 3 — Fix (test/mock only) with actions
For each failure give the smallest corrective action, tagged [test-side] (fixable here: test-defect, mock/fixture-defect, most flaky) or [code-side] (out of scope: product/logic-defect, or flaky needing a source change). Apply [test-side] fixes by editing ONLY tests and test mocks/fixtures, honoring the manifest conventions; show what changed and where. Leave [code-side] items untouched; for each, state the real bug (expected vs actual + source location) so a developer can fix the code.

## Step 4 — Re-run & Verify
Re-run the full suite, report new counts, and list any still-failing tests with why they remain (expected for product/logic defects you did not patch). Confirm no non-test file was modified.

## Step 5 — Handoff (for orchestration)
Emit verbatim:
- status: GREEN | FIXED | CODE_DEFECT | BLOCKED
- findings: ordered list; each ties a test (file:line) to its root cause and resolution.
- unfixed code defects: product/logic defects left for a developer (expected vs actual + source location), or "none".
- recommended next action: smallest next step ending in a route — pass (green/healthy), rework-code (developer must fix source logic), or replan (tests encode contradictory or missing requirements).
```

## Notes

- Replace `{{TEST_SKILLS}}` with a YAML list of repo-root skill paths (see [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md) for examples). Leave `{{TEST_COMMAND}}` blank to auto-detect.
- The scope guardrail is load-bearing: only tests and test doubles may change, and a test is never made to pass by editing the code under test. Real bugs surface via `CODE_DEFECT`.
- The Result Header and Step 5 Handoff are stable anchors; routes (`pass` / `rework-code` / `replan`) let this prompt act as a diagnostic gate after execution.
- Requires a mode that can run commands and edit files; otherwise it returns `BLOCKED`.

