---
title: "Secure Code Review"
type: skill
summary: "Review a change set for exploitable weaknesses by tracing trust boundaries, authorization, injection sinks, secrets, and dependencies."
tags:
  - skills
  - security
  - code-review
  - threat-modeling
status: draft
version: 0.1.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - run-commands
inputs:
  - change set
  - trust boundaries
outputs:
  - security findings with severity and exploit path
---

# Secure Code Review

## Summary

Examine a change for weaknesses an attacker could reach, by following untrusted data from where it enters to where it has effect, and judging each hop on whether the change widened what an attacker can do.

## Use When

- A change touches authentication, authorization, user input, data access, file or process execution, cryptography, or dependencies.
- A new boundary appears: an endpoint, an event consumer, an upload, a webhook, a deserializer.
- A review lead has routed a diff with a security surface to a specialist.

## Do Not Use When

- The change has no reachable attacker surface, and general correctness is the concern — use [change-set-review.md](./change-set-review.md).
- The concern is operational resilience rather than attack — use [serverless-operability-checks.md](./serverless-operability-checks.md).
- The concern is slowness, not exploitability — use [performance-review.md](./performance-review.md).

## Inputs

- Required:
  - the diff and the changed-file list
  - how the component is reached: callers, triggers, entry points
- Optional:
  - the project's threat model, authorization scheme, and data classification
  - dependency manifests and lockfiles

## Method

1. Map the trust boundaries the change touches. Name where data stops being trusted: the network edge, a queue, a file upload, a database read of user-supplied content, another service's response.
2. Trace each untrusted input from entry to sink. The sink is where it has effect: a query, a command, a path, a template, a deserializer, a redirect, a log, a rendered page.
3. At every sink, check the defense is structural rather than textual: parameterized queries, allowlists, safe APIs, and encoding chosen for the output context. Escaping by hand is a finding even when it currently works.
4. Check authorization at every new or changed path, and check it per object, not only per route. Authentication answers who; authorization answers whether this subject may touch this record.
5. Look for what the change made reachable, not just what it added. A newly public route, a relaxed guard, a widened scope, or a removed check is a finding even when no line of logic changed.
6. Check secrets handling: hard-coded credentials, secrets in logs or error messages, tokens in client-side code or build output, and credentials with a scope wider than the task.
7. Check cryptography by construction, not by algorithm name: key source and lifetime, randomness, comparison of secrets, and whether the change invented a scheme instead of using the platform's.
8. Check the supply chain when dependencies changed: what was added, whether it is pinned, whether it is the official source, and what it can reach at install and run time.
9. For each finding, state the exploit path concretely — who, from where, achieving what. A finding without a path is a hypothesis and must be labelled as one.
10. Assign severity by reachability and impact together. A theoretical flaw behind an internal guard is not the same as the same flaw on a public route.

## Quality Bar

- Every finding cites `path:line`, names the trust boundary crossed, and states the exploit path or is explicitly labelled unproven.
- Every new or changed entry point has an authorization verdict, including "no change required" with the reason.
- Secrets findings cite `path:line` and mark the value `REDACTED`; no secret is quoted.
- Severity reflects reachability, not category, and a clean review states what was examined rather than only that nothing was found.

## Failure Modes

- Pattern-matching on function names instead of tracing data to a sink, which misses the laundered path and flags the safe one.
- Checking authentication and calling it authorization, so any logged-in user reaches any record.
- Reporting every dependency advisory without asking whether the code reaches the vulnerable call.
- Assuming an internal service is trusted, when the change is exactly what made it reachable from outside.
- Ranking by category severity rather than by what this change actually exposes.

## Related

- [change-set-review.md](./change-set-review.md) — correctness, design, and scope drift in the same diff.
- [test-suite-quality-review.md](./test-suite-quality-review.md) — whether the tests would catch a regression of this finding.
- [frontend-api-client-seam.md](./frontend-api-client-seam.md) and [typescript-boundary-typing.md](./typescript-boundary-typing.md) — boundary validation patterns a finding can point at.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Never write, run, or commit a working exploit. Describe the path; do not demonstrate it against a live system.
- Never quote a discovered secret into findings, logs, or evidence.
