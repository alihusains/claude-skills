> This file extends [common/coding-style.md](../common/coding-style.md) with C# specific content.

# C# Coding Style

## Conventions
- ALWAYS follow standard C# naming conventions (PascalCase for classes/methods, camelCase for local variables).
- Use `dotnet format` to enforce style consistency.
- Prefer `var` for local variables when the type is obvious from the right-hand side.
- Use expression-bodied members for simple one-line methods and properties.

## Modern C# (10+)
- Use `record` types for immutable data objects.
- Use `global using` directives for common namespaces.
- Use `file-scoped namespaces` to reduce nesting.
- Enable `Nullable Reference Types` in all new projects.
