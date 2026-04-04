---
name: java-kotlin-master-pro
description: Unified framework for Modern Java (17/21) and Kotlin (1.9/2.0) development, covering Spring Boot 3, Android Jetpack Compose, Coroutines/Virtual Threads, and Enterprise Architecture.
type: project
---

# Java & Kotlin Ecosystem Master Guide

Integrated framework for state-of-the-art JVM engineering, consolidating modern Java/Kotlin standards, high-performance Spring Boot architectures, and reactive Android development.

## 1. Modern JVM Mastery (Java 21 / Kotlin 2.0)

### Java 21+ Standards
- **Virtual Threads (Project Loom)**: Enable high-concurrency with `spring.threads.virtual.enabled=true`. Use for I/O-bound tasks to replace complex reactive code.
- **Records & Pattern Matching**: Use `records` for immutable DTOs. Leverage `switch` expressions with record patterns for exhaustive domain logic.
- **Structured Concurrency**: Use `StructuredTaskScope` to manage groups of related tasks as a single unit of work.

### Kotlin 2.x Idioms
- **Context Receivers / Context Parameters**: Use to inject dependencies or scopes implicitly without passing them as arguments.
- **Sealed Hierarchies**: Model API responses and UI states using `sealed class` or `sealed interface` for exhaustive `when` expressions.
- **Null Safety**: Strict enforcement using `?`, `!!` (avoid), and `lateinit` (use sparingly). Prefer `constructor injection` to avoid `lateinit`.

## 2. Enterprise Spring Boot 3 Architecture

### Performance & Concurrency
- **Virtual Threading**: Default to virtual threads for WebMVC applications to achieve WebFlux-like scalability with imperative code.
- **GraalVM Native Image**: Use for serverless or resource-constrained environments to achieve sub-second startup times and lower memory footprint.
- **Caffeine Caching**: Standardize on Caffeine for high-performance, in-memory caching with precise eviction policies.

### Data Access (JPA & Hibernate 6)
- **Hibernate 6 Optimization**: Leverage improved HQL/JPQL translation. Use `@HttpConstraint` and `@BatchSize` to solve N+1 problems.
- **AsNoTracking Equivalent**: In Spring Data JPA, use `readOnly = true` in `@Transactional` or custom projections to bypass the Hibernate persistence context for read-heavy operations.
- **Database Migrations**: Standardize on **Flyway** for versioned, reproducible schema changes.

## 3. Kotlin Coroutines & Reactive Streams

### Structured Concurrency
- **Scope Discipline**: Always use `CoroutineScope`. Use `viewModelScope` (Android) or `serviceScope`. NEVER use `GlobalScope`.
- **Exception Handling**: Use `CoroutineExceptionHandler` at the root or `supervisorScope` when child failures should not propagate to siblings.
- **Dispatchers**: `Dispatchers.Main` (UI), `Dispatchers.IO` (Blocking I/O), `Dispatchers.Default` (CPU-bound).

### Flow & Channels
- **StateFlow vs SharedFlow**: Use `StateFlow` for state (emits last value to new subscribers). Use `SharedFlow` for events (one-time signals).
- **Backpressure**: Use `buffer()`, `conflate()`, or `collectLatest()` to handle producer-consumer speed mismatches.

## 4. Android Jetpack Compose & Clean Architecture

### UI Patterns
- **State Hoisting**: Keep composables stateless by moving state to the caller. Pass lambdas for event callbacks.
- **MVI Architecture**: Use a single `ViewState` stream. Combine it with `collectAsStateWithLifecycle()` to handle configuration changes safely.
- **Performance**: Use `remember` and `derivedStateOf` to minimize recompositions. Annotate stable classes with `@Stable` if the compiler misses them.

### Dependency Injection
- **Dagger/Hilt**: Standard for Android. Use `@ViewModelInject` (deprecated, use `@HiltViewModel`) for seamless DI into Compose-bound ViewModels.
- **Koin**: Lightweight alternative for pure Kotlin/KMP projects.

## 5. Build Systems & Testing

### Maven vs Gradle
- **Gradle Kotlin DSL**: Use `build.gradle.kts` for type-safe build configurations. Enable `configuration cache` and `remote build cache`.
- **Maven**: Use for strict, standardized XML-based builds. Leverage `maven-enforcer-plugin` to lock down dependency versions.

### Testing Stack
- **JUnit 5 + AssertJ**: The baseline for expressive assertions.
- **MockK / Mockito**: Use `MockK` for idiomatic Kotlin mocking (supports coroutines/suspend functions).
- **Testcontainers**: Mandatory for integration tests requiring real PostgreSQL, Redis, or Kafka instances.

## 6. Java & Kotlin Checklist
- [ ] `spring.threads.virtual.enabled` set to `true` (if using Java 21).
- [ ] No `field injection` (@Autowired on fields); use `constructor injection`.
- [ ] `StateFlow` used for UI state in Android/Compose.
- [ ] `Testcontainers` used for database integration tests.
- [ ] All DTOs implemented as `records` (Java) or `data classes` (Kotlin).
- [ ] `supervisorScope` used for independent parallel child tasks.
- [ ] `AsNoTracking` / `readOnly` transactions used for all GET endpoints.
- [ ] 80%+ test coverage with meaningful domain assertions.
