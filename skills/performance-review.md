---
title: "Performance Review"
type: skill
summary: "Judge a change's cost at realistic scale by examining complexity, I/O patterns, allocation, concurrency, and caching, with measurement over guesswork."
tags:
  - skills
  - performance
  - code-review
  - scalability
status: draft
version: 0.1.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - run-commands
inputs:
  - change set
  - expected scale and workload
outputs:
  - performance findings with severity and evidence
---

# Performance Review

## Summary

Decide whether a change will still behave at production scale, by locating where its cost grows with input and whether that growth is bounded, measured, and acceptable.

## Use When

- A change touches a loop over external data, a query, a hot path, a large payload, caching, or concurrency.
- Data volume will plausibly grow by an order of magnitude over the code's lifetime.
- A review lead has routed a diff with a performance surface to a specialist.

## Do Not Use When

- The code runs once at startup on fixed-size input, where clarity beats speed.
- The concern is exploitability rather than cost — use [secure-code-review.md](./secure-code-review.md).
- The concern is failure behavior rather than throughput — use [serverless-operability-checks.md](./serverless-operability-checks.md).

## Inputs

- Required:
  - the diff and the changed-file list
  - the expected scale: how many records, requests, or events, and how that grows
- Optional:
  - existing benchmarks, profiles, query plans, or production metrics
  - latency, cost, or memory budgets the change must respect

## Method

1. Find the cost drivers first: what in this change scales with input, and with which input. A function's own complexity matters far less than how often it is called and with what.
2. Count I/O inside iteration. A call, query, or read per element is the dominant pattern in most real regressions; fetch in one round trip or batch deliberately.
3. Check that every unbounded read is bounded: pagination, limits, streaming, or an explicit cap. "The table is small today" is a finding, not a defense.
4. Examine queries as queries, not as code: the predicate, the index that serves it, the sort, and the join order. A query without a supporting index on a growing table is a defect regardless of current timing.
5. Check allocation and copying on hot paths: repeated materialization of a collection, string building in a loop, serialization performed more than once, buffers sized per call.
6. Check concurrency for real limits: pool sizes, parallelism bounds, backpressure, and whether a lock or a shared resource serializes work the design assumed was parallel. Unbounded parallelism is as much a defect as none.
7. Judge caching by correctness first: what invalidates the entry, what a stale read costs, and whether the key captures every input. A cache that cannot be invalidated is a liability.
8. Measure before asserting. Where a claim decides the verdict, run the benchmark, read the plan, or cite an existing profile. Where measurement is impossible, label the finding as reasoned and say what would confirm it.
9. Establish the baseline before the fix: state what the current cost is, not only that the new code is better.
10. Rank by impact at expected scale, and name the input size at which each finding starts to matter.

## Quality Bar

- Every finding cites `path:line`, names the cost driver, and states the scale at which it bites.
- Any claim that decides the verdict carries a measurement, a query plan, or an explicit "reasoned, not measured" label with what would settle it.
- Proposed changes state the trade: what the optimization costs in clarity, memory, or consistency.
- A clean review names what was examined and at what assumed scale, rather than only reporting nothing found.

## Failure Modes

- Micro-optimizing arithmetic while an I/O call sits inside the loop above it.
- Asserting a regression from reading code alone, when the runtime or the query planner decides it.
- Optimizing without a baseline, so the improvement cannot be shown and may not exist.
- Adding a cache that fixes the measurement and introduces a staleness bug nobody can reproduce.
- Treating current data volume as the permanent volume.

## Related

- [change-set-review.md](./change-set-review.md) — correctness and design in the same diff.
- [serverless-operability-checks.md](./serverless-operability-checks.md) — timeouts, retries, and failure behavior under load.
- [aws-lambda-runtime-reuse.md](./aws-lambda-runtime-reuse.md) — cold-start and invocation budget specifics.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Never benchmark or profile against production systems or real user data. Use synthetic data and dedicated environments.
