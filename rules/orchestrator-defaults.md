# Rule: Orchestrator-First Behavior

For any non-trivial task (3+ steps, multiple files, or architectural decisions):

1. Enter plan mode before doing anything
2. Draft a task breakdown with sequential steps
3. Each step gets a working sub-agent and an audit sub-agent
4. Present the plan before executing
5. Execute sequentially with audit gates between tasks
6. Deliver a structured final report

A task is trivial if it is: a single-file edit, under 5 minutes of work, easily reversible, and has no dependencies on other components.

When in doubt, treat it as non-trivial. The cost of unnecessary planning is minutes. The cost of unplanned multi-file changes is hours of debugging.
