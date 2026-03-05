# Shua Dev Framework — System Architecture

**A complete reference for the three-tier agentic development system**
**Author: Shua (Joshua Alon) · Version 1.0 · March 2026**

---

## The Three-Tier Command Structure

This framework implements a three-tier hierarchy for agentic software development. Each tier has a distinct role, and work flows downward through the tiers with increasing specificity.

### Tier 1 — Architect (Claude.ai / Desktop / Mobile)

**Role:** Strategic thinking, architecture design, prompt engineering, task definition.

The architect tier is where high-level decisions happen. This is a conversation with an AI advisor (CTO agent, architect agent, or general strategic discussion) that produces:

- Architecture decisions and design documents
- Task definitions and prompts for the orchestrator tier
- Framework refinements and methodology updates
- Cross-project strategic planning
- Model and effort level recommendations for specific tasks

The architect does not write code. The architect does not execute. The architect thinks, designs, and formulates precise instructions that flow down to the orchestrator.

**Platform:** Claude.ai web app, Claude desktop app, Claude mobile app — wherever strategic thinking happens. These conversations are often long, exploratory, and reference multiple projects simultaneously.

**Key outputs:** Orchestrator prompts, architecture documents, task specifications, framework updates.

### Tier 2 — Orchestrator (Claude Code · Terminal)

**Role:** Receive tasks from the architect tier, plan execution, delegate to sub-agents, verify through independent audit agents, report results.

The orchestrator is the project manager. It receives a well-defined task (often formulated in Tier 1), breaks it into scoped sub-tasks, assigns each to a working sub-agent, and gates every result through an independent audit agent. The orchestrator does not write code directly for non-trivial work.

**Platform:** Claude Code CLI running in the terminal, typically inside a specific project directory. The orchestrator loads both the global `~/.claude/` configuration and the project-level `.claude/` configuration.

**Default model:** claude-opus-4-6 · effort: high (for multi-agent coordination).

**Key behaviors:**
- Plans before executing (plan mode for any 3+ step task)
- Delegates all code/config/test work to named sub-agents
- Gates every sub-agent's work through an independent audit agent
- Reports results with full transparency (working agent claims vs audit agent findings)
- Never proceeds to task N+1 until task N's audit passes

### Tier 3 — Sub-Agents (Claude Code · Spawned Sessions)

**Role:** Execute specific, well-scoped tasks as delegated by the orchestrator.

Sub-agents are the hands. Each one has a single, clear responsibility with explicit constraints on what it may and may not touch. Sub-agents come in two types:

**Working agents** (claude-sonnet-4-6 · effort: medium): Execute the actual work — write code, modify config, run tests, build features. They report back what they did and what the test results were.

**Audit agents** (claude-sonnet-4-6 · effort: high): Independently verify the working agent's claims. They read the codebase directly (never the working agent's report), run tests independently, and issue a PASS or FAIL verdict. They are the quality gate.

Working agents and audit agents are always separate sessions. They share no context. This is non-negotiable.

---

## Information Flow

```
TIER 1 — ARCHITECT (Claude.ai)
│
│  "Refactor session_manager.py to support max_turns config.
│   Use Sonnet-high for the working agent because the refactor
│   touches multiple methods. Here's the full prompt..."
│
▼
TIER 2 — ORCHESTRATOR (Claude Code · opus-4-6 · high)
│
│  Reads global ~/.claude/CLAUDE.md (workflow defaults)
│  Reads project CLAUDE.md (architecture, current phase)
│  Reads ~/.claude/lessons.md (cross-project lessons)
│  Drafts task breakdown, presents plan, gets approval
│
├──▶ TASK 1: Working Agent (sonnet-4-6 · medium)
│       └── Modifies session_manager.py, runs tests
│
├──▶ TASK 1: Audit Agent (sonnet-4-6 · high)
│       └── Reads source directly, runs tests independently
│       └── Verdict: PASS ✓
│
├──▶ TASK 2: Working Agent (sonnet-4-6 · medium)
│       └── Updates 6 agent configs
│
├──▶ TASK 2: Audit Agent (sonnet-4-6 · high)
│       └── Verifies all 6 configs, runs tests
│       └── Verdict: PASS ✓
│
▼
REPORT back to human (Shua)
│
▼
LESSONS captured → ~/.claude/lessons.md or project lessons
```

---

## Configuration Architecture

### Layer 1: Global (~/.claude/)

Loaded automatically by every Claude Code session on the machine. Contains workflow methodology — HOW you work, regardless of project.

