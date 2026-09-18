---
title: "Scoped Context Discipline"
type: knowledge
tags:
  - knowledge
  - tokens
  - context
  - exploration
  - discipline
status: draft
version: 0.2.0
last_reviewed: 2026-09-18
tooling: agnostic
inputs:
  - any agent, prompt, or tool-using run that reads a repository
outputs:
  - rules that limit which paths are opened or searched
---

# Summary

Token discipline for **what enters context**: reads, searches, trees, diffs, and command output. Open only what the user named, the approved package requires, or the current step must cite — never scan a whole codebase, workspace, or sibling project uninvited. Pair with [execution-output-discipline.md](./execution-output-discipline.md), which governs what leaves context; work-package boundaries stay in [safety-policy.md](./safety-policy.md).

# Rules

1. **Named scope first.** Start from the paths the user, brief, or approved plan named; do not precede them with a repository tour.
2. **Cheapest tool first.** Locate with glob or list, confirm with a bounded search, read only the matched ranges, and read a file whole only when it is small or decisive.
3. **Stop at sufficiency.** Stop reading once the current step can be cited; a file that is merely related is not a reason to open it.
4. **Never re-read.** Do not reopen what is already in context, and do not re-read a file to confirm your own successful edit.
5. **Skip low-signal bulk.** Lockfiles, dependency and build directories, generated output, snapshots, minified bundles, and binaries: search them, never read them whole.
6. **Bound command output.** Cap logs, history, diffs, and recursive listings with flags or filters; from a failing run, read the failures, not the whole log.
7. **Widen deliberately.** Widen one step after a narrow search fails and say that you widened; if the correct root is still ambiguous, ask rather than scan to guess.
8. **Sample, do not sweep.** When breadth is genuinely required, start at manifests and entrypoints, state what you sampled and what you skipped, and never read every file as a precaution.
9. **Role scope.** Load only the skills bound to the active role; in dual-root runs, read code under the named workspace rather than the hub.
10. **Report scope in one line** only when it changes a conclusion or a confidence level; absence claims name the scope searched. Output brevity rules still apply.

# Exceptions

A prompt or the user may require repository-wide or multi-root review (for example, a project evaluation). Rules 2, 5, 6, and 8 still hold: bound and sample the review, and never dump trees or file bodies wholesale.

# Enforcement by role

- **Orchestrator / planner:** state path boundaries in the brief and plan; full-repository inspection is out of scope unless the user requested it.
- **Executor / validator:** stay inside those boundaries; widen the read set only through a routed request.
- **Peer panel:** read only what the topic supplied; do not open code to produce evidence the topic did not require.
