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
related:
  - ./project-evaluation.md
  - ./orchestrated-execution-with-skills.md
  - ../agents/orchestrator-agent.md
  - ../agents/planner-agent.md
  - ../agents/executor-agent.md
  - ../agents/validator-agent.md
  - ../knowledge/safety-policy.md
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

## Remediation objective

Remediate the scoped findings below from a Principal-Engineer project evaluation ([prompts/project-evaluation.md]). Work only in WORKSPACE_ROOT unless the approved plan explicitly requires AI-Hub changes.

### Scope for this run (mandatory — keep small)
Fix only:
{{SCOPED_FINDINGS}}

Do NOT in this run:
{{NON_GOALS}}

If the scoped items imply destructive operations (schema migrations, dependency major upgrades, production or IAM changes, credential handling), flag them for explicit user confirmation per knowledge/safety-policy.md — do not proceed without approval.

### Success criteria
{{SUCCESS_CRITERIA}}

Each criterion must be verifiable with concrete evidence (file paths, diffs, test output, or config changes).

### Evaluation context (reference — paste from project-evaluation output)

#### Scoped Key Findings
{{KEY_FINDINGS_EXCERPT}}

#### Related scored criteria (optional)
{{SCORED_TABLE_EXCERPT}}

#### Patterns to preserve (optional — from Best-Designed Parts)
{{BEST_DESIGNED_PARTS}}

## Task skills manifest

Authoritative for this run. Resolve each path from AI_HUB_ROOT. Apply each skill only for the role(s) listed.

{{TASK_SKILLS_MANIFEST}}

Replace manifest lists with the correct skills for the target stack before execution. Do not add skills to a role unless the user approves a manifest change.

## Execution rules

1. Begin as the **orchestrator**: normalize the remediation objective into a task brief using orchestrator_skills. Treat each scoped finding as a traceable acceptance criterion.
2. If scope is too large, ambiguous, or jointly unsatisfiable with validator_skills, ask the user to narrow scope before routing to the planner.
3. Route to **planner** with the full manifest unchanged. The plan must map each scoped finding to ordered steps, risks, and acceptance checks.
4. **Execution gate:** Reconcile plan acceptance criteria with validator_skills before sending work to the executor. Do not route execution if they conflict.
5. **Executor** implements only the approved work package in WORKSPACE_ROOT. Return evidence per acceptance-evidence-traceability (if listed in executor_skills).
6. **Validator** checks results against the approved plan and scoped findings. Return pass, rework, or replan per validation-disposition.
7. On pass, summarize what was fixed, what evidence supports it, and which scoped findings remain for a future run.
8. One run addresses only the scoped findings above. Do not expand scope to other Key Findings items without orchestrator-routed user approval.

Begin as the orchestrator.