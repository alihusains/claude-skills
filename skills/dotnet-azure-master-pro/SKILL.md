---
name: dotnet-azure-master-pro
description: Unified framework for Modern .NET (C# 12/13) and Azure Cloud Architecture, covering Minimal APIs, EF Core performance, Managed Identity, and Serverless (Functions).
type: project
---

# .NET & Azure Ecosystem Master Guide

Integrated framework for state-of-the-art .NET engineering and Azure cloud native architecture, consolidating modern C# standards, high-performance data access, and secure cloud identity.

## 1. Modern C# Mastery (C# 12/13)

### Language Standards
- **Primary Constructors**: Use primary constructors in `class` and `struct` definitions for cleaner dependency injection.
- **Collection Expressions**: Use `[]` syntax for concise collection initialization (e.g., `int[] row = [1, 2, 3];`).
- **Required Members**: Enforce object initialization using the `required` modifier to replace redundant constructors.
- **Raw String Literals**: Use `"""` for multi-line or JSON strings to avoid excessive escaping.

### Coding Patterns
- **Nullable Reference Types**: Enable globally to eliminate `NullReferenceException` at compile-time.
- **Pattern Matching**: Leverage `switch` expressions and property patterns for exhaustive and readable logic.
- **Memory Optimization**: Use `Span<T>` and `Memory<T>` for high-performance, allocation-free buffer management.

## 2. ASP.NET Core & Enterprise APIs

### Minimal APIs vs. Controllers
- **Minimal APIs**: Default for microservices and simple endpoints to reduce overhead and boilerplate.
- **Controllers**: Use for complex, multi-action resources that require traditional attribute routing and filter pipelines.
- **Middleware**: Implement custom exception handling and logging (Serilog) early in the request pipeline.

### Dependency Injection (DI)
- **Service Lifetimes**: Strict adherence to `Transient` (stateless), `Scoped` (per-request), and `Singleton` (app-lifetime).
- **Options Pattern**: Use `IOptionsSnapshot<T>` for re-loadable configuration without app restarts.

## 3. High-Performance EF Core

### Query Optimization
- **AsNoTracking**: Always use for read-only queries to bypass the change tracker and improve speed.
- **Compiled Queries**: Use `EF.CompileQuery` for high-frequency queries to eliminate repeated LINQ parsing overhead.
- **Split Queries**: Use `.AsSplitQuery()` to prevent "Cartesian Explosion" when including multiple collections.

### Database Hygiene
- **Migrations**: Always use `Add-Migration` and `Update-Database`. Never modify the DB schema manually.
- **Connection Pooling**: Enable pooling for high-throughput applications to reduce connection handshake latency.

## 4. Azure Cloud Architecture

### Identity & Security (DefaultAzureCredential)
- **Managed Identity**: Use `DefaultAzureCredential` to authenticate with Azure services without managing local secrets.
- **Production Chain**: Ensures `ManagedIdentityCredential` is used in Azure and `AzureCliCredential` or `VisualStudioCredential` is used during local development.
- **Least Privilege**: Grant granular RBAC roles (e.g., "Storage Blob Data Reader") instead of broad "Contributor" roles.

### Serverless & Messaging
- **Azure Functions**: Use the **Isolated Worker Model** for .NET 8+ to support the latest language features independently of the host process.
- **Durable Functions**: Use for stateful orchestrations (chained functions, fan-out/fan-in).
- **Service Bus**: Implement competing consumer patterns using `ServiceBusTrigger` for resilient, scalable message processing.

## 5. Testing & Quality Assurance

### Frameworks & Patterns
- **xUnit & Moq**: Standard for unit testing with isolated dependencies.
- **FluentAssertions**: Use for readable, domain-driven assertions (e.g., `result.Should().BeEquivalentTo(expected);`).
- **WebApplicationFactory**: Use for full integration testing of the API pipeline, including middleware and routing.

## 6. .NET & Azure Checklist
- [ ] Nullable Reference Types enabled in `.csproj`.
- [ ] `DefaultAzureCredential` used for all Azure SDK clients.
- [ ] `AsNoTracking()` applied to all read-only LINQ queries.
- [ ] Primary constructors used for DI where applicable.
- [ ] Global exception handling middleware implemented.
- [ ] Azure Function using Isolated Worker Model (.NET 8/9+).
- [ ] Key Vault used for any secrets that cannot use Managed Identity.
- [ ] 80%+ test coverage with meaningful assertions.
