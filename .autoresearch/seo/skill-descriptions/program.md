# Experiment: Skill Description SEO Optimization

## Objective
Optimize the `description` field in each skill's frontmatter to maximize:
1. **SEO discoverability** — include high-volume keywords: "agent skill", "plugin", "Claude Code", "Codex", "Gemini CLI", "Cursor", "MCP"
2. **Trigger accuracy** — the description must accurately describe when the skill activates
3. **Clarity** — one read should convey what the skill does
4. **Cross-platform appeal** — mention multi-tool compatibility where natural

## Constraints
- Description must be under 200 characters (plugin.json limit)
- Must NOT be spammy or keyword-stuffed — natural language only
- Must preserve the skill's actual purpose and capabilities
- Do NOT modify anything outside the `description:` field in frontmatter
- One skill per experiment iteration

## Strategy
- Run the evaluator (`python3 eval.py TARGET_FILE`) to get a score from 0-100.
- Rewrite the description naturally incorporating the keywords.
- Re-run evaluator. If score improves, keep it.

## Target Skills (in priority order)
1. community-addons/skills/*.md
2. engineering/*.md
3. marketing-skill/*.md
