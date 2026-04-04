> This file extends [common/testing.md](../common/testing.md) with Flutter/Dart specific content.

# Flutter Testing

## Frameworks
- Use `flutter_test` (built-in) for unit and widget tests.
- Use `integration_test` for end-to-end (E2E) testing.
- Use `mockito` or `mocktail` for dependency mocking.

## Strategies
- ALWAYS test business logic (BLoCs/Controllers) with pure unit tests.
- Use Widget tests for UI components to ensure layout and interaction logic is correct.
- Mock all network calls and database operations using `mockito`.
- Target 80%+ coverage for all business logic and critical UI flows.
