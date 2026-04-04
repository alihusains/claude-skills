# Detailed Guide: Claude Ultimate Config

Welcome to the ultimate Claude Code power-user setup! This repository isn't just a collection of skills; it's a **complete mirroring** of a professional engineering environment for Claude.

## 🛠 What's Under the Hood?

When you install this configuration, you get five major components that work together to make Claude significantly more capable:

### 1. 🏆 Master Pro Skills (`/skills`)
We've consolidated over 1,000 fragmented skills into **20 definitive guides**. Instead of having 50 different "Python" skills, you have one `python-ecosystem-master-pro` that covers everything from FastAPI to Data Science with professional checklists.

### 2. 🤖 Specialized Custom Agents (`/agents`)
This setup includes over **100 custom agent definitions**. These are specialized "personalities" or "roles" you can summon using the `/name` command.
- **Architect**: For system design.
- **Code Reviewer**: For rigorous PR audits.
- **Security Auditor**: For finding vulnerabilities.
- **TDD Guide**: To ensure you write tests before code.

### 3. 📜 Global Layered Rules (`/rules`)
The rules system enforces high-quality standards across every conversation.
- **Language Rules**: Automatic standards for Rust, Go, Swift, Kotlin, Python, etc.
- **Workflow Rules**: Mandatory TDD, Git commit formats, and security protocols.
- **Performance Rules**: Instructions for Claude to use the best model for the task.

### 4. 🔗 Intelligent Hooks (`/hooks`)
Hooks are "invisible" scripts that run automatically at specific times:
- **PreToolUse**: Validates your commands before they execute.
- **SessionStart**: Sets up your environment, summarizes previous context, and loads project memory.
- **Status Line**: A custom bar at the bottom of your terminal that gives you real-time feedback on Claude's state.

### 5. ⚙️ Optimized Settings (`/config`)
We've tuned `settings.json` and `keybindings.json` for:
- Maximum reasoning depth.
- Faster tool execution.
- Rapid keyboard shortcuts for common tasks.

### 6. 🛠 MCP Server Configs (`/mcp-configs`)
The setup includes a library of over **20 pre-configured MCP servers**.
- **GitHub & Vercel**: For seamless CI/CD and repo management.
- **Firecrawl & Exa**: For deep web research and scraping.
- **Supabase & ClickHouse**: For advanced database operations.
- *Note: All servers are installed with placeholder keys for your security.*

## 🚀 Installation (One-Shot)

Run this in your terminal to get everything:

```bash
curl -sSL https://raw.githubusercontent.com/alihusains/claude-skills/main/install.sh | bash
```

## 📂 Folder Structure
- `skills/`: The 20 Master Pro guides.
- `agents/`: 100+ Markdown files defining custom agents.
- `rules/`: Global and language-specific engineering standards.
- `hooks/`: Automation scripts and hook definitions.
- `config/`: The core `settings.json` and `keybindings.json`.

---
*Created with ❤️ for the Claude Power-User Community.*
