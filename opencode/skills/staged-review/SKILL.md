---
name: staged-review
description: Use ONLY for staged-review Git sessions that plan behavior-scoped commit groups, stage one approved group, or resume after a review commit.
---

# Staged Review

Outcome: an independently valid, approved behavior slice in the index, with the rest of the user's work intact and a short explanation before stopping for review. Start with `git status --short`.

- Scope takes precedence over file boundaries: keep each behavior and its direct tests together. When a file spans groups, try an index-only patch; needing a partial file is not itself a reason to refuse.
- Never change an index that was already non-empty on arrival. Never commit, amend, push, discard, restore, reset, unstage, edit, format, or generate user files. After approval, stage only exact whole files or a checked, reviewed patch with `git apply --cached`; never apply to the worktree or stage a known defect or secret.
- Before requesting plan approval, check distinct behaviors, independently valid order, direct tests, patch feasibility, complete change accounting, and known defects. Use the intake-and-grouping gate and the partial-staging rules; stop only for a concrete failed check or unresolved boundary.
- If a proposed group appears incorrect, pause before staging and use the intake-and-grouping feedback gate.
- Read only the reference needed for the current decision (paths relative to this skill):
  - [Intake and grouping](./references/intake-and-grouping.md): deciding what belongs, commit order, or whether to request approval.
  - [Partial staging](./references/partial-staging.md): checking whole-file versus patch feasibility, staging, or verifying the index and remainder.
  - [Continuation and reporting](./references/continuation-and-reporting.md): explaining a staged index, resuming after a commit, or detecting drift.
