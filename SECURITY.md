# Security Policy

## Overview

This project provides a secure sandbox for running Claude Code in "YOLO mode" (`--dangerously-skip-permissions`). Security is our top priority.

## Security Model

### ✅ What's Safe
- **Docker Isolation**: All YOLO operations run in a locked-down container
- **No Root Access**: Container runs as non-root user (UID 1000)
- **Capabilities Dropped**: `--cap-drop=ALL` removes all Linux capabilities
- **No New Privileges**: `--security-opt=no-new-privileges:true`
- **Resource Limits**: Memory (4GB) and PID (512) limits prevent resource exhaustion
- **Branch Isolation**: Each run creates a disposable Git branch
- **Secret Protection**: Authentication files never committed to Git

### 🚨 What YOLO Mode Means
- **No Permission Prompts**: Claude will make changes without asking
- **Full Workspace Access**: Claude can modify any file in the mounted directory
- **Command Execution**: Claude can run shell commands within the container

### 🔐 Authentication Security
**Never commit secrets to Git!**
- `.claude/` and `.claude.json` are git-ignored
- Use environment variable `ANTHROPIC_API_KEY` for CI/CD
- Or mount auth files as read-write volumes for local use

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| latest  | :white_check_mark: |

## Reporting a Vulnerability

**Please do NOT open public issues for security vulnerabilities.**

Instead:
1. Open a private security advisory on GitHub
2. Or email security concerns to the repository maintainers
3. Include steps to reproduce if applicable

We'll respond within 48 hours and provide a timeline for fixes.

## Best Practices

1. **Always run YOLO in the provided Docker container** - never bypass the sandbox
2. **Review changes** before committing YOLO results to important branches
3. **Use branch isolation** - let YOLO work on disposable branches
4. **Keep secrets out of the repo** - never commit API keys or auth tokens
5. **Stay updated** - pull the latest container image regularly
6. **Limit scope** - only mount the specific project directory you're working on

## Docker Security Features

Our container uses these security measures:
```bash
docker run \
  --pids-limit=512 \
  --memory=4g \
  --cap-drop=ALL \
  --security-opt=no-new-privileges:true \
  --user=worker \
  # ... other flags
```

These settings prevent:
- Fork bombs (PID limit)
- Memory exhaustion (RAM limit) 
- Privilege escalation (dropped capabilities)
- Container escapes (no-new-privileges)