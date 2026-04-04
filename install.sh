#!/bin/bash
echo "🚀 Installing Claude Complete Setup (Skills, Agents, Hooks, MCPs, Plugins)..."

# 1. Setup Directories
mkdir -p ~/.claude/{skills,agents,hooks,scripts}

# 2. Copy the Brain (Skills & Agents)
echo "🧠 Transferring Swarm Agents and Skills..."
cp -r engineering product-team marketing-skill c-level-advisor finance project-management ra-qm-team community-addons/skills/* ~/.claude/skills/ 2>/dev/null || true
cp -r scripts/* ~/.claude/scripts/ 2>/dev/null || true
cp -r agents/* ~/.claude/agents/ 2>/dev/null || true

# 3. Copy Automated Hooks
echo "🪝 Installing Global Hooks..."
cp -r hooks/* ~/.claude/hooks/ 2>/dev/null || true

# 4. Configure Plugins
if [ -f settings.json ]; then
  echo "🔌 Integrating Plugins and Marketplaces..."
  cp settings.json ~/.claude/settings.json
fi

# 5. Inject MCP Servers
if [ -f mcp-configs/mcp-servers.json ]; then
  echo "⚙️ Configuring MCP Servers..."
  if [ ! -f ~/.claude.json ]; then
    echo "{}" > ~/.claude.json
  fi
  
  # Merge the new MCP servers into the user's existing ~/.claude.json safely
  jq -s '.[0] * {"mcpServers": .[1]}' ~/.claude.json mcp-configs/mcp-servers.json > /tmp/merged-claude.json && mv /tmp/merged-claude.json ~/.claude.json
  echo "⚠️  Note: Some MCP servers (like Context7 or Pencil) require you to add your own API keys or binary paths in ~/.claude.json."
fi

echo "✅ Installation Complete! Your Claude Code is now fully evolved."