```
~/.claude/
├── CLAUDE.md                              # Master config: orchestrator-first defaults
├── settings.json                          # Permissions, model prefs, plugins
├── commands/
│   ├── orchestrate.md                     # /orchestrate — full orchestrator mode
│   ├── lesson.md                          # /lesson — capture lessons learned
│   ├── checkpoint.md                      # /checkpoint — save session state
│   └── status.md                          # /status — quick session report
├── skills/
│   ├── orchestrator-framework/SKILL.md    # Full multi-agent framework
│   ├── spec-writing/SKILL.md              # Spec-driven development guide
│   └── mcp-server-setup/SKILL.md          # MCP server build/config guide
├── rules/
│   ├── orchestrator-defaults.md           # When/how to orchestrate
│   ├── anti-patterns.md                   # Failure modes to avoid
│   ├── model-selection.md                 # Opus vs Sonnet decision guide
│   └── verification-gates.md             # Audit gate criteria
└── lessons.md                             # Cross-project lessons (append-only)
```

**What goes here:** Delegation rules, model defaults, anti-patterns, verification gate criteria, slash commands, skills, and cross-project lessons.

**What does NOT go here:** Project-specific architecture, phase gates, project boundaries, API configurations, or anything that only applies to one codebase.

### Layer 2: Project (each repo's root)

Loaded when Claude Code runs inside a specific project directory. Extends the global layer with project-specific context — WHAT you're working on.

```
project-root/
├── CLAUDE.md                              # Project architecture, phases, boundaries
├── .claude/
│   ├── settings.json                      # Project-specific permissions
│   ├── skills/                            # Project-specific skills
│   └── commands/                          # Project-specific commands
├── .mcp.json                              # Project-specific MCP servers
└── tasks/
    ├── todo.md                            # Current task list
    ├── lessons.md                         # Project-specific lessons
    └── checkpoint-*.md                    # Session checkpoints
```

**What goes here:** Architecture overview, tech stack, current phase/status, three-tier boundaries (Always/Ask First/Never), project-specific MCP server configurations, project-specific skills, and project-specific lessons.

### Layer 3: Session (ephemeral)

The conversation context during a single Claude Code run. Dies when the session ends. Anything worth keeping must be promoted to Layer 1 or Layer 2 before the session closes.

**Promotion mechanisms:**
- `/lesson` — promotes a discovery to the appropriate lessons file
- `/checkpoint` — saves session state to a project checkpoint file
- Manual file writes — agent writes decisions or findings to project docs

---

## The Orchestrator Prompt Framework

The framework provides a complete reusable template for structuring multi-agent orchestrator sessions. It lives at `~/.claude/skills/orchestrator-framework/SKILL.md` and is also available as a standalone document: `ORCHESTRATOR_PROMPT_FRAMEWORK.md`.

### Core Components

**Delegation Rules (Non-Negotiable):**
1. Every code/config/test task gets a named sub-agent with explicit scope and constraints
2. Every sub-agent is followed by an independent audit agent (separate session)
3. Audit agents read source directly — never the working agent's report
4. Test results require independent audit confirmation
5. Reports include both working + audit findings; discrepancies flagged explicitly
6. Sequential execution: no task N+1 until task N audit passes

**Model Configuration Defaults:**

| Role | Model | Effort | Rationale |
|------|-------|--------|-----------|
| Orchestrator | claude-opus-4-6 | high | Drift is expensive; first-attempt correctness matters |
| Working sub-agent | claude-sonnet-4-6 | medium | Well-scoped tasks; quality/speed balance |
| Audit agent | claude-sonnet-4-6 | high | Quality gate; thoroughness over speed |

**Escalation Rule:** If a working sub-agent fails twice, the third attempt escalates to claude-opus-4-6 · effort: high.

**Three-Tier Boundary System:**

| Tier | Purpose | Examples |
|------|---------|---------|
| Always | Actions taken without asking | Run tests before commits, follow naming conventions |
| Ask First | High-impact changes needing approval | DB schema changes, new dependencies, CI/CD config |
| Never | Hard stops, categorically off-limits | Commit secrets, edit vendor dirs, remove failing tests |

### Anti-Patterns

| Anti-Pattern | Correct Approach |
|---|---|
| Working agent audits its own work | Separate audit session |
| Audit reads working agent's report | Audit reads source directly |
| Parallel tasks before dependencies verified | Sequential with audit gates |
| Vague scope | Every item specific and verifiable |
| No "do not touch" list | Always include hard constraints |
| Partial completion accepted | Every scope item in audit checklist |

---

## Slash Commands

### /orchestrate
Enters full orchestrator mode. The agent asks for the task, reads project context and lessons, drafts a complete task breakdown with working agent scopes, audit agent scopes, and constraints. Presents the plan for approval before executing. Tasks run sequentially with audit gates.

### /lesson
Captures a lesson learned. Formats it with date, project, category, what happened, root cause, rule, and verification status. Routes it to the correct file (global `~/.claude/lessons.md` for universal lessons, project `tasks/lessons.md` for project-specific ones).

**Categories:** architecture, testing, context, delegation, tooling, process.

### /checkpoint
Saves session state before closing. Creates a timestamped checkpoint file in `tasks/` with completed work, in-progress items, decisions made, blockers, and next-session instructions. Promotes any universal lessons to the global file.

