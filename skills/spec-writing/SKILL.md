# Spec-Driven Development — Skill Reference

This skill provides guidance on writing effective specs for AI agent development.

## Core Principle

Plan first, then execute. Iterate on the plan, not the code. Save the spec as SPEC.md and treat it as the single source of truth.

## Spec Structure

Every spec should include:

1. **Objective** — What are we building and why? Who is the user? What does success look like?
2. **Tech Stack** — Specific versions. "React 18 with TypeScript" not "React project."
3. **Commands** — Full executable commands with flags, not just tool names.
4. **Project Structure** — Where source code lives, where tests go, where docs belong.
5. **Boundaries** — Three-tier system:
   - Always: Actions taken without asking (run tests, follow conventions)
   - Ask First: High-impact changes needing human approval (DB schema, new deps)
   - Never: Hard stops (commit secrets, edit vendor dirs, remove failing tests)
6. **Success Criteria** — Specific, testable conditions that define "done."

## The Curse of Instructions

As you pile on more instructions, model adherence to each one drops. Even frontier models struggle with 10+ simultaneous requirements.

Solution: Break specs into modular, sequential prompts. One subproblem at a time. Feed only the relevant spec section for each task.

## Spec Maintenance

- Commit SPEC.md to version control
- Update it when decisions change — it's a living document
- Use plan mode to refine specs before execution
- If the agent misunderstood something, update the spec and resync

## Single vs Multi-Agent Specs

- Single agent: Use for small-to-medium projects, isolated modules, early prototyping
- Multi-agent: Use for large codebases, parallel code+test+review, independent features
- When multi-agent: limit to 2-3 agents initially, define clear boundaries between them

## Anti-Patterns

- Vague prompts with no anchor ("build me something cool")
- Overlong context without summarization
- Skipping human review of critical paths
- Confusing rapid prototyping with production engineering
- Missing the six core areas (commands, testing, structure, style, git workflow, boundaries)
