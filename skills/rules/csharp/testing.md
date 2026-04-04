> This file extends [common/testing.md](../common/testing.md) with C# specific content.

# C# Testing

## Frameworks
- ALWAYS use `xUnit` for unit and integration testing.
- Use `Moq` or `NSubstitute` for mocking dependencies.
- Use `FluentAssertions` for more readable and expressive test assertions.
- Use `Bogus` for generating realistic test data.

## ASP.NET Core Testing
- Use `WebApplicationFactory<T>` for integration tests of API endpoints.
- Use `Microsoft.AspNetCore.Mvc.Testing` for end-to-end flow testing.
- Target 80%+ test coverage.
