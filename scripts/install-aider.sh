#!/bin/bash
set -e

echo "🚀 Installing Claude Skills to Aider..."
TARGET_DIR="${1:-.aider}"

mkdir -p "$TARGET_DIR"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/claude-workspace"

echo "Concatenating skills into Aider CONVENTIONS.md..."
cat "$REPO_DIR/skills/"*/SKILL.md > "$TARGET_DIR/CONVENTIONS.md" 2>/dev/null || true

echo "✅ Copied skills to Aider CONVENTIONS.md."
