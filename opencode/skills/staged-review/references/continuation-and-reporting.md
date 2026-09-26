# Continuation and reporting

When the index is already staged on arrival, inspect the cached diff and explain its behavior, tests, and concrete risks; stop without adding or regrouping. For a newly staged group, report its purpose, exact staged paths/slice, why it belongs together, and what comes next. Keep it brief, grounded in the cached diff, and invite the user to review and commit before continuing.

On `continue` or `next`, verify the prior group was committed and the index is empty (`git status --short`, and recent `git log`/`git show` when needed). If it was not committed, or a different index is staged, explain and stop. Compare remaining intended paths and changes with the approved sequence, including unstaged hunks left in a split file; ignore known exclusions. If remaining work changed, inspect the affected diffs and revise the plan. Request approval again only if scope or order changed; otherwise proceed with the next approved group using the relevant decision reference.

Use a path set plus a content fingerprint only when there is a real continuity need (for example, a long pause or ambiguous changes), not as routine output or a substitute for inspecting changed work. Avoid broad checks. Stop after one staged group.

## Per-stage report format

Use after staging, or to explain a pre-existing index (without claiming to have staged it). List feature-related paths first, then test paths; omit a category if empty. Suggest an imperative commit subject, but leave the commit to the user. Explain the changes in about 25–45 words (usually one or two sentences), noting a concrete risk there if relevant. List **Behavioral assumptions** only when staged tests introduce them: briefly state the behaviors those tests assume, without claiming the tests passed. Base every claim on the cached diff; use `none` under **Next** only if no intended work remains, or `not yet established` if the next group is unknown.

```markdown
## Staged: <behavior and purpose>

**Staged paths**
- Feature-related:
  - `<path>`: +<added> / -<deleted> (selected hunks, if applicable)
- Tests:
  - `<path>`: +<added> / -<deleted> (selected hunks, if applicable)

**Suggested message:** `<imperative commit subject>`

<One or two sentences explaining what the staged changes do.>

**Why together:** <how these paths deliver one behavior>

**Behavioral assumptions:**
- <behavior assumed by an introduced staged test>

**Next:** <next approved group, none, or not yet established>

Review with `git diff --cached`. Commit when ready, then say `continue`.
```

**Scenario — already staged index:** `git status --short` shows staged declaration changes before this agent starts. Read the cached diff, report its actual slice and any risks using the format above, then stop; do not stage assembly or claim to have staged the declaration.

**Scenario — after the first commit:** The user committed the declaration group and says `continue`. Confirm the commit and empty index, then inspect the remaining assembly implementation and test hunks. If they still match the approved second group, stage only assembly and report it; if their scope or order changed, show the revised sequence for approval instead.
