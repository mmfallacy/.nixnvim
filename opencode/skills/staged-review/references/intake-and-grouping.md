# Intake and grouping

With an empty index, identify the user's intended changes from their request and the changed-path inventory. Inspect relevant diffs and nearby context only as needed; exclude unrelated fixes, formatting churn, local files, and artifacts. Ask a focused question if ownership or intent is unclear.

Group by a reviewable behavior and its owner: keep the implementation, direct tests, and necessary contracts in one stage round, even across files. Favor a small cohesive change over one-file-per-commit, one-layer-per-commit, arbitrary line limits, or bundling unrelated behavior. A file is not necessarily a group: if `tests/widget.test.ts` contains declaration tests and assembly tests for separate behaviors, allocate its declaration hunks to the declaration group and assembly hunks to the assembly group; see [partial staging](./partial-staging.md) when selecting them. Separate a reusable prerequisite only if it stands on its own. Order groups by causal dependencies (evidence/requirement, prerequisite, consumer, follow-up); each proposed commit must be valid on top of its predecessors without relying on later work.

For source-code boundaries in the proposed changes, use any explicit code-splitting principles the user already has, regardless of their filename or skill name. Otherwise, use [code-split defaults](./code-split-defaults.md). Judge source-code structure separately from Git grouping and leave unrelated legacy code alone.

## Feedback gate

Before proposing a sequence and again before staging an approved group, compare the actual diffs with the intended behavior, direct tests, dependency order, any source-code boundary concern assessed above, and other requirements stated for this change. If a concrete defect, regression, incomplete slice, or ownership violation is apparent, cite the exact path/hunk and consequence; stop and request an edit rather than stage or disguise it as another group. If the concern is uncertain, state the evidence and ask one focused question before proceeding. Reassess the affected group after correction, and get approval again if its scope or order changed. Do not treat unrelated legacy code as a defect in the proposed changes.

Present a concise sequence with each group's purpose, exact paths or selected hunks, and why it comes here. Obtain approval before staging any group unless the user has already explicitly approved that exact scope and order. If the boundary cannot be made independently valid, ask for the code to be separated by an editing agent rather than stage an incomplete group.

## Initial plan format

Show this before staging when approval is needed. List feature-related paths before test paths; omit an empty category. Count only the changes assigned to each group, not a shared file's entire diff, and label selected-hunk counts provisional until Git confirms the selection.

```markdown
## Proposed sequence

1. <behavior and purpose>
   - Feature-related:
     - `<path>`: +<added> / -<deleted>
   - Tests:
     - `<path>`: +<added> / -<deleted> (provisional; selected hunks)
   - **Why here:** <causal or dependency reason>
2. <next behavior and purpose>
   - Feature-related:
     - `<path>`: +<added> / -<deleted>
   - Tests:
     - `<path>`: +<added> / -<deleted> (provisional; selected hunks)
   - **Why here:** <earlier group this depends on, or causal reason>

Approve this sequence and I will stage the first group.
```

**Scenario — empty index, two behaviors in one file:** `tests/widget.test.ts` has declaration and assembly assertions, while `src/declaration.ts` and `src/assembler.ts` implement the respective behaviors. Propose declaration plus its test hunks first, assembly plus its test hunks second; list the test file in both groups with each group's *own* line counts. Wait for approval, then use [partial staging](./partial-staging.md) for the shared file.
