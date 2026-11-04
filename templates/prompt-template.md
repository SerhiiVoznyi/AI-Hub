---
title: "Prompt Template"
type: template
summary: "Starter for a reusable prompt: the wrapper that documents it, and the copyable prompt block itself."
tags:
  - templates
  - prompts
  - starter
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities: []
inputs:
  - user objective
outputs:
  - prompt text
---

# Prompt Template

<!-- Copy into prompts/. Everything outside the fenced block documents the prompt; the fenced block is what gets copied and sent. -->
<!-- Describe what the executor must be able to do (read files, run commands, write files), never which product it is. -->
<!-- Section order below is fixed. Optional sections may be dropped, never reordered. Delete every comment before committing. -->

## Summary

<!-- One short paragraph: what the prompt produces and what it refuses to do. -->

## Use When

- Situation where this prompt is the right tool.

## Do Not Use When

<!-- The neighbouring prompt or skill that fits those cases better. -->

- Adjacent situation, and what to use instead.

## Inputs

- Required: what the sender must supply, including anything pasted into a placeholder.
- Required capabilities: what the executor must be able to do, in capability terms.
- Optional: what improves the result.

## Outputs

<!-- The result contract, led by the result header if the prompt has one. Automation reads this section, so keep the field names exact. -->

- Result header fields, in order.
- The sections that follow it.

## How To Use

<!-- Numbered and executor-neutral: give the target the prompt needs, paste the inputs, send, then what to do with each terminal status. -->

1. Give the executor access to the target.
2. Replace the placeholder under the input heading.
3. Send the prompt block.

## Prompt

```text
Write the reusable prompt text here. It must stand alone: an executor receives this block and nothing else.
```

## Notes

<!-- Operating notes for the human: load-bearing parts, deliberate gates, known limits. Not a restatement of the prompt. -->

- What must not be changed casually, and why.

## Related

<!-- Relative links only. Replace the example below. -->

- `[sibling-prompt.md](./sibling-prompt.md)` — when that one answers the different question.
