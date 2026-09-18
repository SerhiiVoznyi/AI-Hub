---
title: ".NET Options, HTTP, and Host Lifecycle"
type: skill
tags:
  - skills
  - dotnet
  - configuration
  - http
  - lifecycle
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: agnostic
inputs:
  - required settings and endpoints
  - hosting model
outputs:
  - validated options
  - managed HTTP clients and shutdown
---

# Summary

Bind .NET configuration through validated options, call external APIs through factory-managed HTTP clients, and shut the host down gracefully, so misconfiguration and socket or cancellation problems surface early.

## Use When

- Adding settings, secrets, or external API calls to a .NET application.
- Implementing background services or reviewing shutdown behavior.
- Replacing `IConfiguration` lookups scattered through domain classes.

## Inputs

- Required:
  - the settings the feature needs and which are mandatory
  - external endpoints the application calls
- Optional:
  - secret stores and environment names
  - host stop timeout configuration

## Method

1. Bind configuration with the options pattern (`IOptions<T>`, `IOptionsSnapshot<T>`, or `IOptionsMonitor<T>`); inject options objects rather than `IConfiguration` into domain classes.
2. Validate options with `DataAnnotations` or `IValidateOptions<T>` at startup for critical settings so misconfiguration fails fast.
3. Register `HttpClient` through `IHttpClientFactory` with named clients and typed wrappers. Set explicit timeouts and respect cancellation.
4. Inject `ILogger<T>` and use structured templates and scopes. Avoid `Console.WriteLine` in production paths.
5. Propagate `CancellationToken` from ASP.NET Core requests or host shutdown into service and repository calls.
6. Use `IHostedService` / `BackgroundService` for long-running work and coordinate shutdown so in-flight work completes or fails fast within the host stop timeout.

## Failure Modes

- Pulling `IConfiguration` deep into domain classes instead of options objects.
- Creating `new HttpClient()` per call or per service instance without factory management.
- Swallowing startup validation errors so misconfiguration is discovered only in production.
- Use `dotnet-composition-and-di.md` for service registration and lifetime decisions.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
- Never log secrets, connection strings, or bearer tokens. Use placeholder redaction in examples and diagnostics.
