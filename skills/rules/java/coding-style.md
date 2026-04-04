> This file extends [common/coding-style.md](../common/coding-style.md) with Java specific content.

# Java Coding Style

## Conventions
- ALWAYS follow standard Java naming conventions (PascalCase for classes, camelCase for methods/variables).
- Prefer `Google Java Style` or standard `Spring Boot` conventions.
- Use `final` for variables and parameters that are not intended to be changed.
- Avoid using `null` where possible; use `Optional<T>` for return types that may be empty.

## Modern Java (17+)
- Use `records` for data-only classes (DTOs).
- Use `var` for local variable type inference where it improves readability.
- Prefer `switch` expressions and pattern matching for cleaner logic.
- Use the Stream API for collection processing instead of manual loops.
