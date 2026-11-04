---
title: ".NET Composition and DI"
type: skill
summary: "Register services in one composition path with deliberate lifetimes, so a host's dependency graph is readable in one place."
tags:
  - skills
  - dotnet
  - aspnetcore
  - dependency-injection
status: draft
version: 0.2.0
last_reviewed: 2026-11-04
capabilities:
  - read-files
  - edit-files
inputs:
  - approved work package
  - hosting model
outputs:
  - single composition path
  - explicit service registrations
---

# .NET Composition and DI

## Summary

Register .NET services in one composition path with deliberate lifetimes, so the dependency graph for a host is readable in a single place instead of scattered across the solution.

## Use When

- Creating or changing `Program.cs`, startup filters, or service registration extensions.
- Adding a new service, repository, or adapter that other components depend on.
- Diagnosing captive dependencies or duplicate registrations.

## Do Not Use When

- The task is configuration binding, HTTP clients, logging, or shutdown — use [dotnet-options-and-http.md](./dotnet-options-and-http.md).
- The host is a Lambda function — use [aws-lambda-dotnet-handler-composition.md](./aws-lambda-dotnet-handler-composition.md).
- The runtime is Node.js — use [nodejs-composition-root.md](./nodejs-composition-root.md).

## Inputs

- Required:
  - approved objective and ordered steps
  - hosting surface (minimal APIs, controllers, worker service, generic host)
- Optional:
  - existing `Add*` extension methods for service registration
  - deployment environment names

## Method

1. Centralize registration in one composition path (`Program.cs` with `WebApplicationBuilder` or `HostApplicationBuilder`).
2. Extract cross-cutting groups into `Add*` extension methods on `IServiceCollection` when it improves clarity, not to hide one-off globals.
3. Register concrete implementations against their interfaces so consumers depend on abstractions.
4. Choose lifetimes deliberately: singleton for stateless shared services, scoped for per-request state, transient for cheap short-lived objects. Never inject a scoped service into a singleton.
5. Keep domain classes free of `IServiceProvider`. Resolve dependencies through constructors, not service location.
6. Fail startup loudly when a required registration is missing rather than deferring the error to first use.

## Quality Bar

- One composition path describes the whole graph for the host.
- Every registration states a deliberate lifetime, with no scoped service captured by a singleton.
- No domain class takes `IServiceProvider`.
- A missing required registration fails at startup, not at first use.

## Failure Modes

- Registration spread across many files so no single place describes the graph.
- Captive dependencies from injecting scoped services into singletons.
- Injecting `IServiceProvider` into domain services to work around wiring problems.

## Related

- [dotnet-options-and-http.md](./dotnet-options-and-http.md) — options, HTTP clients, logging, and shutdown.
- [dotnet-10-csharp-oop-design.md](./dotnet-10-csharp-oop-design.md) — the interfaces being registered.
- [aws-lambda-dotnet-handler-composition.md](./aws-lambda-dotnet-handler-composition.md) — the Lambda bootstrap variant.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) and [knowledge/scoped-context-discipline.md](../knowledge/scoped-context-discipline.md). Do not restate their clauses.
