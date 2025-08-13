#!/usr/bin/env bash
set -euo pipefail

# Accept task via argument; accept REPO override
REPO="${REPO:-$(pwd)}"
TASK="${*:-Fix all lint and format issues across the repo without changing public APIs or tests.}"
BRANCH="yolo/$(date +%Y%m%d-%H%M%S)"

# Build the image
echo "[yolo] Building Docker image..."
docker build -t claude-yolo:latest -f docker/Dockerfile.claude-yolo docker

# Prepare auth mounts and env vars
AUTH_MOUNTS=""
AUTH_ENVS=""

# Mount Claude auth files if they exist
if [[ -f "$HOME/.claude.json" ]]; then
  AUTH_MOUNTS="$AUTH_MOUNTS -v $HOME/.claude.json:/home/worker/.claude.json:rw"
fi

if [[ -d "$HOME/.claude" ]]; then
  AUTH_MOUNTS="$AUTH_MOUNTS -v $HOME/.claude:/home/worker/.claude:rw"
fi

# Forward ANTHROPIC_API_KEY if set (never hardcode keys!)
if [[ -n "${ANTHROPIC_API_KEY:-}" ]]; then
  AUTH_ENVS="$AUTH_ENVS -e ANTHROPIC_API_KEY"
fi

# Run Claude in a constrained container
echo "[yolo] Starting secure container for task: $TASK"
docker run --rm -i \
  --name "claude-yolo-$(date +%s)" \
  --pids-limit=512 --memory=4g \
  --cap-drop=ALL --security-opt=no-new-privileges:true \
  -v "$REPO":/workspace:rw \
  $AUTH_MOUNTS \
  $AUTH_ENVS \
  -e YOLO_TASK="$TASK" \
  -e YOLO_BRANCH="$BRANCH" \
  claude-yolo:latest \
  bash -lc '
    # NOTE: no "-u" here to avoid unbound variable errors  
    set -eo pipefail
    cd /workspace
    git config --global --add safe.directory /workspace || true
    git checkout -b "$YOLO_BRANCH" || git checkout -B "$YOLO_BRANCH"
    echo "[yolo] Running task on branch: $YOLO_BRANCH"
    printf "%s\n" "$YOLO_TASK" | claude --dangerously-skip-permissions
    echo "[yolo] Completed. Git status:"
    git status
  '

echo ""
echo "✅ YOLO task completed!"
echo "💾 To save: git add -A && git commit -m \"yolo: $TASK\""
echo "↩️  To undo: git switch main && git branch -D \"$BRANCH\""