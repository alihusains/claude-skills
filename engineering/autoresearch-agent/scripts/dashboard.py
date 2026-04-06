#!/usr/bin/env python3
"""
Terminal Dashboard (Agent 4 Output)

Visualizes the parallel autoresearch swarm using standard libraries.
"""
import json
import argparse
import time

def render_dashboard(log_file):
    print("="*50)
    print(" 🛸 AUTORESEARCH SWARM DASHBOARD 🛸 ")
    print("="*50)

    try:
        with open(log_file, "r") as f:
            lines = f.readlines()
            for line in lines[-10:]: # Show last 10 attempts
                data = json.loads(line.strip())
                icon = "✅" if data.get("success") else "❌"
                print(f"{icon} Iteration {data.get('iteration', '?')}: {data.get('metric_score', 'N/A')} - {data.get('message', '')}")
    except FileNotFoundError:
        print("No log file found. Swarm has not started.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--log", default="autoresearch.log")
    args = parser.parse_args()
    render_dashboard(args.log)
