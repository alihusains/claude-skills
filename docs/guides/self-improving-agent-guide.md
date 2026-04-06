---
title: Self-Improving Agent Guide
description: "Continuous improvement through learning capture, error logging, and automatic skill extraction."
---

# Self-Improving Agent Guide

Log learnings and errors to markdown files for continuous improvement. Coding agents can later process these into fixes, and important learnings get promoted to project memory.

!!! tip "Source"
    Adapted from [peterskoett/self-improving-agent](https://github.com/peterskoett/self-improving-agent) by Peter Skoett.

## Quick Reference

| Situation | Action |
|-----------|--------|
| Command/operation fails | Log to `.learnings/ERRORS.md` |
| User corrects you | Log to `.learnings/LEARNINGS.md` (`correction`) |
| User wants missing feature | Log to `.learnings/FEATURE_REQUESTS.md` |
| API/external tool fails | Log to `.learnings/ERRORS.md` |
| Knowledge was outdated | Log to `.learnings/LEARNINGS.md` (`knowledge_gap`) |
| Found better approach | Log to `.learnings/LEARNINGS.md` (`best_practice`) |
| Broadly applicable | Promote to `CLAUDE.md` or `AGENTS.md` |

## Setup

```bash
mkdir -p .learnings
```

Create three log files:

- `LEARNINGS.md` — corrections, insights, knowledge gaps, best practices
- `ERRORS.md` — command failures, integration errors
- `FEATURE_REQUESTS.md` — requested capabilities

## Logging Format

### Learning Entry

```markdown
## [LRN-YYYYMMDD-XXX] category

**Logged**: ISO-8601 timestamp
**Priority**: low | medium | high | critical
**Status**: pending
**Area**: frontend | backend | infra | tests | docs | config

### Summary
One-line description

### Details
Full context

### Suggested Action
Specific fix or improvement

### Metadata
- Source: conversation | error | user_feedback
- Related Files: path/to/file.ext
- Tags: tag1, tag2
```

### Error Entry

```markdown
## [ERR-YYYYMMDD-XXX] skill_or_command_name

**Logged**: ISO-8601 timestamp
**Priority**: high
**Status**: pending

### Summary
Brief description of failure

### Error
Actual error message

### Context
- Command attempted
- Environment details

### Suggested Fix
What might resolve this
```

## Promotion Workflow

When a learning is broadly applicable, promote it:

| Target | What Belongs There |
|--------|-------------------|
| `CLAUDE.md` | Project facts, conventions, gotchas |
| `AGENTS.md` | Agent workflows, tool usage patterns |
| `SOUL.md` | Behavioral guidelines, principles |

### When to Promote

- Learning applies across multiple files/features
- Any contributor (human or AI) should know it
- Prevents recurring mistakes
- Documents project-specific conventions

## Automatic Skill Extraction

A learning qualifies for skill extraction when:

| Criterion | Description |
|-----------|-------------|
| **Recurring** | 2+ similar `See Also` links |
| **Verified** | Status is `resolved` with working fix |
| **Non-obvious** | Required debugging to discover |
| **Broadly applicable** | Useful across codebases |
| **User-flagged** | User says "save this as a skill" |

## Hook Integration

Enable automatic reminders:

```json
{
  "hooks": {
    "UserPromptSubmit": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "./skills/self-improvement/scripts/activator.sh"
      }]
    }]
  }
}
```

## Detection Triggers

Automatically log when you notice:

- **Corrections**: "No, that's not right...", "Actually, it should be..."
- **Feature Requests**: "Can you also...", "I wish you could..."
- **Knowledge Gaps**: User provides info you didn't know
- **Errors**: Command returns non-zero, exception, unexpected output

## Multi-Agent Support

Works with Claude Code, Codex, GitHub Copilot, OpenClaw, and any agent that supports file-based learning storage.
