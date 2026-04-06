---
name: autonomous-rd-team
description: Orchestrates an autonomous AI R&D team to continuously improve the Claude workspace, analyze skills, and push updates.
---

# Autonomous R&D Team

An orchestrator skill that activates a multi-agent R&D team to continuously improve the user's Claude workspace, skills, plugins, and tools.

<example>
User: "Run an R&D cycle to improve my workspace."
Agent: "Activating the Autonomous R&D Team. Let's analyze the current workspace and identify high-impact improvements."
</example>

## Core Responsibilities
1. **Maintain & Optimize**: Analyze current skills, agents, and hooks for modularity, scalability, and performance.
2. **Research & Integrate**: Check external sources (from `sourcelist.md`) and propose the addition of new skills.
3. **Personalization**: Keep `SOUL.md` updated with learned user behavior, style, and tech stack preferences.
4. **GitOps**: Ensure all improvements are correctly committed, tested, and released.

## The Autonomous Loop

When invoked, the R&D Team follows this strict sequence:

### 1. Analyze System
- Read `SOUL.md` for context and identity.
- Review recent updates in the codebase or specific domains (e.g., `skills/engineering/`).
- Audit the `sourcelist.md` for pending integrations.

### 2. Skill Cleanup, Upgrade, Improvement & Optimization
- **Deduplication:** When checking for new skills or reviewing the existing library, actively scan for duplicates. If found, compare them, extract the best methodologies from both, and merge them into a single, unified skill.
- **Continuous Power-Scaling:** Ensure that with every upgrade or merge, the resulting skill becomes demonstrably more powerful and robust.
- **Quality Over Everything:** Prioritize code quality and optimization. Strip out redundant instructions to save tokens, ensuring the workspace becomes smarter, leaner, and more efficient with each commit.

### 3. Identify High-Impact Improvements
- Generate 1-2 actionable tasks based on the analysis.
- Prioritize: UI/UX improvements, missing testing capabilities, new MCP server integrations, or code modularity.

### 4. Execute in Parallel
- Spawn specialized subagents using the Agent tool (e.g., `feature-dev:code-architect` or `ecc:planner`).
- Have agents draft the new skill markdown, python tools, or UI components.

### 5. Validate
- Verify the generated code and markdown formats.
- Check that nothing breaks existing workflows or the MkDocs site (`mkdocs build --strict`).

### 6. Update Documentation
- Ensure new skills are added to `mkdocs.yml` navigation.
- Update `CHANGELOG.md` with the new additions.

### 7. Commit and Release
- Create structured, conventional commits.
- Format: `feat(rd-team): add new continuous improvement skill`
- Generate a release if requested.

## Execution Requirements
- **Always** use the `TaskCreate` tool to make this multi-step loop visible to the user.
- **Always** finish by running `gh pr create` or `git push` if the user has approved the R&D outputs.
