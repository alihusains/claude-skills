#!/usr/bin/env python3
"""
Autonomous R&D Team Orchestrator

This script automates the Autonomous R&D loop for the claude-skills workspace.
It analyzes the system, identifies improvement opportunities, and validates changes.

Usage:
  python rd_orchestrator.py --action analyze
  python rd_orchestrator.py --action validate
"""

import os
import argparse
import subprocess
import json
from pathlib import Path
from datetime import datetime

def analyze_system(workspace_root: str):
    """Analyzes SOUL.md, sourcelist.md, and codebase metrics."""
    print("🔍 Phase 1: Analyzing System...")

    soul_path = Path(workspace_root) / "SOUL.md"
    sourcelist_path = Path(workspace_root) / "sourcelist.md"

    analysis = {
        "timestamp": datetime.now().isoformat(),
        "soul_exists": soul_path.exists(),
        "sourcelist_exists": sourcelist_path.exists(),
        "total_skills": 0,
        "total_scripts": 0
    }

    # Count skills (SKILL.md files)
    skills = list(Path(workspace_root).rglob("SKILL.md"))
    analysis["total_skills"] = len(skills)

    # Count python tools
    scripts = list(Path(workspace_root).rglob("*.py"))
    analysis["total_scripts"] = len(scripts)

    print(f"📊 Found {analysis['total_skills']} skills and {analysis['total_scripts']} Python tools.")

    # Check for empty script directories
    empty_dirs = []
    for skill in skills:
        script_dir = skill.parent / "scripts"
        if script_dir.exists() and not any(script_dir.iterdir()):
            empty_dirs.append(skill.parent.name)

    analysis["skills_needing_tools"] = empty_dirs

    with open("rd_analysis.json", "w") as f:
        json.dump(analysis, f, indent=2)

    print("✅ Analysis saved to rd_analysis.json")
    return analysis

def identify_improvements(analysis: dict):
    """Generates actionable R&D tasks based on analysis."""
    print("💡 Phase 2: Identifying High-Impact Improvements...")

    tasks = []

    if analysis.get("skills_needing_tools"):
        targets = ", ".join(analysis["skills_needing_tools"][:3])
        tasks.append(f"Develop Python CLI tools for skills: {targets}")

    tasks.append("Audit recently added MCP servers from sourcelist.md and build integration skills.")
    tasks.append("Run Tessl quality optimization on skills below 80% score.")

    print("\n🚀 Recommended R&D Tasks:")
    for i, task in enumerate(tasks, 1):
        print(f"  {i}. {task}")

    return tasks

def validate_changes():
    """Runs strict validation on the documentation site."""
    print("🛡️ Phase 4: Validating Changes...")
    try:
        print("Running mkdocs build --strict...")
        result = subprocess.run(["mkdocs", "build", "--strict"], capture_output=True, text=True)
        if result.returncode == 0:
            print("✅ Validation Passed: No regressions found in docs.")
            return True
        else:
            print("❌ Validation Failed:")
            print(result.stderr)
            return False
    except FileNotFoundError:
        print("⚠️ mkdocs not found. Skipping docs validation.")
        return True

def main():
    parser = argparse.ArgumentParser(description="Autonomous R&D Orchestrator")
    parser.add_argument("--action", choices=["analyze", "identify", "validate", "run_all"], required=True)
    parser.add_argument("--workspace", default=".", help="Path to workspace root")

    args = parser.parse_args()

    if args.action in ["analyze", "run_all"]:
        analysis = analyze_system(args.workspace)

    if args.action in ["identify", "run_all"]:
        if args.action == "identify":
            try:
                with open("rd_analysis.json", "r") as f:
                    analysis = json.load(f)
            except FileNotFoundError:
                print("⚠️ Run --action analyze first.")
                return
        identify_improvements(analysis)

    if args.action in ["validate", "run_all"]:
        validate_changes()

if __name__ == "__main__":
    main()
