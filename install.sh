#!/bin/bash
echo "🚀 Installing Claude Complete Setup..."
mkdir -p ~/.claude/{skills,agents,hooks,scripts,mcp-configs}

# Copy structured categories
cp -r engineering ~/.claude/skills/ 2>/dev/null || true
cp -r product-team ~/.claude/skills/ 2>/dev/null || true
cp -r marketing-skill ~/.claude/skills/ 2>/dev/null || true
cp -r c-level-advisor ~/.claude/skills/ 2>/dev/null || true
cp -r finance ~/.claude/skills/ 2>/dev/null || true
cp -r project-management ~/.claude/skills/ 2>/dev/null || true
cp -r ra-qm-team ~/.claude/skills/ 2>/dev/null || true

# Copy community addons
cp -r community-addons/skills/* ~/.claude/skills/ 2>/dev/null || true

# Copy core scripts and agents
cp -r scripts/* ~/.claude/scripts/ 2>/dev/null || true
cp -r agents/* ~/.claude/agents/ 2>/dev/null || true

if [ -f settings.json ]; then
  cp settings.json ~/.claude/settings.json
fi
echo "✅ Done! Your Claude Code is now perfectly structured."
