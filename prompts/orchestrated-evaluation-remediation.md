---
title: "Orchestrated remediation from project evaluation Key Findings"
type: prompt
tags:
  - prompts
  - multi-agent
  - orchestration
  - evaluation
  - remediation
  - code-review
status: draft
version: 0.1.0
last_reviewed: 2026-06-08
tooling: tool-assisted
inputs:
  - project evaluation Key Findings (from project-evaluation.md output)
  - bounded remediation scope for this run
  - task skills manifest matched to target stack
  - AI_HUB_ROOT and WORKSPACE_ROOT paths
outputs:
  - orchestrator-normalized task brief
  - planner-approved plan
  - executor remediation with evidence
  - validator disposition (pass / rework / replan)
  - final orchestrator summary
---

# Summary

Runs the four-agent orchestrated pattern to **fix a bounded slice** of Key Findings produced by [project-evaluation.md](./project-evaluation.md). The orchestrator normalizes evaluation output into a remediation brief, then routes planner → executor → validator until the scoped items pass validation or block on missing user input.

Designed for Cursor (or any tool that can read AI-Hub artifacts and write to a separate project workspace). One run = one small, evidence-backed remediation slice—not the entire evaluation backlog.

## Use When

- You already ran `project-evaluation.md` and have Key Findings (Risks, Quick Wins, Improvement Opportunities, or Problematic Modules).
- You want orchestrator-controlled remediation with explicit planning, execution evidence, and validation.
- The target codebase lives in a workspace separate from AI-Hub (typical Cursor setup).

## Prerequisites

1. Complete a [project-evaluation.md](./project-evaluation.md) run on the target project.
2. Pick **1–3 specific findings** for this run (file/module names required—no generic items).
3. Choose a task skills manifest for the target stack (see appendix or [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md)).
4. Use **Agent mode** in Cursor so the executor can edit files and run commands.

## Prompt

```text
Run the AI-Hub orchestrated multi-agent pattern to remediate project evaluation findings.

## Roots
- AI_HUB_ROOT    = {{AI_HUB_ROOT}}   (resolve agents/..., skills/..., knowledge/... from here)
- WORKSPACE_ROOT = {{WORKSPACE_ROOT}} (write code, tests, configs, IaC here unless a step explicitly targets AI-Hub)

## Load and follow (from AI_HUB_ROOT)
- agents/orchestrator-agent.md
- agents/planner-agent.md
- agents/executor-agent.md
- agents/validator-agent.md
- knowledge/safety-policy.md
- knowledge/orchestrated-handoff-protocol.md
- knowledge/agent-return-contracts.md
- knowledge/execution-output-discipline.md

## Remediation objective

Remediate the scoped findings below from a Principal-Engineer project evaluation ([prompts/project-evaluation.md]). Work only in WORKSPACE_ROOT unless the approved plan explicitly requires AI-Hub changes.

### Scope for this run (mandatory — keep small)
Fix only:
{{SCOPED_FINDINGS}}

Do NOT in this run:
{{NON_GOALS}}

Flag destructive/production/IAM/secret work for user confirmation per knowledge/safety-policy.md.

### Success criteria
{{SUCCESS_CRITERIA}}

Each criterion must be verifiable with concrete evidence (paths, diffs, test output, or config).

### Evaluation context (reference — paste from project-evaluation output)

#### Scoped Key Findings
{{KEY_FINDINGS_EXCERPT}}

#### Related scored criteria (optional)
{{SCORED_TABLE_EXCERPT}}

#### Patterns to preserve (optional — from Best-Designed Parts)
{{BEST_DESIGNED_PARTS}}

## Task skills manifest

Authoritative for this run. Resolve paths from AI_HUB_ROOT. Apply each skill only for the listed role(s).

{{TASK_SKILLS_MANIFEST}}

Manifest changes need user approval.

## Start

Begin as the orchestrator. Obey orchestrated-handoff-protocol.md. Emit packages per agent-return-contracts.md; keep outputs short per execution-output-discipline.md. One run = scoped findings only.
```
