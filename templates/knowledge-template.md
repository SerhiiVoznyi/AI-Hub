---
title: "Knowledge Template"
type: knowledge
summary: "Starter for a shared contract: numbered rules other artifacts cite instead of restating."
tags:
  - templates
  - knowledge
  - starter
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities: []
inputs:
  - durable concept or contract
outputs:
  - compact reference document
---

# Knowledge Template

<!-- Copy into knowledge/. Use this for a contract several artifacts must share. If only one artifact needs it, it belongs in that artifact. -->
<!-- Number the rules so others can cite "rule 4" rather than quoting the text. Section order is fixed; optional sections may be dropped, never reordered. -->
<!-- This template is typed `knowledge` rather than `template` so copies inherit the right type. Set it correctly in the copy. -->

## Summary

<!-- One short paragraph: the concept, and who must obey it. -->

## Scope

<!-- What this document governs and what it deliberately leaves to another document. Prevents two contracts claiming the same ground. -->

## Rules

<!-- Numbered, imperative, independently citable. Each rule decides something; drop anything that only sounds prudent. -->

1. Rule.
2. Rule.

## Rationale

<!-- Optional. Why the non-obvious rules exist, so a later reader does not relax one by accident. Omit when the rules speak for themselves. -->

## Exceptions

<!-- When a rule yields, and who may authorize it. Write "none" rather than leaving this implicit. -->

## Related

<!-- Relative links only. Replace the example below. -->

- `[sibling-knowledge.md](./sibling-knowledge.md)` — the adjacent contract and its boundary.

## Notes

- Load this document by path at runtime; do not paste its body into another artifact.
- Navigation belongs in the folder's `README.md`, not in frontmatter.
