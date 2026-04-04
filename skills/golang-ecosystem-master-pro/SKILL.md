---
name: golang-ecosystem-master-pro
description: Unified framework for Professional Go Engineering, High-Performance Concurrency, gRPC Microservices, and Durable Workflows (Temporal/DBOS).
type: project
---

# Go Ecosystem Master Guide

Integrated framework for state-of-the-art Go engineering, consolidating idiomatic patterns, high-concurrency reliability, and cloud-native service architecture.

## 1. Idiomatic Go Design

### Core Principles
- **Accept Interfaces, Return Structs**: Define interfaces where they are used (consumer-side) to ensure loose coupling.
- **Make the Zero Value Useful**: Design types so their default state is functional (e.g., `sync.Mutex`, `bytes.Buffer`).
- **Composition over Inheritance**: Use struct embedding to share behavior, but avoid deep nesting.

### Struct & Option Patterns
- **Functional Options**: Use for complex constructors to provide a clean, extensible API.
  ```go
  func NewServer(opts ...Option) *Server { ... }
  ```
- **Small Interfaces**: Favor small, focused interfaces (e.g., `io.Reader`, `io.Writer`) to maximize reusability.

## 2. Concurrency & Parallelism Mastery

### Lifecycle Management
- **Context is King**: Always propagate `context.Context` for cancellation, timeouts, and tracing.
- **errgroup**: Use `golang.org/x/sync/errgroup` for coordinating multiple goroutines and capturing the first error.
- **Graceful Shutdown**: Implement `os.Signal` handling to allow in-flight requests to finish before exit.

### Safety & Performance
- **Worker Pools**: Use for rate-limiting concurrent operations and preventing resource exhaustion.
- **Avoiding Leaks**: Every goroutine must have a clear exit strategy (close channel or context cancellation).
- **sync.Pool**: Use for frequently allocated/deallocated objects to reduce GC pressure.

## 3. Error Handling Excellence

### Modern Patterns (Go 1.13+)
- **Wrapping with Context**: Use `fmt.Errorf("context: %w", err)` to preserve the original error for checking.
- **errors.Is & errors.As**: Use for checking sentinel errors (`errors.Is`) or extracting custom error types (`errors.As`).
- **Never Ignore Errors**: Handle errors immediately or explicitly discard them with `_ = ...` (only if documented).

### Custom Errors
- Define domain-specific error types for complex failure modes that require structured data.

## 4. Testing Strategy (testify & TDD)

### Methodology
- **Table-Driven Tests**: Use for testing multiple scenarios within a single function.
- **Interface-Based Mocking**: Use interfaces to mock external dependencies (DB, API) without code generation where possible.
- **testify**: Use `stretchr/testify/assert` for readable assertions and `mock` for complex interaction testing.

### Advanced Testing
- **Fuzzing**: Use native Go fuzzing (`f.Fuzz`) for robust input validation testing.
- **Golden Files**: Use for verifying large output structures (JSON, HTML) against known-good references.
- **Benchmarks**: Profile performance using `testing.B` and track memory allocations with `-benchmem`.

## 5. Microservices & gRPC

### Transport & Contracts
- **gRPC with Protobuf**: Use Buf for managing `.proto` contracts and ensuring backward compatibility.
- **Secure Transport**: Always use mTLS for service-to-service communication in production.
- **Interceptors**: Use for cross-cutting concerns like logging, auth, and metrics.

### Streaming
- Implement server-side, client-side, and bidirectional streaming for high-throughput or real-time data.

## 6. Durable Workflows (Temporal & DBOS)

### Reliable Orchestration
- **Workflow Determinism**: Ensure workflows are deterministic (no non-deterministic side effects inside workflow code).
- **Activity Pattern**: Offload non-deterministic work (DB, API calls) to Activities.
- **State Management**: Leverage Temporal's durable state to handle long-running business processes (days/months).

## 7. Go Ecosystem Engineering Checklist
- [ ] **Idioms**: "Accept interfaces, return structs" pattern followed.
- [ ] **Error**: Errors wrapped with context and checked via `errors.Is`/`As`.
- [ ] **Context**: Context propagated to all I/O and concurrent operations.
- [ ] **Concurrency**: No goroutine leaks; all goroutines have an exit path.
- [ ] **Tests**: Table-driven tests implemented for complex logic.
- [ ] **Mocking**: External dependencies mocked via interfaces.
- [ ] **Performance**: Benchmarks created for performance-critical paths.
- [ ] **Protobuf**: API contracts managed via Buf and versioned correctly.
