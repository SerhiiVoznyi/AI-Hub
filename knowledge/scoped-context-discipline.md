---
title: "Scoped Context Discipline"
type: knowledge
summary: "Rules limiting what enters context: reads, searches, trees, diffs, and command output stay bounded to the task."
tags:
  - knowledge
  - tokens
  - context
  - exploration
  - discipline
status: draft
version: 0.5.0
last_reviewed: 2026-11-04
capabilities: []
inputs:
  - any agent, prompt, or skill that reads a repository
outputs:
  - rules that limit which paths are opened or searched
---

# Scoped Context Discipline

## Summary

Token discipline for **what enters context**: reads, searches, trees, diffs, and command output. Open only what the user named, the task requires, or the current step must cite — never scan a whole codebase, workspace, or sibling project uninvited.

## Scope

Governs what may be loaded while doing the work. Scope boundaries for the work itself stay in [safety-policy.md](./safety-policy.md). How context is packaged and passed between roles stays in [orchestrated-delivery-protocol.md](./orchestrated-delivery-protocol.md).

## Rules

1. **Named scope first.** Start from the paths the user or the task named; do not precede them with a repository tour.
2. **Cheapest tool first.** Where the target has knowledge files — `AGENTS.md` and `AI.md` in the folders in scope, a `kb/` index — read them first and locate through their pointers. Then locate with glob or list, confirm with a bounded search, read only the matched ranges, and read a file whole only when it is small or decisive. Knowledge files are leads: cite code, not cards, as evidence.
3. **Stop at sufficiency.** Stop reading once the current step can be cited; a file that is merely related is not a reason to open it.
4. **Never re-read.** Do not reopen what is already in context, and do not re-read a file to confirm your own successful edit.
5. **Skip low-signal bulk.** Lockfiles, dependency and build directories, generated output, snapshots, minified bundles, and binaries: search them, never read them whole.
6. **Bound command output.** Cap logs, history, diffs, and recursive listings with flags or filters; from a failing run, read the failures, not the whole log.
7. **Widen deliberately.** Widen one step after a narrow search fails and say that you widened; if the correct root is still ambiguous, ask rather than scan to guess.
8. **Sample, do not sweep.** When breadth is genuinely required, start at manifests and entrypoints, state what you sampled and what you skipped, and never read every file as a precaution.
9. **Hub scope.** Load only the skills the task names; when the hub and a target project are both open, read code under the target project rather than the hub.
10. **Report scope in one line** only when it changes a conclusion or a confidence level; absence claims name the scope searched.

## Rationale

- Rules 2 and 3 matter more than they look: most context waste is not one huge file but a dozen plausible ones opened past the point where the answer was already provable.
- Rule 7 keeps a failed search honest. Silently widening and then reporting a confident absence is how a wrong "not found" reaches the user.

## Exceptions

An artifact or the user may require repository-wide or multi-root review (for example, a project evaluation). Rules 2, 5, 6, and 8 still hold: bound and sample the review, and never dump trees or file bodies wholesale.

## Related

- [safety-policy.md](./safety-policy.md) — scope of the work itself, and approval thresholds.
- [orchestrated-delivery-protocol.md](./orchestrated-delivery-protocol.md) — context packs and output economy between roles.
- [../skills/context-pack-construction.md](../skills/context-pack-construction.md) — building a pointer set another role can work from.
- [../prompts/repository-knowledge-graph-creation.md](../prompts/repository-knowledge-graph-creation.md) — writes the knowledge files rule 2 starts from.

## Notes

- Load this document by path at runtime; do not paste its body into another artifact.
- Cite rules by number rather than quoting them.
- Navigation belongs in [README.md](./README.md), not in frontmatter.
