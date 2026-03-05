# Shua Dev Framework

A personal Claude Code global configuration framework for orchestrator-first
agentic development workflows.

## What This Is

A complete `~/.claude/` configuration that makes every Claude Code session
on your machine default to structured, multi-agent orchestration with
independent audit verification. Built through empirical iteration on
real multi-agent development projects.

## What's Included

- **Global CLAUDE.md** — Orchestrator-first behavior, delegation rules,
  model defaults, session discipline, security standards
- **4 slash commands** — `/orchestrate`, `/lesson`, `/checkpoint`, `/status`
- **3 skills** — Orchestrator framework, spec-driven development, MCP server setup
- **4 rule files** — Anti-patterns, model selection, verification gates,
  orchestrator defaults
- **Orchestrator Prompt Framework** — Complete reusable template for
  structuring multi-agent dev sessions
- **Lessons system** — Cross-project learning capture with structured format

## Installation

```bash
git clone https://github.com/yourusername/shua-dev-framework.git
cd shua-dev-framework
chmod +x install.sh
./install.sh
```

## How It Works

Claude Code loads `~/.claude/CLAUDE.md` automatically at every session start.
The global config establishes HOW you work (orchestrate, delegate, verify).
Each project's own `CLAUDE.md` establishes WHAT you're working on.

### Configuration Hierarchy

```
~/.claude/CLAUDE.md          ← Global: workflow defaults (this repo)
  └── project/CLAUDE.md      ← Project: architecture, phases, boundaries
       └── session context    ← Ephemeral: dies when session ends
```

## Core Principles

- **Orchestrator-first** — Plan, delegate, verify. Don't write code directly
  for non-trivial tasks.
- **Independent audit** — Every sub-agent's work is verified by a separate
  audit agent that reads source directly.
- **Sequential gates** — No task N+1 until task N's audit passes.
- **Lessons compound** — Mistakes are captured, categorized, and consulted
  at future session starts.

## Customization

1. Copy `global-claude-md.template` to `~/.claude/CLAUDE.md`
2. Replace `[YOUR_NAME]`, `[YOUR_LOCATION]`, `[YOUR_MACHINE]` with your details
3. Adjust model preferences in `rules/model-selection.md` if needed
4. Add your own lessons to `~/.claude/lessons.md` as you work

## File Reference

| File | Purpose |
|------|---------|
| `global-claude-md.template` | Main config — edit and install as `~/.claude/CLAUDE.md` |
| `commands/orchestrate.md` | Starts structured orchestrator mode |
| `commands/lesson.md` | Captures lessons to the right file |
| `commands/checkpoint.md` | Saves session state for clean handoffs |
| `commands/status.md` | Quick session status report |
| `skills/orchestrator-framework/SKILL.md` | Full orchestrator prompt framework |
| `skills/spec-writing/SKILL.md` | Spec-driven development guide |
| `skills/mcp-server-setup/SKILL.md` | MCP server build/config guide |
| `rules/orchestrator-defaults.md` | When and how to orchestrate |
| `rules/anti-patterns.md` | Failure modes to avoid |
| `rules/model-selection.md` | Opus vs Sonnet decision guide |
| `rules/verification-gates.md` | Audit gate criteria |
| `ORCHESTRATOR_PROMPT_FRAMEWORK.md` | Standalone framework document |

## License

MIT

---

Built by Shua (Joshua Alon) · March 2026
Developed through empirical iteration on multi-agent trading system builds.
