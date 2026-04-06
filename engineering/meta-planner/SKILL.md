---
name: meta-planner
description: An autonomous Meta Planning Agent that dynamically generates, evaluates, and revises execution plans for complex tasks based on intermediate feedback and continuous learning.
---

# Meta Planner

> "Plans are useless, but planning is indispensable." — Dwight D. Eisenhower

The Meta Planner is a POWERFUL-tier orchestration skill inspired by advanced autonomous agent architectures (like HealthFlow and OpenSpace). It acts as an overarching meta-agent that doesn't just create a static plan, but continuously evaluates the execution state, adjusts to roadblocks, and dynamically spawns or assigns tasks to specialized sub-agents.

## Core Capabilities

1. **Dynamic Plan Generation:** Translates complex objectives into a multi-step graph of dependencies rather than a linear checklist.
2. **Execution Monitoring:** Tracks the output of execution agents, grading success against defined acceptance criteria.
3. **Course Correction:** Re-plans automatically when a sub-agent hits a blocker, encounters an error, or discovers new information that invalidates the original assumptions.
4. **Agent Orchestration:** Identifies the right specialized skills or agents (e.g., `code-reviewer`, `tdd-guide`, `security-pen-testing`) needed for each node in the plan.

## When to Use

- **Complex Feature Development:** When a task spans frontend, backend, database, and infrastructure.
- **Ambiguous Requirements:** When the exact solution isn't clear and must be discovered through iterative prototyping.
- **R&D and Autonomous Loops:** When you want Claude to run continuously for multiple cycles to achieve a high-level goal without micro-management.

## How to Activate

You can invoke the Meta Planner in Claude Code by running:

```bash
/meta-plan "Integrate a new payment gateway across the web app and mobile app, ensuring PCI compliance."
```

Alternatively, invoke it contextually during a session:
> "Let's use the meta-planner skill to figure out how to refactor the entire authentication system."

## The Meta-Planning Loop

When activated, the Meta Planner enforces the following strict loop:

### Phase 1: Meta-Analysis
1. **Goal Decomposition:** Break the user's objective into smaller, verifiable milestones.
2. **Context Retrieval:** Search `MEMORY.md`, `SOUL.md`, and the codebase to gather historical constraints.
3. **Initial Graph Construction:** Create a DAG (Directed Acyclic Graph) of tasks.

### Phase 2: Orchestration & Delegation
1. Pick the first unblocked node in the task graph.
2. Assign it to a specialized agent (e.g., use the `Agent` tool to spawn `ecc:planner` or `feature-dev:code-architect`).
3. Define strict acceptance criteria for the node's success.

### Phase 3: Evaluation & Re-planning
1. Evaluate the output from the sub-agent.
2. **Success:** Mark the node as complete. Unlock dependent nodes.
3. **Failure/Blocker:** Activate the **Course Correction Protocol**. Analyze why it failed, generate a new hypothesis, and update the task graph dynamically.

### Phase 4: Synthesis
Once all terminal nodes are complete, compile a final report detailing what was done, what architectural shifts occurred during execution, and next steps for the user.

## Best Practices

- **Verifiable Nodes:** Ensure every task in the meta-plan can be tested (e.g., "Tests pass", "Endpoint returns 200", "Linter shows 0 errors").
- **Limit Depth:** Don't plan 20 steps ahead if step 3 is highly uncertain. Plan the first 3 steps in high fidelity, and the rest as placeholders.
- **Use TaskCreate:** Always use the `TaskCreate` tool to visualize the DAG for the user in real-time.

---
*Inspired by agentic workflows from HKUDS/OpenSpace and yhzhu99/HealthFlow.*