### /status
Quick 10-line session status report: current project, completed tasks, current task, pending audits, blockers, context usage estimate.

---

## The Compound Learning System

The framework is designed to compound over time. Every session has the potential to make all future sessions smarter.

### How Lessons Flow

```
Session discovers mistake or pattern
        │
        ▼
  /lesson command invoked
        │
        ├── Universal lesson? → ~/.claude/lessons.md
        │                        (every future session reads this)
        │
        └── Project-specific? → project/tasks/lessons.md
                                 (project sessions read this)
```

### Lesson Entry Format

```markdown
### [YYYY-MM-DD] | [project or "global"] | [category]
**What happened:** Brief description of the mistake or discovery
**Root cause:** Why it happened
**Rule:** Specific, actionable prevention rule
**Verified:** How we confirmed this works, or "pending"
```

### Session Start Behavior

Every session reads `~/.claude/lessons.md` at startup. This is specified in the global CLAUDE.md. The agent scans for lessons relevant to the current task before beginning work. This is active retrieval, not passive availability — a distinction that emerged from empirical research showing that information present in context but not actively consulted is functionally useless (pattern recognition scored 37.5 with passive availability vs 84.4 with mandatory active scan).

---

## Cross-Project Architecture Awareness

### The Claude.ai Project Layer

For developers managing multiple repositories and complex systems, a Claude.ai project serves as the strategic layer above all Claude Code sessions. This project contains:

1. **This architecture document** — so every architectural conversation starts with full system awareness
2. **Project-specific architecture docs** — uploaded as project knowledge (e.g., Shua Capital neural architecture, roadmap)
3. **The orchestrator prompt framework** — so the architect agent can formulate precise orchestrator prompts
4. **Current status across all active projects** — updated periodically

The Claude.ai project is where you go to think, design, and plan. Claude Code is where you go to execute. The separation is intentional — strategic thinking benefits from a different mode than tactical execution.

### Workflow Example: Architect → Orchestrator → Execution

**Step 1 (Claude.ai):** "I need to refactor the session manager to support configurable max_turns. The current implementation hardcodes 3. What's the right approach, and give me the orchestrator prompt."

**Step 2 (Claude.ai produces):** A complete orchestrator prompt with system state, task breakdown, working agent scopes, audit agent scopes, constraints, and final report format. It also recommends model/effort levels for each agent.

**Step 3 (Terminal):** Shua opens Claude Code in the project directory, pastes the orchestrator prompt (or a condensed version of it), and the orchestrator executes the plan with sub-agents and audit gates.

**Step 4 (Terminal → Claude.ai):** Results flow back. If architectural questions arose during execution, Shua brings them to the architect tier for strategic resolution before the next orchestrator run.

---

## Empirical Research Foundations

These findings emerged from real testing on multi-agent persistent session systems and are encoded in the global lessons file.

**Coherence Cliff:** Memory recall drops to zero at 34-39% context usage. Trim thresholds should be set conservatively (25% for persistent sessions).

**Trim Improves Consistency:** Trimming context actually improves decision consistency (+10.4) and reasoning quality (+0.8) by removing noise. But it destroys episodic specifics (-56 pts lesson application) unless pre-trim synthesis runs first.

**Episodic Over Abstract:** Compressed episodic demonstrations (condition + resolution + outcome) have an 87% hit rate. Abstract principles ("avoid high RSI") have only 50%. Always use concrete examples when encoding learned behavior.

**Active Retrieval Required:** Information passively available in context is functionally useless unless the reasoning loop includes a mandatory scan step. Pattern recognition jumped from 37.5 to 84.4 when Step 0 (mandatory pre-decision scan) was added.

---

## Quick Reference

### Starting a New Session
1. `cd` into project directory
2. Run `claude`
3. Global config loads automatically
4. Project config loads automatically
5. Agent reads lessons at startup
6. Describe your task or use `/orchestrate` for structured mode

### Ending a Session
1. `/checkpoint` to save state (if work is in progress)
2. `/lesson` to capture any discoveries
3. Close session

### Adding a New Project to the Framework
1. Create `CLAUDE.md` in the project root with architecture, phases, boundaries
2. Optionally create `.claude/skills/` with project-specific skills
3. Optionally create `.mcp.json` with project-specific MCP servers
4. Create `tasks/` directory for todo, lessons, and checkpoints
5. The global framework handles everything else automatically

### Formulating Orchestrator Prompts (from Claude.ai)
1. Describe the task and context to your architect agent
2. Specify current system state (what exists, last test count, recent changes)
3. Define "do not touch" constraints
4. Let the architect draft the task breakdown with model/effort recommendations
5. Review the prompt, then paste into Claude Code terminal

---

*This framework was developed through empirical iteration on multi-agent trading system builds and refined through architectural discussions spanning agentic AI workflows, spec-driven development, and MCP server design. March 2026.*
