---
title: ".NET Composition and DI"
type: skill
tags:
  - skills
  - dotnet
  - aspnetcore
  - dependency-injection
status: draft
version: 0.1.0
last_reviewed: 2026-09-18
tooling: agnostic
inputs:
  - approved work package
  - hosting model
outputs:
  - single composition path
  - explicit service registrations
---

# Summary

Register .NET services in one composition path with deliberate lifetimes, so the dependency graph for a host is readable in a single place instead of scattered across the solution.

## Use When

- Creating or changing `Program.cs`, startup filters, or service registration extensions.
- Adding a new service, repository, or adapter that other components depend on.
- Diagnosing captive dependencies or duplicate registrations.

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

## Failure Modes

- Registration spread across many files so no single place describes the graph.
- Captive dependencies from injecting scoped services into singletons.
- Injecting `IServiceProvider` into domain services to work around wiring problems.
- Use `dotnet-options-and-http.md` for configuration binding, HTTP clients, logging, and shutdown.
- Use `aws-lambda-dotnet-handler-composition.md` when the host is a Lambda function.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md). Do not restate its clauses.
