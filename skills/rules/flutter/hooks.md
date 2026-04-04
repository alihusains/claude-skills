> This file extends [common/hooks.md](../common/hooks.md) with Flutter/Dart specific content.

# Flutter Hooks

## PreToolUse
- Auto-run `dart format` before any `Edit` or `Write` operations on `.dart` files.
- Trigger `flutter analyze` after major refactorings.

## PostToolUse
- Check for `// TODO` or `// FIXME` in new code.
- Verify that `const` was added where suggested by the linter.
