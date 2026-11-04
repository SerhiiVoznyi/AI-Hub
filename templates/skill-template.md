---
title: "Skill Template"
type: template
summary: "Starter for an atomic capability: when to use it, the repeatable method, and the quality bar it must clear."
tags:
  - templates
  - skills
  - starter
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities: []
inputs:
  - task context
outputs:
  - reusable capability
---

# Skill Template

<!-- Copy into skills/. Filename is lowercase kebab-case and names the capability, not the model's internals. One capability per file. -->
<!-- Section order below is fixed. Optional sections may be dropped, never reordered. Delete every comment before committing. -->

## Summary

<!-- One or two sentences: what judgement or technique this gives the executor. Match the frontmatter summary in meaning, not wording. -->

## Use When

<!-- Concrete situations where this skill is the right choice. Name the trigger, not the benefit. -->

- Situation that makes this skill the right call.

## Do Not Use When

<!-- The adjacent cases this skill is wrong for, each pointing at what to use instead. This is what stops skill sprawl. -->

- Adjacent situation, and the skill that fits it better.

## Inputs

- Required:
  - what the executor must have before starting
- Optional:
  - what sharpens the result when available

## Method

<!-- Numbered, imperative, decidable. Each step should change what the executor does; drop any step that only restates good intentions. -->

1. First step.
2. Decision point, with the rule that settles it.
3. Expected result, stated so the next step can check it.

## Quality Bar

<!-- Checkable conditions. The executor verifies these before returning, and a reviewer can confirm them without rerunning the work. -->

- Condition that must hold for the output to be acceptable.

## Exceptions

<!-- Optional. Cases where the method is deliberately relaxed, with the limit on each. Omit when the method has none. -->

## Reference

<!-- Optional. Dense lookup material the method points to: file layouts, vocabularies, tables. Keep it skimmable, not prose. Omit when unused. -->

## Failure Modes

<!-- How this skill is misapplied in practice. Describe the mistake, not its absence. -->

- Common mistake and what it costs.

## Related

<!-- Relative links only; no bare filenames. One line each on when the other artifact takes over. Replace the example below. -->

- `[sibling-skill.md](./sibling-skill.md)` — when that one is the better fit.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Add a clause here only when this skill carries a risk the policies do not already cover.
