# Rule: Model & Effort Selection

## When to Use Opus (claude-opus-4-6)

- Orchestrating multi-agent workflows with interdependent tasks
- High-stakes changes where failed loops are expensive to recover from
- Ambiguous problem spaces requiring judgment between sub-agent outputs
- Any workflow where silent drift across sessions would be catastrophic
- Architecture review or cross-file analysis with complex interdependencies
- Escalation after 2 sub-agent failures on the same task

## When Sonnet (claude-sonnet-4-6) Is Correct

- Working sub-agent on a well-scoped task with explicit instructions
- Single-agent delegation with clear scope
- Low-risk, reversible changes (docs, non-critical config)
- High-volume repeated pipelines where cost matters

## Effort Levels

| Level | Use When |
|-------|----------|
| low | Simple, well-defined, single-step tasks with zero ambiguity |
| medium | Standard dev tasks — read, modify, test a specific thing |
| high | Audit, architecture review, cross-file analysis, anything where missing something is costly |

## Default Configuration

- Orchestrator: opus-4-6 · high
- Working sub-agents: sonnet-4-6 · medium
- Audit agents: sonnet-4-6 · high
