# Rule: Anti-Patterns to Avoid

These failure modes have been observed in real multi-agent sessions. Avoid them categorically.

| Anti-Pattern | Correct Approach |
|---|---|
| Working agent audits its own work | Always spawn a separate audit session |
| Audit agent reads working agent's report instead of source | Audit agent reads files and runs tests directly |
| Tasks run in parallel before dependencies verified | Sequential with audit gate between each task |
| "Tests passing" accepted without independent verification | Audit agent runs tests independently |
| Vague scope ("clean up the config") | Every scope item is specific, concrete, verifiable |
| No explicit "do not touch" list | Always include hard constraints alongside task scope |
| New tasks stacked on unverified prior work | Wait for orchestrator report before sending next task |
| Partial completion accepted as success | Every scope item must appear in audit verification |
| Monolithic prompt with 10+ requirements | Break into modular, sequential sub-tasks |
| Abstract principles without concrete examples | Use compressed episodes with conditions + outcomes |
