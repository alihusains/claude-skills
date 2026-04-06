---
name: ar-swarm
description: Launch 5+ parallel agents to optimize multiple files simultaneously
---

# /ar-swarm

Launch an autonomous multi-agent swarm to optimize your code, prompts, or configuration across multiple files simultaneously.

## Usage

```
/ar-swarm
```

## Description
This command launches the orchestrator script (`meta_autoresearch.py`) which spawns 5 parallel threads. Each thread acts as an independent agent to mutate target files, evaluate them, scrape web context, and aggregate results.

## Skill Reference
→ `engineering/autoresearch-agent/SKILL.md`
