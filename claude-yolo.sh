#!/usr/bin/env bash
set -euo pipefail
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Run this inside a git repo."
  exit 1
fi

TASK="${*:-Fix all lint and formatting issues across the repo without changing public APIs.}"
BRANCH="yolo/$(date +%Y%m%d-%H%M%S)"

echo "[yolo] Creating branch: $BRANCH"
git checkout -b "$BRANCH"

echo "[yolo] Starting Claude in YOLO mode (offline container)."
echo ">>> When Claude opens, paste your task if you didn't pass one to this script."
claude --dangerously-skip-permissions

echo "[yolo] Finished. Showing status:"
git status
echo "[yolo] Review changes, then 'git add -A && git commit -m \"yolo: $TASK\"'"