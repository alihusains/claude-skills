> This file extends [common/coding-style.md](../common/coding-style.md) with Flutter/Dart specific content.

# Flutter/Dart Coding Style

## Formatter & Linter
- ALWAYS use `dart format` (replaces `dartfmt`).
- ALWAYS run `dart analyze` before every commit.
- Prefer `flutter analyze` for Flutter projects to catch platform-specific issues.

## Conventions
- ALWAYS use trailing commas in nested widget trees to improve formatting.
- ALWAYS use `const` constructors where possible to optimize widget rebuilding.
- Prefer `required` named parameters over optional positional parameters for better readability.
- Use `final` for all variables that don't change after initialization.

## Widget Structure
- Keep `build` methods small; extract large widget trees into separate `StatelessWidget` or `StatefulWidget` classes.
- Avoid using `logic` inside the `build` method; keep it in controllers or BLoCs.
