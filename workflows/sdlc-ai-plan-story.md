---
title: "SDLC AI Plan Story"
type: workflow
tags:
  - sdlc
  - jira
  - github-actions
  - planning
status: draft
version: 0.1.0
last_reviewed: 2026-08-23
tooling: github-actions
inputs:
  - jira_id
  - jira_url
  - repository (target GitHub URL or owner/name)
outputs:
  - ai/{jira_id} branch on the target repository
  - .sdlc/plans/{jira_id}-implementation-plan-{UTC}.md committed on that branch
  - optional Jira incoming-webhook callback
---

# Summary

Control-plane workflow hosted in this repository (AI-Hub). Jira (or a manual
`workflow_dispatch`) sends three string inputs; Actions creates `ai/{jira_id}` on
the allowlisted target, runs Cursor CLI in plan mode against that checkout, verifies
exactly one plan file, commits it, and optionally callbacks Jira.

Design authority: [SandBox SDLC design](https://github.com/SerhiiVoznyi/SandBox/blob/main/docs/sdlc-ai-automation-design.md).

## Inputs

| Input | Required | Notes |
| ----- | -------- | ----- |
| `jira_id` | yes | e.g. `PORTAL-18270` |
| `jira_url` | yes | Browse URL |
| `repository` | yes | Target URL or `owner/name` |

Deterministic values (`branch`, `plan_path`, timestamps, model) are computed in Actions — not passed from Jira.

## Steps

1. **Prepare** — kill switch (`vars.SDLC_ENABLED`), allowlist, validate `jira_id`, compute branch + plan path.
2. **Create branch** — reusable [`.github/workflows/create-branch.yml`](../.github/workflows/create-branch.yml) on the target (`TARGET_WRITE_TOKEN`).
3. **Plan** — fetch Jira (read-only), render [`.sdlc/prompts/plan-frame.md`](../.sdlc/prompts/plan-frame.md), run `agent -p --mode plan`, verify via [`.github/scripts/verify-plan.sh`](../.github/scripts/verify-plan.sh), commit + push.
4. **Report** — archive prompt/transcript; POST `JIRA_CALLBACK_WEBHOOK_URL` if configured.

## Human Review

- Jira readiness gate (ACs / description) before dispatch — outside this repo.
- Plan review on the target branch / Jira comment after callback (`plan-approved` or equivalent).

## Outputs

- Branch `ai/{lowercase-jira-id}` on the target
- Plan markdown under `.sdlc/plans/`
- Actions artifacts (prompt + agent JSON)

## Secrets and variables

**Secrets:** `TARGET_WRITE_TOKEN`, `CURSOR_API_KEY`, `JIRA_READ_TOKEN`, optional `JIRA_EMAIL`, optional `JIRA_CALLBACK_WEBHOOK_URL`

**Variables:** `SDLC_ENABLED=true` (required), optional `SDLC_DEFAULT_MODEL`, `CURSOR_CLI_VERSION`

**Allowlist:** [`allowlist.yml`](../allowlist.yml)

## Entry workflow

[`.github/workflows/sdlc-plan-story.yml`](../.github/workflows/sdlc-plan-story.yml)
