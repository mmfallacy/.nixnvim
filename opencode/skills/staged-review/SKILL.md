---
name: staged-review
description: Manage a large Git working tree as small, related staged review chunks. Use when the user asks to review, split, stage, or commit a large change set incrementally, or says "continue" after a staged-review chunk.
---

# Staged Review

Turn a large Git change set into one small, coherent staged chunk at a time. The user owns the commit. You own inspecting the full change set, selecting and staging the next reviewable unit, and explaining it.

## Invariants

- Stage exactly one proposed commit per turn, then stop.
- Never commit, amend, push, discard, or rewrite worktree changes.
- Never mix a new chunk into a non-empty index.
- Never modify files merely to make a chunk easier to stage unless the user separately asks for code changes.
- Preserve unrelated and partially staged work. Use path-specific Git commands and `--` before paths.
- Prefer whole files. Stage individual hunks only when one file contains clearly separable concerns and the split can be performed and verified safely without editing the worktree.
- Cohesion outranks an arbitrary line limit. The smallest valid chunk is a behavior or concept, not a fixed number of lines.

## Start Or Resume

At the start of every turn, inspect current state rather than relying on earlier output:

1. Run `git status --short`.
2. Inspect staged changes with `git diff --cached --stat` and `git diff --cached`.
3. Inspect unstaged changes with `git diff --stat` and enough of `git diff` to understand every candidate cluster at a high level.
4. Include untracked files in the inventory and read likely candidates before selecting them. Do not stage unknown untracked content.
5. Use the user's stated task, relevant task or design documents, branch history, and the overall diff to identify the overarching goal. Label the goal as inferred when it was not stated explicitly.

If the index already contains changes:

- If it is the prior proposed chunk, do not add anything. Remind the user that it is awaiting their commit.
- If it is already small and coherent, treat it as the current chunk: review and summarize it without staging more.
- If it is large or mixes concerns, explain that it must be repartitioned and ask permission before changing the index. Any approved unstaging operation must preserve the worktree, and state must be rechecked afterward.

## Choose The Next Chunk

Build conceptual groups from paths, imports, call sites, tests, configuration, and the behavior each change serves. Choose the smallest group that tells one complete review story and can reasonably stand as one commit.

Prefer foundational chunks before dependants. Useful groupings include:

- an implementation change with its focused tests;
- a type or interface with the immediate consumers required to keep the tree valid;
- a schema change with its migration and directly coupled model updates;
- a dependency declaration with its lockfile update;
- source input with generated output when repository conventions require both;
- documentation or configuration changes that express one policy.

Do not group files merely because they share a directory, were edited together, or all contribute vaguely to the branch. Keep drive-by formatting, refactors, generated churn, and unrelated fixes separate.

Aim for roughly 1-5 files and no more than about 200 changed lines when that remains coherent. Exceed those guides rather than omit required tests, contracts, migrations, generated artifacts, or lockfile data. If no independently valid small chunk exists, choose the smallest coherent dependency slice and say why it is larger.

Before staging, inspect the selected files in full diff context. Check for secrets, debug artifacts, accidental generated files, incomplete rename pairs, and dependencies on changes deferred to later chunks. If the chunk would be misleading or broken on its own, revise the selection.

## Stage And Verify

Stage only the selected paths or safely selected hunks. Do not use `git add .`, `git add -A`, broad globs, or interactive Git commands.

After staging:

1. Run `git status --short`.
2. Run `git diff --cached --check`.
3. Review `git diff --cached --stat` and the complete `git diff --cached`.
4. Confirm that the index contains exactly the intended chunk and no prior or unrelated staged changes.
5. If verification fails, repair only the index while preserving the worktree, then verify again. Ask before any operation whose preservation behavior is uncertain.

Do not run broad project verification as part of this workflow unless the user asks. Mention relevant checks the eventual commit may need when they are evident from the repository.

## Present The Chunk

After verification, give a concise review packet in this shape:

```markdown
**Staged Chunk: <short purpose>**

Files: `<path>`, `<path>`
Size: <files changed, insertions, deletions>

What changed: <brief behavioral summary>
Why: <reason this change exists>
Overarching goal: <how this chunk advances the larger task, noting any inference>
Review notes: <important behavior, risk, dependency, or suggested verification; omit if none>

Review the staged diff with `git diff --cached`. Commit it when ready, then say `continue` for the next chunk.
```

Do not propose a commit command unless requested. Do not select or stage the next chunk in the same turn.

## Continue

When the user says `continue`, first verify that the prior chunk is no longer staged.

- If it is still staged, do not proceed; remind them to commit it or explicitly ask to replace/repartition it.
- If the index is empty, recompute the remaining change inventory and stage exactly one next chunk using this workflow.
- If no changes remain, report that the review queue is complete.
