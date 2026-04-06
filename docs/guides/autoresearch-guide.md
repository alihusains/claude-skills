---
title: Autoresearch Guide
description: "Autonomous goal-directed iteration — one metric, constrained scope, fast verification, automatic rollback. Works on any domain."
---

# Autoresearch Guide

Autonomous goal-directed iteration based on [Karpathy's autoresearch](https://github.com/karpathy/autoresearch). One metric, constrained scope, fast verification, automatic rollback, git as memory. Works on **any domain** — code, content, marketing, sales, DevOps — anything with a measurable metric.

!!! tip "Source"
    Adapted from [uditgoenka/autoresearch](https://github.com/uditgoenka/autoresearch) by Udit Goenka.

## Core Loop

```
Modify → Verify → Keep/Discard → Repeat
```

## Commands

| Command | Purpose |
|---------|---------|
| `autoresearch` | Autonomous iteration loop (unlimited or bounded) |
| `autoresearch:plan` | Interactive wizard: Goal → Scope, Metric, Direction, Verify |
| `autoresearch:debug` | Autonomous bug-hunting with scientific method |
| `autoresearch:fix` | Autonomous error repair until zero errors |
| `autoresearch:security` | STRIDE + OWASP + red-team security audit |
| `autoresearch:ship` | Universal shipping workflow — 8 phases, 9 shipment types |
| `autoresearch:scenario` | Scenario exploration — 12 dimensions, edge cases |
| `autoresearch:predict` | Multi-persona swarm — 5 expert perspectives |
| `autoresearch:learn` | Autonomous documentation engine |
| `autoresearch:reason` | Adversarial refinement with blind judge panel |

## Quick Start

### Basic Autonomous Loop

```
autoresearch
Goal: Increase test coverage from 72% to 90%
Scope: src/**/*.test.ts, src/**/*.ts
Metric: coverage % (higher is better)
Verify: npm test -- --coverage | grep "All files"
Iterations: 50
```

### Interactive Planning

```
autoresearch:plan
Goal: Make the API respond faster
```

The wizard walks you through scope, metric, direction, and verify with dry-run validation.

### Hunt All Bugs

```
autoresearch:debug
Scope: src/api/**/*.ts
Symptom: API returns 500 on POST /users
Iterations: 20
```

### Fix All Errors

```
autoresearch:fix
```

Auto-detects broken tests/types/lint/build, fixes one at a time, stops at zero.

### Security Audit

```
autoresearch:security
Scope: src/**/*.ts
Iterations: 10
```

### Ship a PR

```
autoresearch:ship --auto
```

## Configuration

| Field | Required | Description |
|-------|----------|-------------|
| `Goal` | Yes | What you want to achieve (plain language) |
| `Scope` | Yes | Glob patterns for modifiable files |
| `Metric` | Yes | What number to optimize |
| `Verify` | Yes | Shell command that outputs the metric |
| `Guard` | No | Safety command (prevents regressions) |
| `Iterations` | No | Stop after N iterations (default: unlimited) |
| `Direction` | No | `higher` or `lower` |

## 8 Critical Rules

1. **Loop until done** — unbounded: forever. Bounded: N times then summarize.
2. **Read before write** — understand full context before modifying.
3. **One change per iteration** — atomic changes. If it breaks, you know why.
4. **Mechanical verification only** — no subjective "looks good." Use metrics.
5. **Automatic rollback** — failed changes revert via `git revert`.
6. **Simplicity wins** — equal results + less code = KEEP.
7. **Git is memory** — experiments committed with `experiment:` prefix.
8. **When stuck, think harder** — re-read, combine near-misses, try radical changes.

## Chaining Commands

```bash
autoresearch:debug --fix                        # debug → auto-fix
autoresearch:predict --chain debug              # predict → debug
autoresearch:predict --chain scenario,debug,fix # full quality pipeline
autoresearch:reason --chain predict             # converge → stress-test
```

## Results Tracking

Every iteration is logged in TSV format:

```
iteration  commit   metric  delta   status    description
0          a1b2c3d  85.2    0.0     baseline  initial state
1          b2c3d4e  87.1    +1.9    keep      add tests for auth edge cases
2          -        86.5    -0.6    discard   refactor test helpers (broke 2)
3          c3d4e5f  88.3    +1.2    keep      add error handling tests
```

## Multi-Agent Support

Works with Claude Code, Codex, OpenCode, Gemini CLI, and any agent that supports git-based iteration loops.
