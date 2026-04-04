# Understanding Claude Hooks

Hooks are one of the most powerful features in Claude Code. They allow you to run automated logic at specific stages of an AI interaction.

## ❓ What are Hooks?
Think of hooks as "event listeners" for your AI assistant. Just like a Git Hook runs before a commit, a Claude Hook runs before a tool call or at the start of a session.

## 🛠 How are they Configured?
Hooks are defined in your `~/.claude/settings.json` file. There are several types:

1.  **SessionStart**: Runs exactly once when you start a new `claude` session.
2.  **PreToolUse**: Runs every time Claude is about to use a tool (like Read, Write, or Bash).
3.  **PostToolUse**: Runs after a tool has finished executing.
4.  **Stop**: Runs when you exit the session.

### Example Configuration:
```json
"hooks": {
  "PreToolUse": [
    {
      "matcher": "Bash|Write",
      "hooks": [
        {
          "type": "command",
          "command": "node ~/.claude/hooks/validate_safety.js"
        }
      ]
    }
  ]
}
```

## 🎯 What do they do?
In this Ultimate Config, hooks handle several critical tasks:

- **Context Protection**: Prevents raw tool output from flooding your chat window, keeping Claude focused.
- **Auto-Formatting**: Runs `prettier` or `dart format` automatically after Claude writes a file.
- **Security Scanning**: Checks for secrets or dangerous commands before they are executed.
- **State Management**: Updates your status line and saves session summaries.
- **Path Patching**: Ensures that your local environment paths are handled correctly across different machines.

## 📊 The Status Line
The `statusLine` is a special type of hook that controls the text at the bottom of your terminal. In this setup, it's configured to show you:
- Active branch info.
- Current task status.
- Context usage stats.
