# Intake and grouping

With an empty index, identify the user's intended changes from their request and the changed-path inventory, including untracked files. Inspect relevant diffs, untracked contents, and nearby context only as needed; exclude unrelated fixes, formatting churn, local files, and artifacts. Ask a focused question if ownership or intent is unclear.

Before counting paths, name each proposed group's behavior, the boundary it protects, the consumer of that behavior, its implementation, and its direct tests. A shared invariant does not by itself make two consumers one group: declaration parsing rejecting invalid input and assembly detecting state mutated after parsing protect different boundaries, even when both check entry cardinality. Keep each behavior with its direct tests and necessary contracts in one stage round, even across files. Favor a small cohesive change over one-file-per-commit, one-layer-per-commit, arbitrary line limits, or bundling unrelated behavior. Separate a reusable prerequisite only if it stands on its own. Order groups by causal dependencies (evidence/requirement, prerequisite, consumer, follow-up); each group must be valid on top of its predecessors without relying on later work.

Before proposing a sequence, check [partial-staging feasibility](./partial-staging.md) for every shared file. Do not classify a tracked or untracked file as infeasible merely because it needs a patch. Identify the lines for each behavior, draft a candidate index-only patch for the first group from the raw Git diff or a full read of an untracked file, and use the non-mutating `git apply --cached --check -` to validate its shape. Check that the index slice is coherent and the worktree remainder belongs to later groups; future groups' exact patches can be prepared on their turns. If a concrete patch check, dependency, or boundary fails, report it and request an editing agent to split the file; do not change the index as a workaround or bundle behaviors.

Account for every changed hunk and every line of an untracked file: assign it to one behavior, explicitly exclude it, or flag it for a decision. Resolve flagged or ambiguous changes before requesting approval; do not put a change in the nearest group because it touches a related file. For each path, counts across groups must sum to its intended changes (excluding explicitly excluded changes). Count only each group's assigned added/deleted lines, including the assigned lines of a new file when split across groups.

For source-code boundaries in the proposed changes, use any explicit code-splitting principles the user already has, regardless of their filename or skill name. Otherwise, use [code-split defaults](./code-split-defaults.md). Judge source-code structure separately from Git grouping and leave unrelated legacy code alone.

## Feedback gate

Before proposing a sequence and again before staging an approved group, compare the actual diffs with the distinct behaviors and boundaries, direct tests, dependency order, staging feasibility, change accounting, any source-code boundary concern assessed above, and other requirements stated for this change. If a concrete defect, regression, incomplete slice, or ownership violation is apparent, cite the exact path/hunk and consequence; stop and request an edit rather than stage or disguise it as another group. If the concern is uncertain, state the evidence and ask one focused question before proceeding. Reassess the affected group after correction, and get approval again if its scope or order changed. Do not treat unrelated legacy code as a defect in the proposed changes.

Present a concise sequence with each group's purpose, exact paths or selected hunks, and why it comes here. Obtain approval before staging any group unless the user has already explicitly approved that exact scope and order. If the boundary cannot be made independently valid, ask for the code to be separated by an editing agent rather than stage an incomplete group.

## Initial plan format

Show this only after the behavior, feasibility, feedback, and accounting gates pass. List feature-related paths before test paths; omit an empty category and name explicitly excluded changes separately. Per-path counts cover only the changes assigned to that group and reconcile across groups with the entire intended diff or new-file contents. Label split-file counts provisional until the exact reviewed patch confirms them. If intended and excluded changes share a file, the patch must leave the exclusion unstaged; otherwise stop and request a file split.

```markdown
## Proposed sequence

1. <behavior and consumer; boundary protected>
   - Feature-related:
     - `<path>`: +<added> / -<deleted> (partial, if a patch is needed)
   - Tests:
     - `<path>`: +<added> / -<deleted> (partial, if a patch is needed)
   - **Why here:** <causal or dependency reason>
2. <next behavior and consumer; boundary protected>
   - Feature-related:
     - `<path>`: +<added> / -<deleted> (partial, if a patch is needed)
   - Tests:
     - `<path>`: +<added> / -<deleted> (partial, if a patch is needed)
   - **Why here:** <earlier group this depends on, or causal reason>

**Excluded:** <exact path/hunk and reason, if any>

Approve this sequence and I will stage the first group.
```

**Scenario — two consumers of entry cardinality:** Declaration parsing rejects invalid input; assembly guards against state mutated after parsing. Their direct tests share `tests/declarations.test.ts`. If tracked, inspect the raw diff; if untracked, read the file. Form and check a declaration-only patch, leaving assembly tests in the worktree for later. Do not refuse just because the test file is shared or untracked. Propose separate groups when the patch and remainder are coherent; otherwise identify the specific blocker and request a file split. An unrelated sourced-file mode assertion in `src/build/files.ts` needs its own explanation, exclusion, or decision; its path alone does not place it in the assembly group.
