---
title: Hooks Guide
description: "Comprehensive guide to Claude Code hooks — event-driven automations for code quality, security, and productivity."
---

# Hooks Guide

Hooks are event-driven automations that fire before or after Claude Code tool executions. They enforce code quality, catch mistakes early, and automate repetitive checks — all without manual intervention.

!!! tip "Source"
    Hooks system adapted from [everything-claude-code](https://github.com/affaan-m/everything-claude-code) by Affaan M.

## How Hooks Work

```
User request → Claude picks a tool → PreToolUse hook → Tool executes → PostToolUse hook
```

## Hook Types

| Type | When | Can Block? |
|------|------|-----------|
| **PreToolUse** | Before tool execution | Yes (exit 2) |
| **PostToolUse** | After tool completion | No |
| **Stop** | After each Claude response | No |
| **PreCompact** | Before context compaction | No |
| **SessionStart** | New session begins | No |
| **SessionEnd** | Session ends | No |

## Included Hooks

### Safety & Quality

| Hook | What It Does |
|------|-------------|
| Block `--no-verify` | Prevents bypassing git pre-commit hooks |
| Pre-commit quality | Lint staged files, validate commit messages, detect secrets |
| Config protection | Block modifications to linter/formatter configs |
| MCP health check | Verify MCP server health before tool calls |
| Large file blocker | Prevent creating files over 800 lines |

### Developer Experience

| Hook | What It Does |
|------|-------------|
| Auto tmux dev | Start dev servers in tmux automatically |
| Tmux reminder | Suggest tmux for long-running commands |
| Git push reminder | Review changes before pushing |
| Strategic compact | Suggest `/compact` at logical intervals |
| Desktop notify | macOS/WSL notification when Claude responds |

### Automation

| Hook | What It Does |
|------|-------------|
| Edit accumulator | Batch format+typecheck at Stop instead of per-edit |
| Command audit log | Log all bash commands for audit |
| Cost tracker | Track token and cost metrics per session |
| Session bootstrap | Load previous context on session start |
| Continuous learning | Capture tool observations for pattern extraction |

## Quick Setup

### Install via Plugin

```bash
# The hooks are included when you install the plugin
claude plugin install alihusains-ultimate-setup
```

### Manual Configuration

Add to your `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write",
        "hooks": [{
          "type": "command",
          "command": "node -e \"let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{const i=JSON.parse(d);const c=i.tool_input?.content||'';const lines=c.split('\\n').length;if(lines>800){console.error('[Hook] BLOCKED: '+lines+' lines');process.exit(2)}console.log(d)})\""
        }],
        "description": "Block files over 800 lines"
      }
    ]
  }
}
```

## Runtime Controls

```bash
# Set profile: minimal | standard | strict
export ECC_HOOK_PROFILE=standard

# Disable specific hooks
export ECC_DISABLED_HOOKS="pre:bash:tmux-reminder"
```

## Writing Custom Hooks

```javascript
// my-hook.js
let data = '';
process.stdin.on('data', chunk => data += chunk);
process.stdin.on('end', () => {
  const input = JSON.parse(data);

  // Access: input.tool_name, input.tool_input, input.tool_output
  
  if (shouldBlock) {
    console.error('[Hook] Blocked because...');
    process.exit(2); // PreToolUse only
  }

  console.log(data); // Pass through
});
```

## Common Recipes

=== "TODO Warning"
    ```json
    {
      "matcher": "Edit",
      "hooks": [{"type": "command", "command": "node -e \"...\""}],
      "description": "Warn about TODO/FIXME additions"
    }
    ```

=== "Python Format"
    ```json
    {
      "matcher": "Edit",
      "hooks": [{"type": "command", "command": "node -e \"...ruff format...\""}],
      "description": "Auto-format Python with ruff"
    }
    ```

=== "Test Reminder"
    ```json
    {
      "matcher": "Write",
      "hooks": [{"type": "command", "command": "node -e \"...test file check...\""}],
      "description": "Remind to create tests for new source files"
    }
    ```
