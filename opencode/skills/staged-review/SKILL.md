---
name: staged-review
description: Use ONLY for staged-review Git sessions that plan behavior-scoped commit groups, stage one approved group, or resume after a review commit.
---

# Staged Review

Outcome: an independently valid, approved behavior slice in the index, with the rest of the user's work intact and a short explanation before stopping for review. Start with `git status --short`.

- Scope takes precedence over file boundaries: keep the behavior and its direct tests together; split a shared file only when the staged slice and remaining work each make sense.
- Never change an index that was already non-empty on arrival. Never commit, amend, push, discard, restore, reset, unstage, edit, format, or generate user files. Only stage via exact paths or Git's selected-hunk interface after approval; never stage a known defect or secret.
- If a proposed group appears incorrect, pause before staging and use the intake-and-grouping feedback gate.
- Read only the reference needed for the current decision (paths relative to this skill):
  - [Intake and grouping](./references/intake-and-grouping.md): deciding what belongs, commit order, or whether to request approval.
  - [Partial staging](./references/partial-staging.md): choosing whole files versus hunks, staging, or checking index and remainder.
  - [Continuation and reporting](./references/continuation-and-reporting.md): explaining a staged index, resuming after a commit, or detecting drift.
