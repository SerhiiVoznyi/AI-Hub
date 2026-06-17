# Prompts

Use this folder for reusable prompt patterns and task setups.

Put material here when the main value is the wording, structure, or sequencing of instructions for a recurring task.

Use [../templates/prompt-template.md](../templates/prompt-template.md) to start new prompt artifacts.

## Available prompts

- [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md): start the orchestrator, planner, executor, and validator flow with a per-role task skills manifest.
- [orchestrated-aws-lambda-nodejs-story.md](./orchestrated-aws-lambda-nodejs-story.md): same flow, fixed Node.js / AWS Lambda skill manifest, story under `## Story`; **Cursor** — hub at `C:\Development\Private\AI-Hub`, open workspace as a sibling folder (e.g. `C:\Development\Private\MyLambdaProject`); agents/skills load from the hub, implementation writes under the workspace.
- [project-evaluation.md](./project-evaluation.md): Principal-Engineer-style codebase audit across 14 criteria, producing scored evidence, key-findings lists, aggregate scores, and a final verdict.
- [story-readiness-evaluation.md](./story-readiness-evaluation.md): judge whether a user story (pasted as plain text under `## Story`) is sprint-ready using INVEST and a Definition-of-Ready checklist, producing per-criterion status with concrete examples, blocking gaps, clarifying questions, a readiness percentage, and a Done / Not Done verdict.
- [story-completion-evaluation.md](./story-completion-evaluation.md): judge whether a user story (pasted as plain text under `## Story`) is actually DONE in a given project by inspecting the codebase, producing per-criterion implementation status with code evidence, a Definition-of-Done checklist, remaining work, a completion percentage, and a Done / Not Done verdict.
