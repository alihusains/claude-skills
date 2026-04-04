> This file extends [common/testing.md](../common/testing.md) with Java specific content.

# Java Testing

## Frameworks
- ALWAYS use JUnit 5 (Jupiter) for unit testing.
- Use `Mockito` for mocking dependencies.
- Use `AssertJ` for expressive and fluent assertions.
- Use `Testcontainers` for integration tests requiring real databases or services.

## Spring Boot Testing
- Use `@SpringBootTest` for full integration tests.
- Use `@WebMvcTest` for testing web layers in isolation.
- Use `@DataJpaTest` for database-specific tests.
- Mock external APIs using `MockRestServiceServer`.
