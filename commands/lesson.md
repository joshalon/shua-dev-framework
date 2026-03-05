# /lesson — Capture a Lesson Learned

When this command is invoked, capture a lesson learned from the current session.

## Format:

Append the following to the appropriate lessons file:

- If the lesson is universal (applies to any project): append to `~/.claude/lessons.md`
- If the lesson is project-specific: append to the current project's `tasks/lessons.md` (create if it doesn't exist)

## Entry Format:

```
### [DATE] | [PROJECT or "global"] | [CATEGORY]
**What happened:** [Brief description of the mistake or discovery]
**Root cause:** [Why it happened]
**Rule:** [The specific, actionable rule that prevents this in the future]
**Verified:** [How we know the rule works, or "pending verification"]
```

## Categories:
- `architecture` — structural decisions, component boundaries
- `testing` — test failures, coverage gaps, false passes
- `context` — context management, trimming, memory issues
- `delegation` — sub-agent scoping, audit failures
- `tooling` — MCP servers, CLI tools, config issues
- `process` — workflow, sequencing, gate violations

Always ask Shua which file the lesson belongs in if ambiguous.
