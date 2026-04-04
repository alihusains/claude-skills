# Self-Improving Agent Skill

This skill implements a loop to iteratively improve agent prompts and behavior.

## Workflow
1. Run task with current prompt.
2. Evaluate output against binary eval assertions (Pass/Fail).
3. If Fail: Analyze execution trace, adjust prompt, retry.
4. If Pass: Store best-performing prompt/config as new baseline.
