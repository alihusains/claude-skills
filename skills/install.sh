#!/bin/bash

# Claude Ultimate Config - One-Shot Installer
# This script installs the complete Claude setup: Skills, Agents, Rules, Hooks, and Settings.

set -e

REPO_URL="https://github.com/alihusains/claude-skills"
TEMP_DIR=$(mktemp -d)
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$HOME/.claude_backup_$(date +%Y%m%d_%H%M%S)"

echo "🚀 Starting Claude Ultimate Config Installation..."

# 1. Create backup of existing config
if [ -d "$CLAUDE_DIR" ]; then
    echo "📂 Backing up existing configuration to $BACKUP_DIR..."
    cp -r "$CLAUDE_DIR" "$BACKUP_DIR"
fi

# 2. Clone the repository
echo "📥 Cloning repository..."
git clone --depth 1 "$REPO_URL" "$TEMP_DIR"

# 3. Create necessary directories
mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/rules"
mkdir -p "$CLAUDE_DIR/hooks"
mkdir -p "$CLAUDE_DIR/mcp-configs"

# 4. Install Components
echo "📦 Installing Components..."

# Install Skills
echo "  -> Installing Master Pro Skills..."
cp -r "$TEMP_DIR/skills/"* "$CLAUDE_DIR/skills/" 2>/dev/null || true

# Install Agents
echo "  -> Installing Custom Agents..."
cp -r "$TEMP_DIR/agents/"* "$CLAUDE_DIR/agents/" 2>/dev/null || true

# Install Rules
echo "  -> Installing Global Rules..."
cp -r "$TEMP_DIR/rules/"* "$CLAUDE_DIR/rules/" 2>/dev/null || true

# Install Hooks
echo "  -> Installing Custom Hooks..."
cp -r "$TEMP_DIR/hooks/"* "$CLAUDE_DIR/hooks/" 2>/dev/null || true

# Install MCP Configs
echo "  -> Installing MCP Server Configs..."
cp -r "$TEMP_DIR/mcp-configs/"* "$CLAUDE_DIR/mcp-configs/" 2>/dev/null || true

# Install Settings & Keybindings
echo "  -> Installing Settings & Keybindings..."
cp "$TEMP_DIR/config/settings.json" "$CLAUDE_DIR/settings.json"
cp "$TEMP_DIR/config/keybindings.json" "$CLAUDE_DIR/keybindings.json"

# Fix absolute paths in settings.json
echo "  -> Patching environment paths..."
# Use a temporary file for sed compatibility across platforms
sed "s|\$HOME|$HOME|g" "$CLAUDE_DIR/settings.json" > "$CLAUDE_DIR/settings.json.tmp" && mv "$CLAUDE_DIR/settings.json.tmp" "$CLAUDE_DIR/settings.json"

# 5. Cleanup
rm -rf "$TEMP_DIR"

echo "✅ Installation complete! Your Claude environment has been upgraded."
echo "🔄 Please restart your Claude Code session to apply the changes."
echo "💡 Use @using-superpowers to explore your new capabilities."
