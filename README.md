<div align="center">
  <img src="brand/logo.svg" alt="Obenan Logo" width="300">
  
  # Obenan Safe YOLO Runner
  
  [![License](https://img.shields.io/badge/License-Apache%202.0-00BDEA.svg)](https://opensource.org/licenses/Apache-2.0)
  [![YOLO-Safe](https://img.shields.io/badge/YOLO-Safe%20🔒-598AFF.svg)](#security-model)
  [![Docker](https://img.shields.io/badge/Docker-Required-00BDEA.svg)](#requirements)
  [![Shell](https://img.shields.io/badge/Shell-Bash-598AFF.svg)](#quick-start)
  
  **Safe YOLO for Claude, in a locked-down Docker sandbox.**
</div>

---

## 🎯 What This Is

A **one-command YOLO button** for Claude Code that runs `claude --dangerously-skip-permissions` inside a **hardened Docker container** so your system stays safe.

- **No prompts** - Claude makes changes without asking
- **Full isolation** - Every run happens in a secure sandbox  
- **Branch safety** - Each run creates a disposable Git branch
- **Easy rollback** - Delete the YOLO branch to undo everything instantly

## 🔒 Security Model

### ✅ What Keeps You Safe
- **Non-root container** - Runs as user ID 1000, never root
- **Capabilities dropped** - `--cap-drop=ALL` removes all Linux capabilities
- **No new privileges** - `--security-opt=no-new-privileges:true`
- **Resource limits** - Memory (4GB) and PID (512) limits prevent resource exhaustion
- **Branch isolation** - Each run creates a disposable Git branch
- **Secret protection** - Authentication files never committed to Git

### ⚠️ What YOLO Mode Means
- **No permission prompts** - Claude will make changes without asking
- **Full workspace access** - Claude can modify any file in the mounted directory  
- **Command execution** - Claude can run shell commands within the container

## 🧰 Requirements

- **Docker Desktop** (running)
- **Anthropic account** (Claude Code CLI auth)
- **Git** (for branch management)

## 🚀 Quick Start

```bash
cd "${PWD}"
./scripts/yolo-docker.sh "Create a README and basic project scaffolding."
```

## 🔑 One-Time Login (Choose One)

### Option A: Docker Desktop GUI (Recommended)
1. Open **Docker Desktop** → **Images** → `claude-yolo:latest` → **Run**
2. Set command: `claude login`
3. Add **two bind mounts**:
   - `~/.claude.json` → `/home/worker/.claude.json` (Read/Write)
   - `~/.claude` → `/home/worker/.claude` (Read/Write)
4. **Run** container, follow browser link to sign in, return and press **Enter**

### Option B: API Key Environment Variable
```bash
export ANTHROPIC_API_KEY="your-api-key-here"
./scripts/yolo-docker.sh "Your task"
```
**⚠️ Never commit API keys to Git!**

## 🎯 Running Tasks

```bash
# Run a task
./scripts/yolo-docker.sh "Fix lint issues and update documentation"

# Save results
git add -A && git commit -m "yolo: fix lint and docs"

# Undo a run  
git switch main && git branch -D "yolo/YYYYMMDD-HHMMSS"
```

## 🗂️ Run on Another Project

```bash
REPO="/path/to/another/project" ./scripts/yolo-docker.sh "Your task"
```

## 👥 Onboard a Teammate

1. **Clone**: `git clone <repo-url> && cd <repo-name>`
2. **Login once**: Use Docker Desktop method above or set `ANTHROPIC_API_KEY`  
3. **Start YOLOing**: `./scripts/yolo-docker.sh "Fix formatting and lint issues"`

## 🆘 Troubleshooting

- **"Invalid API key · Please run /login"**: Redo the Docker Desktop login with both bind mounts
- **"Cannot delete branch used by worktree"**: `git switch main` first, then delete the branch
- **Container won't start**: Ensure Docker Desktop is running and you have enough resources

## 🏢 About Obenan

Obenan builds tools to reduce digital entropy and streamline development workflows. We believe in making powerful AI assistants both accessible and safe.

## 📄 License

Licensed under the [Apache License 2.0](LICENSE).

**Note**: The Obenan logo and brand assets in the `brand/` directory are not licensed for third-party use without explicit permission from Obenan.

---

<div align="center">
  <sub>Built with ❤️ by <a href="https://obenan.com">Obenan</a> • <a href="SECURITY.md">Security Policy</a> • <a href="CONTRIBUTING.md">Contributing</a></sub>
</div>