# /checkpoint — Save Session State Before Closing

When this command is invoked, create a checkpoint file that allows a future session to resume seamlessly.

## Steps:

1. Summarize what was accomplished in this session.
2. List any tasks that are in progress but not complete.
3. List any decisions that were made and their rationale.
4. List any blockers or open questions for Shua.
5. Write this summary to: `[project root]/tasks/checkpoint-[YYYY-MM-DD-HHMM].md`
6. If any universal lessons were discovered, append them to `~/.claude/lessons.md`.
7. Confirm to Shua that the checkpoint was written and the session can be safely closed.

## Checkpoint Format:

```
# Session Checkpoint — [DATE TIME]

## Completed
- [Item 1]
- [Item 2]

## In Progress
- [Item with current state]

## Decisions Made
- [Decision]: [Rationale]

## Blockers / Open Questions
- [Question for Shua]

## Next Session Should
- [First thing to do when resuming]
```
