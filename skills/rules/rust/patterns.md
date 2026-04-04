> This file extends [common/patterns.md](../common/patterns.md) with Rust specific content.

# Rust Patterns

## Common Patterns
- **Newtype Pattern**: Use for type safety and to implement external traits on external types.
- **Type-state Pattern**: Use to enforce state transitions at compile time using types.
- **RAII (Resource Acquisition Is Initialization)**: Use for automatic resource management (e.g., smart pointers, locks).
- **Builder Pattern**: Use for creating complex structs with many optional fields.

## Traits & Generics
- Prefer composition over inheritance.
- Use traits to define shared behavior.
- Use generic constraints (`where` clauses) for clarity.
