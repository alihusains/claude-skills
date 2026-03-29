---
name: continuous-agent-loop
description: Canonical patterns for autonomous agent loops with quality gates, evals, and recovery controls. Supersedes autonomous-loops.
origin: ECC
---

# Continuous Agent Loop

This is the canonical guidance for running Claude Code in autonomous loops. It covers patterns from simple sequential pipelines to RFC-driven multi-agent orchestration.

## Loop Pattern Selection

| Pattern | Complexity | Best For | Reference |
|---------|-----------|----------|-----------|
| **Sequential** | Low | Daily dev steps, scripted workflows | [See below](#1-sequential-pipeline) |
| **NanoClaw** | Low | Interactive persistent sessions | `/claw` |
| **Infinite** | Medium | Spec-driven generation, many variations | [See below](#3-infinite-agentic-loop) |
| **Continuous PR** | Medium | Multi-day iterative projects with CI gates | `continuous-claude` |
| **Ralphinho** | High | Large features, parallel implementation | `ralphinho-rfc-pipeline` |

---

## 1. Sequential Pipeline (`claude -p`)

Break work into focused, non-interactive steps. Fresh context window per call prevents drift.

```bash
#!/bin/bash
set -e

# Phase 1: Implement (TDD)
claude -p "Implement OAuth2 login in src/auth/. Write tests first."

# Phase 2: De-sloppify (Cleanup)
claude -p "Review changes. Remove redundant type tests and overly defensive checks. Run tests."

# Phase 3: Verify & Commit
claude -p "Run build + lint + tests. Create conventional commit if passing."
```

## 2. De-Sloppify Pattern

**Crucial add-on for any loop.** Instead of using negative instructions (which weaken performance), let the model be thorough, then run a dedicated cleanup pass.

**Cleanup Directives:**
- Remove tests for language/framework features (e.g., testing if TS generics work).
- Remove redundant runtime type checks that the type system already enforces.
- Remove console.log and commented-out code.
- Ensure business logic coverage is preserved.

## 3. Infinite Agentic Loop

Two-prompt orchestration for parallel generation.
1. **Orchestrator**: Parses spec, assigns unique creative directions and iteration numbers to N sub-agents.
2. **Sub-Agents**: Follow the assigned direction exactly.

## 4. Ralphinho (RFC-Driven DAG)

Decompose an RFC into a dependency tree of work units.
- **Complexity Tiers**: Trivial (impl->test) to Large (research->plan->impl->test->review).
- **Author-Bias Elimination**: Reviewers never review their own code.
- **Merge Queue**: Intelligent rebasing and conflict recovery.

---

## Failure Modes & Recovery

- **Loop Churn**: Repeated retries without progress. -> *Freeze and reduce scope.*
- **Cost Drift**: Unbounded escalation. -> *Set max-runs/max-cost limits.*
- **Recovery**: Run `/harness-audit` and replay with explicit acceptance criteria.
