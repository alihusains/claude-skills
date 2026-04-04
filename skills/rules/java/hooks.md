> This file extends [common/hooks.md](../common/hooks.md) with Java specific content.

# Java Hooks

## PreToolUse
- Check for standard project structure (`src/main/java`, `src/test/java`).
- Auto-format using `Spotless` or `Checkstyle` if configured.

## PostToolUse
- Run `mvn compile` or `gradle build` after significant changes to verify syntax.
- Check for unused imports and remove them automatically.
