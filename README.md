# AI-Hub

AI-Hub is a curated collection of AI artifacts, patterns, and frameworks focused on competency, not tools.

Start with [AI.md](AI.md). It is the canonical entry point for repository structure, metadata conventions, and contribution rules.

## Current Structure

- `agents/` for reusable agent role definitions
- `skills/` for atomic capabilities and techniques
- `prompts/` for prompt patterns and reusable task setups
- `workflows/` for multi-step execution patterns
- `knowledge/` for stable concepts, glossaries, and mental models
- `templates/` for starter files used to create new artifacts

Tool-specific configuration should stay thin and point back to `AI.md` rather than duplicating project guidance.

## SDLC control plane

This repository also hosts the GitHub Actions control workflows that Jira dispatches for AI story planning:

- [`.github/workflows/sdlc-plan-story.yml`](.github/workflows/sdlc-plan-story.yml) — primary entry (`jira_id`, `jira_url`, `repository`)
- [`.github/workflows/create-branch.yml`](.github/workflows/create-branch.yml) — cross-repo branch primitive
- [`allowlist.yml`](allowlist.yml) — targets the pipeline may write to
- Competency write-up: [`workflows/sdlc-ai-plan-story.md`](workflows/sdlc-ai-plan-story.md)
