# Contributing to Obenan Safe YOLO Runner

Thank you for your interest in contributing! This guide will help you get started.

## 🚀 Quick Start

1. **Fork** this repository
2. **Clone** your fork locally
3. **Create** a feature branch: `git checkout -b feature/amazing-improvement`
4. **Make** your changes
5. **Test** your changes (see Testing section below)
6. **Commit** using conventional commits (see Commit Style below)
7. **Push** to your fork and **submit a pull request**

## 📋 Development Setup

### Prerequisites
- Docker Desktop (for testing the sandbox)
- Git
- Node.js 18+ (for any scripting needs)

### Local Development
```bash
git clone https://github.com/your-username/obennan-safe-yolo-runner
cd obennan-safe-yolo-runner
./scripts/yolo-docker.sh "echo 'Testing sandbox setup'"
```

## 🧪 Testing

Before submitting changes:

1. **Test the Docker build**:
   ```bash
   docker build -t claude-yolo:test -f docker/Dockerfile.claude-yolo docker
   ```

2. **Test the YOLO script**:
   ```bash
   # Test with a simple, safe task
   ./scripts/yolo-docker.sh "git status && echo 'Sandbox working!'"
   ```

3. **Verify security settings**:
   - Check that no secrets are hardcoded
   - Ensure `.gitignore` excludes auth files
   - Confirm Docker security flags are present

## 📝 Commit Style

We use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` - New features
- `fix:` - Bug fixes  
- `docs:` - Documentation changes
- `chore:` - Maintenance tasks
- `security:` - Security improvements
- `refactor:` - Code refactoring

Examples:
```
feat: add support for custom Docker image tags
fix: resolve auth file mounting on Windows
docs: update README with new installation steps
security: remove hardcoded API keys from scripts
```

## 🔒 Security Guidelines

**Critical**: This project deals with security sandboxing. Please:

- **Never** commit API keys, tokens, or credentials
- **Always** test changes in the Docker sandbox first
- **Review** security implications of any script changes
- **Follow** the principle of least privilege
- **Report** security issues privately (see SECURITY.md)

## 📂 Project Structure

```
├── docker/
│   └── Dockerfile.claude-yolo    # Container definition
├── scripts/
│   └── yolo-docker.sh           # Main YOLO runner script
├── brand/                       # Logo and brand assets
├── SECURITY.md                  # Security policy
├── CODE_OF_CONDUCT.md          # Community guidelines
└── README.md                   # Project documentation
```

## 🎯 Types of Contributions Welcome

- **Security improvements** to the Docker sandbox
- **Cross-platform compatibility** fixes
- **Documentation** improvements and translations
- **Testing** enhancements
- **Performance** optimizations
- **Bug fixes** and error handling
- **Feature requests** (open an issue first to discuss)

## ❓ Questions?

- **General questions**: Open a discussion
- **Bug reports**: Open an issue with reproduction steps
- **Security concerns**: See SECURITY.md for private reporting
- **Feature ideas**: Open an issue to discuss before implementing

## 📜 License Agreement

By contributing, you agree that your contributions will be licensed under the same license as this project (Apache-2.0). You retain copyright to your contributions.

## 🙏 Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes for significant contributions
- Special thanks in documentation

Thank you for helping make YOLO safer for everyone! 🎉