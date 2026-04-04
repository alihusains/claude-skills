---
name: backend-ecosystem-master-pro
description: Unified framework for Modern Backend Engineering, covering Python (Django/FastAPI), Java (Spring Boot), PHP (Laravel), Go (Concurrency), .NET (C#), and Node.js (Express/Fastify).
type: project
---

# Backend Ecosystem Master Guide

Integrated framework for state-of-the-art backend engineering, consolidating framework-specific mastery, architectural patterns, and production-ready security standards across the most widely adopted server-side ecosystems.

## 1. Python Mastery (Django & FastAPI)

### Django & DRF (Enterprise Stability)
- **Modular App Architecture**: Organize by domain/feature, not by type. Use `apps/` subdirectory to keep the root clean.
- **Service Layer & Repositories**: Extract business logic from `views.py` and `models.py` into dedicated `services/` or `logic/` modules to ensure DRY and testability.
- **Security Middleware**: Always enable `SecurityMiddleware`, `XFrameOptionsMiddleware`, and `CsrfViewMiddleware`. Use `django-environ` for 12-factor configuration.
- **Task Processing**: Use **Celery** with Redis/RabbitMQ for long-running tasks. Implement task idempotency to handle retries safely.

### FastAPI (High-Performance APIs)
- **Annotated Dependency Injection**: Use `Annotated[T, Depends(fn)]` (FastAPI 0.95+) for cleaner, type-safe dependency injection.
- **Pydantic V2 Validation**: Leverage Pydantic V2 for ultra-fast serialization and strict runtime type checking. Use `BaseModel` for request/response schemas.
- **Async/Await Primacy**: Use `async def` for I/O-bound operations (DB, API calls) to maximize throughput. Use `BackgroundTasks` for lightweight post-response work.

## 2. Java & Spring Boot Mastery

### Modern Spring Boot (3.x & Java 17/21)
- **Constructor Injection**: ALWAYS use constructor-based dependency injection. Avoid `@Autowired` on fields to ensure immutability and testability.
- **Repository Pattern (Spring Data JPA)**: Use `JpaRepository` for standard CRUD. Implement `CustomRepository` interfaces for complex queries involving `Criteria API` or `QueryDSL`.
- **Transactional Integrity**: Use `@Transactional(rollbackFor = Exception.class)` at the service level to ensure atomic business operations.
- **Validation & Exception Handling**: Use `jakarta.validation` constraints (`@NotNull`, `@Size`) on DTOs. Implement a global `@ControllerAdvice` for consistent API error responses.

## 3. PHP & Laravel Mastery

### Production Laravel (11.x)
- **Controllers -> Services -> Actions**: Decompose logic. Controllers handle requests, Services manage business state, and **Actions** (single-purpose classes) handle complex, reusable operations.
- **Eloquent Performance**: Always use `with()` (Eager Loading) to prevent N+1 query problems. Use `Query Scopes` for reusable, chainable filter logic.
- **Form Requests**: Extract validation logic from controllers into dedicated `FormRequest` classes for cleaner method signatures.
- **API Resources**: Use `JsonResource` to transform models into consistent, version-safe API responses.

## 4. Go (Golang) Concurrency & Architecture

### Scalable Go Systems
- **Concurrency Patterns**: Use **Goroutines** for parallelism, but always manage their lifecycle with `context.Context` for cancellation and timeouts.
- **Channel Discipline**: Prefer channels for communication between goroutines (CSP model). Use `select` with a `default` case for non-blocking operations.
- **Error Handling**: Follow the "Check Once, Handle Once" rule. Wrap errors with `%w` for context while preserving the root cause.
- **Clean Architecture**: Standardize on `cmd/` (entry points), `internal/` (private logic), and `pkg/` (public libraries) structures.

## 5. .NET (C#) & Clean Architecture

### Enterprise .NET (8.0+)
- **Clean Architecture (Onion)**: Separate layers into **Domain** (Entities/Interfaces), **Application** (Use Cases/DTOs), **Infrastructure** (EF Core/External APIs), and **Presentation** (Controllers/Minimal APIs).
- **EF Core Optimization**: Use `AsNoTracking()` for read-only queries to improve performance. Use `Global Query Filters` for multi-tenancy and soft deletes.
- **Minimal APIs**: Prefer Minimal APIs for lightweight microservices to reduce boilerplate and improve cold-start performance.
- **Dependency Injection (Built-in)**: Register services with appropriate lifetimes: `Transient` (stateless), `Scoped` (per-request), or `Singleton` (app-wide state).

## 6. Node.js (Express & Fastify) Mastery

### Async-First Node.js
- **Middleware Orchestration**: Use a standard middleware stack: `helmet` (security headers), `cors`, `compression`, and `morgan` (logging).
- **Error Boundaries**: Implement a centralized error-handling middleware that catches all `async` errors and returns standardized JSON responses.
- **TypeScript Integration**: Use `Zod` or `TypeBox` for runtime schema validation alongside TypeScript's compile-time safety.
- **Performance**: Use `Fastify` over `Express` for high-throughput requirements where JSON schema overhead is a bottleneck.

## 7. Cross-Cutting Backend Patterns

### Security & Authentication
- **JWT Architecture**: Use short-lived Access Tokens and long-lived Refresh Tokens (stored in `HttpOnly` cookies) to balance security and UX.
- **RBAC/ABAC**: Implement Role-Based Access Control at the middleware or decorator level to enforce least-privilege principles.
- **Rate Limiting**: Apply rate limiting (e.g., `Bucket4j` for Spring, `django-ratelimit`, or `slow-down` for Node) to all public endpoints.

### Caching & State
- **Cache-Aside Pattern**: Load data into Redis only on misses; invalidate caches immediately on writes to prevent stale data.
- **Distributed Locking**: Use Redlock (Redis) or database-level advisory locks for critical sections spanning multiple instances.

## 8. Backend Engineering Checklist

- [ ] **Validation**: All user input validated via schemas (Pydantic, Zod, Jakarta, Laravel FormRequests).
- [ ] **Transactions**: Multi-step DB updates wrapped in ACID-compliant transactions.
- [ ] **Security**: No hardcoded secrets; `HttpOnly` cookies for tokens; SQL injection prevention verified.
- [ ] **Observability**: Structured logging (JSON) and health checks (`/health`) implemented.
- [ ] **Performance**: N+1 queries eliminated via Eager Loading or Join FETCH.
- [ ] **Async**: Long-running work offloaded to task queues (Celery, Laravel Queues, Spring `@Async`).
- [ ] **Documentation**: OpenAPI/Swagger UI generated and verified against implementation.
- [ ] **Resilience**: Timeouts and retries configured for all external API/Service calls.
- [ ] **DI**: Constructor-based injection used where supported; no "God objects" created.
