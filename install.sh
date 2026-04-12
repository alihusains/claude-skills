#!/bin/bash
set -e

echo "🚀 Installing Everything Claude Code (ECC) Complete Setup..."
echo "This will install Skills, Agents, Hooks, Commands, Rules, and MCPs."

CLAUDE_DIR="$HOME/.claude"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/claude-workspace"

# 1. Setup Directories
echo "📁 Setting up directories in $CLAUDE_DIR..."
mkdir -p "$CLAUDE_DIR"/{skills,agents,hooks/scripts,hooks/lib,commands,rules,scripts,mcp-configs}

# 2. Transfer the core brain (Skills, Agents, Commands, Rules)
echo "🧠 Transferring Swarm Agents, Skills, Commands, and Rules..."
cp -r "$REPO_DIR/skills/"* "$CLAUDE_DIR/skills/" 2>/dev/null || true
cp -r "$REPO_DIR/agents/"* "$CLAUDE_DIR/agents/" 2>/dev/null || true
cp -r "$REPO_DIR/commands/"* "$CLAUDE_DIR/commands/" 2>/dev/null || true
cp -r "$REPO_DIR/rules/"* "$CLAUDE_DIR/rules/" 2>/dev/null || true

# 3. Copy Automated Hooks and fix paths
echo "🪝 Installing Global Hooks..."
cp -r "$REPO_DIR/hooks/scripts/"* "$CLAUDE_DIR/scripts/" 2>/dev/null || true
if [ -d "$REPO_DIR/hooks/lib" ]; then
    cp -r "$REPO_DIR/hooks/lib/"* "$CLAUDE_DIR/scripts/lib/" 2>/dev/null || true
fi

if [ -f "$REPO_DIR/hooks/hooks.json" ]; then
    # Replace CLAUDE_DIR placeholder with actual home directory path
    sed "s|CLAUDE_DIR|$CLAUDE_DIR|g" "$REPO_DIR/hooks/hooks.json" > "$CLAUDE_DIR/hooks/hooks.json"
fi

# 4. Copy Context & Instructions
echo "📝 Setting up global context (AGENTS.md, CLAUDE.md)..."
cp "$REPO_DIR/AGENTS.md" "$CLAUDE_DIR/AGENTS.md" 2>/dev/null || true
cp "$REPO_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md" 2>/dev/null || true

# 5. Inject MCP Servers
if [ -f "$REPO_DIR/mcp-configs/mcp-servers.json" ]; then
  echo "⚙️ Configuring MCP Servers..."
  cp "$REPO_DIR/mcp-configs/mcp-servers.json" "$CLAUDE_DIR/mcp-configs/mcp-servers.json"
  
  if [ ! -f ~/.claude.json ]; then
    echo "{}" > ~/.claude.json
  fi
  
  # Merge the new MCP servers into the user's existing ~/.claude.json safely
  # Uses jq to merge without overwriting existing keys outside of mcpServers
  if command -v jq &> /dev/null; then
      jq -s '.[0] * {"mcpServers": .[1].mcpServers}' ~/.claude.json "$REPO_DIR/mcp-configs/mcp-servers.json" > /tmp/merged-claude.json && mv /tmp/merged-claude.json ~/.claude.json
      echo "⚠️  Note: Added placeholder MCP servers to ~/.claude.json. Remember to update YOUR_API_KEY placeholders!"
  else
      echo "⚠️  jq is not installed. Skipping automatic ~/.claude.json merging. Please manually copy MCP servers from $CLAUDE_DIR/mcp-configs/mcp-servers.json."
  fi
fi

echo ""
echo "✅ Installation Complete! Your Claude Code is now fully evolved."
echo "👉 Restart Claude Code or run /clear to apply all changes."
