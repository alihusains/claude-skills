> This file extends [common/patterns.md](../common/patterns.md) with C# specific content.

# C# Patterns

## Design Patterns
- **Dependency Injection**: Use built-in DI for managing service lifetimes (Singleton, Scoped, Transient).
- **Repository Pattern**: Abstract data access from business logic.
- **Unit of Work Pattern**: Coordinate multiple repositories within a single transaction.
- **Options Pattern**: Use `IOptions<T>` for typed configuration management.

## Async/Await
- ALWAYS use `async/await` for I/O-bound operations.
- Avoid `Task.Run` for I/O-bound work; keep it for CPU-bound work only.
- Prefer `ValueTask<T>` for async methods that often complete synchronously.
