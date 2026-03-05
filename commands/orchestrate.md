# /orchestrate — Start Orchestrator Mode

When this command is invoked, structure the current session as an orchestrated multi-agent workflow.

## Steps:

1. Ask Shua to describe the task or set of tasks.
2. Read the current project's CLAUDE.md for project-specific context.
3. Read `~/.claude/lessons.md` for any relevant cross-project lessons.
4. Enter plan mode. Draft a task breakdown with:
   - Numbered tasks in sequential order
   - For each task: working agent scope, constraints, and audit agent verification criteria
   - "Do not touch" list for the entire session
   - System state summary (what exists now, last verified test count if applicable)
5. Present the plan to Shua for approval before any execution.
6. Execute tasks sequentially. Do not begin task N+1 until task N's audit agent issues a PASS.
7. After all tasks complete, deliver a final report in this format:

```
FINAL REPORT:
- Task [N]: [PASS / FAIL / DISCREPANCY]
  - Working agent: [summary]
  - Audit agent: [summary]
  - Agreement: [yes/no]
- Test suite result: [X/X passing]
- Escalations: [yes/no]
- System state: [brief]
- Ready for next phase: [yes/no]
```

Refer to `~/.claude/skills/orchestrator-framework/SKILL.md` for the full framework if needed.
