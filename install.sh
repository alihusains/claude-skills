#!/bin/bash
echo "🚀 Installing Claude Complete Setup..."
mkdir -p ~/.claude/{skills,agents,hooks,scripts}
cp -rn skills/* ~/.claude/skills/ 2>/dev/null || true
cp -rn agents/* ~/.claude/agents/ 2>/dev/null || true
cp -rn hooks/* ~/.claude/hooks/ 2>/dev/null || true
if [ -f settings.json ]; then
  cp settings.json ~/.claude/settings.json
fi
echo "✅ Done! Your Claude Code is now fully evolved."
