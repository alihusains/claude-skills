> This file extends [common/patterns.md](../common/patterns.md) with Flutter/Dart specific content.

# Flutter Patterns

## State Management
- Prefer `Provider`, `Riverpod`, or `BLoC` for complex applications.
- Use `ValueNotifier` or `ChangeNotifier` for simple state needs.
- Avoid excessive use of `setState` in large widget trees.

## Architecture
- Use Clean Architecture or Layered Architecture (Data, Domain, Presentation).
- Use the Repository Pattern to abstract data sources (Local vs Remote).
- Use Dependency Injection (e.g., `get_it`) for managing singleton instances and services.
