#!/usr/bin/env python3
"""
Memory Curator for Self-Improving Agent

A CLI tool that parses Claude Code's MEMORY.md file, extracts recurring patterns,
and suggests promotions to project rules or skills.

Usage:
  python memory_curator.py --memory-file ~/.claude/MEMORY.md --action review
"""

import argparse
import re
import os
from pathlib import Path
from collections import Counter

def parse_memory_file(filepath: str):
    """Parses MEMORY.md to extract topics and structure."""
    if not os.path.exists(filepath):
        print(f"⚠️ Memory file not found at {filepath}")
        return []

    memories = []
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Match common memory structures like "- [Topic](path.md) - description"
    pattern = re.compile(r"-\s+\[(.*?)\]\((.*?\.md)\)\s*(?:[-—]\s*(.*))?")

    for match in pattern.finditer(content):
        title, file_path, description = match.groups()
        memories.append({
            "title": title.strip(),
            "file": file_path.strip(),
            "description": description.strip() if description else ""
        })

    return memories

def review_memory(memories):
    """Analyzes memories and suggests actions."""
    print(f"🧠 Memory Review Dashboard")
    print(f"===========================")
    print(f"Total entries: {len(memories)}\n")

    if not memories:
        print("No memories to analyze.")
        return

    # Extract common themes/keywords from titles
    words = []
    for mem in memories:
        # Simple tokenization for demo
        tokens = re.findall(r'\b\w+\b', mem['title'].lower())
        words.extend([t for t in tokens if len(t) > 3])

    common_themes = Counter(words).most_common(5)

    print("📈 Top Memory Themes:")
    for theme, count in common_themes:
        print(f"  - {theme.capitalize()} ({count} occurrences)")

    print("\n🚀 Promotion Candidates (Rules/Skills):")
    candidates = [m for m in memories if any(kw in m['title'].lower() for kw in ['fix', 'error', 'pattern', 'prefer', 'always'])]

    if candidates:
        for c in candidates[:3]: # Show top 3
            print(f"  💡 {c['title']} -> Consider '/si:promote' or '/si:extract'")
    else:
        print("  No immediate promotion candidates found.")

def main():
    parser = argparse.ArgumentParser(description="Self-Improving Agent Memory Curator")
    parser.add_argument("--memory-file", type=str, default=os.path.expanduser("~/.claude/MEMORY.md"), help="Path to MEMORY.md")
    parser.add_argument("--action", choices=["review", "status"], required=True)

    args = parser.parse_args()

    memories = parse_memory_file(args.memory_file)

    if args.action == "review":
        review_memory(memories)
    elif args.action == "status":
        print(f"✅ Memory System Online. Tracking {len(memories)} contextual links.")

if __name__ == "__main__":
    main()
