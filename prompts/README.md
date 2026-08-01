# Prompts

Use this folder for reusable prompt patterns and task setups.

Put material here when the main value is the wording, structure, or sequencing of instructions for a recurring task.

Use [../templates/prompt-template.md](../templates/prompt-template.md) to start new prompt artifacts.

## Available prompts

- [orchestrated-execution-with-skills.md](./orchestrated-execution-with-skills.md): start the orchestrator, planner, executor, and validator flow with a per-role task skills manifest.
- [orchestrated-aws-lambda-nodejs-story.md](./orchestrated-aws-lambda-nodejs-story.md): same flow, fixed Node.js / AWS Lambda skill manifest, story under `## Story`; **Cursor** — hub at `C:\Development\Private\AI-Hub`, open workspace as a sibling folder (e.g. `C:\Development\Private\MyLambdaProject`); agents/skills load from the hub, implementation writes under the workspace.
- [peer-review-panel.md](./peer-review-panel.md): run the philosopher, ai-expert, and software-engineer as peers over one contested question, with adversarial review, a bounded round budget, and a consensus or `no_consensus` verdict from the chair.
- [orchestrated-evaluation-remediation.md](./orchestrated-evaluation-remediation.md): four-agent remediation of a bounded slice of Key Findings from [project-evaluation.md](./project-evaluation.md).
- [project-evaluation.md](./project-evaluation.md): Principal-Engineer-style codebase audit across 14 criteria, producing scored evidence, key-findings lists, aggregate scores, and a final verdict.
- [story-readiness-evaluation.md](./story-readiness-evaluation.md): judge whether a user story (pasted as plain text under `## Story`) is sprint-ready using INVEST and a Definition-of-Ready checklist, opening with a result header and ending with a standardized orchestration handoff; produces per-criterion status with concrete examples, blocking gaps, clarifying questions, a readiness percentage, and a Ready / Not Ready verdict.
- [story-completion-evaluation.md](./story-completion-evaluation.md): judge whether a user story (pasted as plain text under `## Story`) is actually DONE in a given project by inspecting the codebase, opening with a result header and ending with a standardized orchestration handoff; produces per-criterion implementation status with code evidence, a Definition-of-Done checklist, remaining work, a completion percentage, and a Done / Not Done verdict.
- [test-state-evaluation.md](./test-state-evaluation.md): technology-agnostic, skills-parameterized (`{{TEST_SKILLS}}`) prompt that runs the test suite, triages each failure by root cause (test / mock / flaky / product-logic), suggests actions, and fixes only test and mock/fixture defects; never edits production logic or non-test files, reports genuine code bugs via a `CODE_DEFECT` verdict, and ends with a standardized orchestration handoff.
- [bug-fix-diagnosis-and-resolution.md](./bug-fix-diagnosis-and-resolution.md): Lead-Software-Engineer triage of a pasted bug report (`## Bug Report`) — validates the bug (`CONFIRMED` / `NOT_REPRODUCIBLE` / `INVALID`), explains root cause, tables the offending files/code, proposes a fix; applies it only if explicitly authorized.
