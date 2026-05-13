---
title: ".NET Backend Implementation"
type: skill
tags:
  - skills
  - dotnet
  - aspnetcore
  - backend
  - execution
status: draft
version: 0.1.0
last_reviewed: 2026-05-13
tooling: agnostic
inputs:
  - approved work package
  - hosting model
  - integration boundaries
outputs:
  - composition-root wiring
  - configuration and logging
  - runtime-safe hosting
related:
  - ../skills/README.md
  - ../skills/dotnet-10-csharp-design.md
  - ../skills/aws-lambda-dotnet-implementation.md
  - ../skills/dotnet-10-csharp-test-design.md
  - ../knowledge/safety-policy.md
---

# Summary

Implement .NET backend and ASP.NET Core applications with a single **composition root**, explicit **DI** registrations, **options**-based configuration, structured logging, and graceful shutdown. Language rules live in `dotnet-10-csharp-design.md`; this skill covers hosting and runtime wiring.

## Use When

- Creating or changing `Program.cs`, startup filters, middleware pipelines, or background services.
- Wiring `IConfiguration`, `IOptions<T>`, `HttpClient`, databases, and message buses for .NET 10 workloads.

## Inputs

- Required:
  - approved objective and ordered steps
  - hosting surface (minimal APIs, controllers, worker service, generic host)
- Optional:
  - existing extension methods for service registration
  - deployment environment names and secret stores

## Method

1. Centralize registration in **one composition path** (for example `Program.cs` with `WebApplicationBuilder` or `HostApplicationBuilder`). Extract cross-cutting groups into `Add*` extension methods on `IServiceCollection` when it improves clarity, not to hide one-off globals.
2. Bind configuration with the **options pattern** (`IOptions<T>`, `IOptionsSnapshot<T>`, or `IOptionsMonitor<T>`) and validate options with `DataAnnotations` or `IValidateOptions<T>` at startup for critical settings.
3. Inject **`ILogger<T>`** into services; use structured templates and scopes. Avoid `Console.WriteLine` in production paths.
4. Register **`HttpClient`** via `IHttpClientFactory` with named clients and typed wrappers when calling external APIs. Set explicit timeouts and respect cancellation.
5. Propagate **`CancellationToken`** from ASP.NET Core requests or host shutdown into service and repository calls.
6. Use **`IHostedService` / `BackgroundService`** for long-running work; coordinate shutdown so in-flight work completes or fails fast within host stop timeout.
7. Avoid blocking async code in thread-pool threads; use `await` throughout the call graph.

## Failure modes

- Pulling `IConfiguration` deep into domain classes instead of options objects.
- Creating `new HttpClient()` per call or per service instance without factory management.
- Swallowing startup validation errors so misconfiguration is discovered only in production.

## Safety

- Follow [knowledge/safety-policy.md](../knowledge/safety-policy.md) for destructive operations, secrets, scope and approvals, supply chain, AWS safety, untrusted-input handling, and the OOP-default coding posture.
- Never log secrets, connection strings, or bearer tokens. Use placeholder redaction in examples and diagnostics.
