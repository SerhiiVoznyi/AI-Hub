---
title: "Node.js Configuration"
type: skill
summary: "Load configuration once into a typed object at the composition root and fail fast, so misconfiguration surfaces at startup."
tags:
  - skills
  - nodejs
  - configuration
  - runtime
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - runtime environment definition
  - required settings and secrets
outputs:
  - typed configuration surface
  - fail-fast validation
---

# Node.js Configuration

## Summary

Load Node.js configuration once into a typed object at the composition root and fail fast on missing or malformed values, so misconfiguration surfaces at startup rather than mid-request.

## Use When

- Introducing new environment variables, settings files, or parameter store lookups.
- Replacing scattered `process.env` reads with a single typed surface.
- Deciding how a service should behave when required settings are absent.

## Do Not Use When

- The task is wiring dependencies rather than loading settings — use [nodejs-composition-root.md](./nodejs-composition-root.md).
- The runtime is .NET — use [dotnet-options-and-http.md](./dotnet-options-and-http.md).

## Inputs

- Required:
  - the settings the feature needs and which are mandatory
- Optional:
  - deployment environment names
  - secret store or parameter store paths
  - existing configuration conventions in the codebase

## Method

1. Define a typed `Config` shape that names every setting the process needs, including defaults for genuinely optional values.
2. Load and validate configuration once at the composition root. Parse the raw environment into the typed shape with an explicit validator.
3. Fail fast on missing or malformed values with an error that names the offending setting. Do not fall back to silent defaults for required settings.
4. Inject the loaded configuration object into classes that need it. Do not read `process.env` inside business code.
5. Keep secrets out of logs and error messages. Reference the setting name, never the value.
6. Treat configuration as immutable after load; if a value must change at runtime, model that explicitly as a refreshable source.

## Quality Bar

- Every setting the process uses appears in one typed shape.
- A missing required setting stops startup with an error naming it.
- No `process.env` read exists outside the loader.
- No log or error message can emit a configuration value that may be secret.

## Failure Modes

- Reading `process.env` deep inside domain classes, which hides requirements and breaks tests.
- Defaulting a required secret or endpoint to a placeholder so startup succeeds and production fails later.
- Logging the full configuration object during startup diagnostics.

## Related

- [nodejs-composition-root.md](./nodejs-composition-root.md) — where configuration is loaded and injected.
- [nodejs-async-lifecycle.md](./nodejs-async-lifecycle.md) — timeouts that configuration usually supplies.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
- Configuration frequently carries credentials; apply the secrets handling clauses of the safety policy.
