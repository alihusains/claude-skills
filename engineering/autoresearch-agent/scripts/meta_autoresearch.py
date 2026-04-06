#!/usr/bin/env python3
"""
Meta Autoresearch Orchestrator (Agent 1 Output)

Runs multiple autoresearch experiments in parallel across different files or metrics.
This upgrades the Karpathy loop to a multi-agent swarm.
"""
import os
import sys
import json
import argparse
import subprocess
from concurrent.futures import ThreadProcessPoolExecutor, as_completed

def run_parallel_experiments(experiments):
    print(f"🚀 Spawning {len(experiments)} autoresearch agents in parallel...")
    results = []

    with ThreadProcessPoolExecutor(max_workers=len(experiments)) as executor:
        future_to_exp = {
            executor.submit(subprocess.run,
                ["python3", "run_experiment.py", "--config", exp["config"]],
                capture_output=True, text=True): exp for exp in experiments
        }

        for future in as_completed(future_to_exp):
            exp = future_to_exp[future]
            try:
                data = future.result()
                print(f"✅ Agent finished experiment: {exp['name']}")
                results.append({"name": exp['name'], "success": data.returncode == 0})
            except Exception as exc:
                print(f"❌ Agent failed for {exp['name']}: {exc}")

    return results

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--batch", type=str, required=True, help="JSON file containing array of experiment configs")
    args = parser.parse_args()

    with open(args.batch, "r") as f:
        experiments = json.load(f)

    run_parallel_experiments(experiments)
