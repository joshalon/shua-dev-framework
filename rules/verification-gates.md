# Rule: Verification Gates

Nothing is accepted as complete without independent verification.

## Gate Criteria

1. **Code changes**: Audit agent reads the modified files directly (not the working agent's description) and confirms the changes match the task scope.
2. **Test results**: Audit agent runs the test suite independently and reports exact pass/fail count. Working agent's test report alone is insufficient.
3. **Configuration changes**: Audit agent verifies the config is valid (syntax check, no regressions) and matches the intended specification.
4. **Multi-step workflows**: Each step is gated independently. Step N+1 does not begin until Step N's audit passes.
5. **Scope compliance**: Audit agent verifies that the working agent did NOT touch anything outside the declared scope or "do not touch" list.

## Discrepancy Handling

If the audit agent's findings conflict with the working agent's report:
- The working agent's work is considered UNVERIFIED
- The discrepancy is flagged explicitly in the report to Shua
- The task must be redone before proceeding

## When Gates Can Be Skipped

Gates can be skipped ONLY for trivial tasks (single-file, < 5 min, easily reversible, no dependencies). If Shua explicitly says "skip audit" for a specific task, that override applies to that task only — not to subsequent tasks.
