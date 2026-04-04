> This file extends [common/patterns.md](../common/patterns.md) with Java specific content.

# Java Patterns

## Enterprise Patterns
- Use the Repository Pattern (Spring Data JPA) for data access.
- Use the Service Layer to encapsulate business logic.
- Use DTOs (Data Transfer Objects) for API requests and responses.
- Implement the Builder Pattern for complex object creation (or use `@Builder` from Lombok).

## Dependency Injection
- ALWAYS use Constructor Injection over `@Autowired` on fields.
- Prefer defining dependencies as `final` in the constructor.
