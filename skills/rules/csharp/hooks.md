> This file extends [common/hooks.md](../common/hooks.md) with C# specific content.

# C# Hooks

## PreToolUse
- Check for `.csproj` or `.sln` files to understand project context.
- Auto-format using `dotnet format` on file write.

## PostToolUse
- Run `dotnet build` or `dotnet check` after significant edits.
- Scan for unused `using` statements and remove them.
