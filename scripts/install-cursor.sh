#!/bin/bash
set -e

echo "🚀 Installing Claude Skills to Cursor..."
TARGET_DIR="${1:-.cursor/rules}"

mkdir -p "$TARGET_DIR"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/claude-workspace"

echo "Copying 153 skills to $TARGET_DIR..."
for skill_dir in "$REPO_DIR/skills/"*; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        if [ -f "$skill_dir/SKILL.md" ]; then
            cp "$skill_dir/SKILL.md" "$TARGET_DIR/${skill_name}.mdc"
        fi
    fi
done

echo "✅ Copied skills as Cursor Rules (.mdc)."
