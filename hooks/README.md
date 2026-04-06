# Hooks

Hooks are event-driven automations that fire before or after Claude Code tool executions. They enforce code quality, catch mistakes early, and automate repetitive checks.

> Adapted from [everything-claude-code](https://github.com/affaan-m/everything-claude-code) hooks system.

## How Hooks Work

```
User request → Claude picks a tool → PreToolUse hook runs → Tool executes → PostToolUse hook runs
```

- **PreToolUse** hooks run before the tool executes. They can **block** (exit code 2) or **warn** (stderr without blocking).
- **PostToolUse** hooks run after the tool completes. They can analyze output but cannot block.
- **Stop** hooks run after each Claude response.
- **SessionStart/SessionEnd** hooks run at session lifecycle boundaries.
- **PreCompact** hooks run before context compaction, useful for saving state.

## Hooks in This Plugin

### PreToolUse Hooks

| Hook | Matcher | Behavior | Exit Code |
|------|---------|----------|-----------|
| **Block --no-verify** | `Bash` | Blocks git hook-bypass flag to protect pre-commit hooks | 2 (blocks) |
| **Auto tmux dev** | `Bash` | Auto-start dev servers in tmux with directory-based session names | 0 |
| **Tmux reminder** | `Bash` | Suggests tmux for long-running commands (npm test, cargo build, docker) | 0 (warns) |
| **Git push reminder** | `Bash` | Reminds to review changes before `git push` | 0 (warns) |
| **Pre-commit quality** | `Bash` | Lint staged files, validate commit message, detect console.log/debugger/secrets | 2 (blocks critical) |
| **Doc file warning** | `Write` | Warns about non-standard documentation files | 0 (warns) |
| **Suggest compact** | `Edit\|Write` | Suggests manual `/compact` at logical intervals (~50 tool calls) | 0 (warns) |
| **Config protection** | `Write\|Edit\|MultiEdit` | Block modifications to linter/formatter configs — fix code, not configs | 2 (blocks) |
| **MCP health check** | `*` | Check MCP server health before MCP tool execution | 2 (blocks unhealthy) |
| **Governance capture** | `Bash\|Write\|Edit\|MultiEdit` | Capture governance events (secrets, policy violations) | 0 |
| **Continuous learning** | `*` | Capture tool use observations for learning (async) | 0 |

### PostToolUse Hooks

| Hook | Matcher | What It Does |
|------|---------|-------------|
| **Command audit log** | `Bash` | Audit log all bash commands to ~/.claude/bash-commands.log |
| **Cost tracker** | `Bash` | Log bash tool usage with timestamps for cost tracking |
| **PR logger** | `Bash` | Log PR URL and review command after `gh pr create` |
| **Build analysis** | `Bash` | Background analysis after build commands (async) |
| **Quality gate** | `Edit\|Write\|MultiEdit` | Fast quality checks after edits |
| **Design quality** | `Edit\|Write\|MultiEdit` | Warn when frontend edits drift toward generic template UI |
| **Edit accumulator** | `Edit\|Write\|MultiEdit` | Record edited file paths for batch format+typecheck at Stop |
| **Console.log warning** | `Edit` | Warn about console.log statements in edited files |
| **Continuous learning** | `*` | Capture tool use results for learning (async) |
| **Governance capture** | `Bash\|Write\|Edit\|MultiEdit` | Capture governance events from outputs |

### Lifecycle Hooks

| Hook | Event | What It Does |
|------|-------|-------------|
| **Session bootstrap** | `SessionStart` | Load previous context, detect package manager |
| **Pre-compact** | `PreCompact` | Save state before context compaction |
| **Batch format+typecheck** | `Stop` | Format (Biome/Prettier) and typecheck all edited JS/TS files |
| **Console.log audit** | `Stop` | Check all modified files for console.log |
| **Session summary** | `Stop` | Persist session state when transcript path available |
| **Pattern extraction** | `Stop` | Evaluate session for extractable patterns |
| **Cost tracker** | `Stop` | Emit lightweight run-cost telemetry markers |
| **Desktop notify** | `Stop` | macOS/WSL desktop notification with task summary |
| **Session end marker** | `SessionEnd` | Lifecycle marker and cleanup log |

## Runtime Hook Controls

Control hook behavior without editing `hooks.json`:

```bash
# minimal | standard | strict (default: standard)
export ECC_HOOK_PROFILE=standard

# Disable specific hook IDs (comma-separated)
export ECC_DISABLED_HOOKS="pre:bash:tmux-reminder,post:edit:typecheck"
```

Profiles:
- `minimal` — essential lifecycle and safety hooks only
- `standard` — balanced quality + safety checks (default)
- `strict` — additional reminders and stricter guardrails

## Writing Your Own Hook

Hooks are shell commands that receive tool input as JSON on stdin and output JSON on stdout.

```javascript
// my-hook.js
let data = '';
process.stdin.on('data', chunk => data += chunk);
process.stdin.on('end', () => {
  const input = JSON.parse(data);
  const toolName = input.tool_name;
  const toolInput = input.tool_input;

  // Warn (non-blocking): write to stderr
  console.error('[Hook] Warning message shown to Claude');

  // Block (PreToolUse only): exit with code 2
  // process.exit(2);

  // Always output the original data to stdout
  console.log(data);
});
```

**Exit codes:**
- `0` — Success (continue)
- `2` — Block the tool call (PreToolUse only)
- Other non-zero — Error (logged, does not block)

## Hook Input Schema

```typescript
interface HookInput {
  tool_name: string;       // "Bash", "Edit", "Write", "Read", etc.
  tool_input: {
    command?: string;      // Bash: the command
    file_path?: string;    // Edit/Write/Read: target file
    old_string?: string;   // Edit: text being replaced
    new_string?: string;   // Edit: replacement text
    content?: string;      // Write: file content
  };
  tool_output?: {          // PostToolUse only
    output?: string;
  };
}
```

## Common Hook Recipes

### Warn about TODO comments

```json
{
  "matcher": "Edit",
  "hooks": [{
    "type": "command",
    "command": "node -e \"let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{const i=JSON.parse(d);const ns=i.tool_input?.new_string||'';if(/TODO|FIXME|HACK/.test(ns)){console.error('[Hook] New TODO/FIXME added')}console.log(d)})\""
  }],
  "description": "Warn when adding TODO/FIXME comments"
}
```

### Block large file creation

```json
{
  "matcher": "Write",
  "hooks": [{
    "type": "command",
    "command": "node -e \"let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{const i=JSON.parse(d);const c=i.tool_input?.content||'';const lines=c.split('\\n').length;if(lines>800){console.error('[Hook] BLOCKED: File exceeds 800 lines ('+lines+')');process.exit(2)}console.log(d)})\""
  }],
  "description": "Block files larger than 800 lines"
}
```

### Auto-format Python with ruff

```json
{
  "matcher": "Edit",
  "hooks": [{
    "type": "command",
    "command": "node -e \"let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{const i=JSON.parse(d);const p=i.tool_input?.file_path||'';if(/\\.py$/.test(p)){const{execFileSync}=require('child_process');try{execFileSync('ruff',['format',p],{stdio:'pipe'})}catch(e){}}console.log(d)})\""
  }],
  "description": "Auto-format Python files with ruff after edits"
}
```

### Require test files alongside source

```json
{
  "matcher": "Write",
  "hooks": [{
    "type": "command",
    "command": "node -e \"const fs=require('fs');let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{const i=JSON.parse(d);const p=i.tool_input?.file_path||'';if(/src\\/.*\\.(ts|js)$/.test(p)&&!/\\.test\\.|\\.spec\\./.test(p)){const testPath=p.replace(/\\.(ts|js)$/,'.test.$1');if(!fs.existsSync(testPath)){console.error('[Hook] No test file for: '+p);console.error('[Hook] Expected: '+testPath)}}console.log(d)})\""
  }],
  "description": "Remind to create tests when adding source files"
}
```

## Related

- [Skills: Strategic Compact](../engineering/strategic-compact/) — Strategic compaction skill
- [Standards: Quality](../standards/quality/) — Code quality standards
- [ECC Source](https://github.com/affaan-m/everything-claude-code) — Original hooks implementation
