# 🚀 Ultimate Claude Code Workspace

**153 Skills · 47 Agents · 80 Commands · 16 Rule Sets · 33 Hook Scripts · 14 MCP Servers**

This is an exact, one-shot replication of a highly optimized, production-ready Claude Code workspace. It instantly turns your fresh Claude Code installation into a powerhouse for software engineering, product management, system architecture, and deep automation.

**Works with:** Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Skills](https://img.shields.io/badge/Skills-153-brightgreen?style=for-the-badge)](#whats-inside)
[![Agents](https://img.shields.io/badge/Agents-47-blue?style=for-the-badge)](#whats-inside)
[![Commands](https://img.shields.io/badge/Commands-80-orange?style=for-the-badge)](#whats-inside)

---

## ⚡ Quick Install (One-Shot Replication)

```bash
# 1. Clone the repository
git clone https://github.com/alihusains/claude-skills.git
cd claude-skills

# 2. Run the one-shot installer
./install.sh
```

**What the installer does:**
1. Replicates the exact directory structure into `~/.claude/`
2. Syncs **153 skills**, **47 specialized agents**, **80 commands**, and **16 coding rule sets**.
3. Configures global Git/Tmux **Hooks** directly into `hooks.json` and syncs the required hook JS scripts.
4. Pre-configures **14 MCP Servers** (Jira, GitHub, Supabase, Memory, Exa, Context7, and more) into your `~/.claude.json`.
5. Injects `AGENTS.md` and `CLAUDE.md` to give Claude instant meta-awareness of its new capabilities.

*(Restart Claude Code or type `/clear` after running the installer.)*

---

## 🧠 What's Inside

### 1. Agents (47)
Highly specialized sub-agents you can spawn via `/agent <name>` or through the Task tool:
* `architect` - System design and scalability
* `code-reviewer` - Quality and maintainability
* `security-reviewer` - Vulnerability detection
* `build-error-resolver` - Fix build/type errors
* `tdd-guide` - Test-driven development
* `cpp-reviewer`, `python-reviewer`, `rust-reviewer`... and 40 more!

### 2. Skills (153)
Actionable context blocks Claude automatically loads when specific keywords are detected:
* **Architecture:** `android-clean-architecture`, `backend-patterns`, `api-design`
* **DevOps:** `docker-patterns`, `deployment-patterns`, `ci-cd-pipeline-builder`
* **Security:** `defi-amm-security`, `django-security`, `laravel-security`
* **Marketing/Product:** `brand-voice`, `content-engine`, `lead-intelligence`

### 3. Commands (80)
Custom slash commands (`/code-review`, `/e2e`, `/plan`, `/hookify-list`) providing instant workflow shortcuts without writing complex prompts.

### 4. Global Hooks (33 scripts)
Automations that run during `PreToolUse` or post-actions:
* **Quality Gates:** Prevents committing with `console.log` or bypassed tests (`block-no-verify`).
* **Dev Ex:** Auto-starts dev servers in `tmux`.
* **Reminders:** Prompts for Git reviews and workspace compaction.

### 5. Rules (16 sets)
Language-specific best practices covering `cpp`, `csharp`, `golang`, `java`, `python`, `rust`, `typescript`, and web frameworks. 

### 6. MCP Servers (14)
Pre-configured for:
* Atlassian/Jira
* GitHub
* Supabase
* Firecrawl
* Model Context Protocol Memory
* Vercel & Railway
* Context7 Documentation Lookup

---

## 📖 Documentation & Website

Browse the full directory of skills and tools on our static site:
👉 **[alihusains.github.io/claude-skills](https://alihusains.github.io/claude-skills/)**

---

## 🛠️ Multi-Tool Integrations

While optimized for **Claude Code**, these markdown-based instructions can be easily adapted to other agents (Cursor, Windsurf, Aider) by copying the `claude-workspace/skills/` directory into their respective rules folders (like `.cursor/rules/`).

---

## License
MIT — see [LICENSE](LICENSE) for details.
