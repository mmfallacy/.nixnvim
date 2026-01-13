---
mode: primary
model: xai/grok-4-1-fast-non-reasoning
temperature: 0.1
effort: low
thinking:
  type: disabled
# ---
permission:
  read: allow
  glob: allow
  grep: allow
  bash:
    "git log *": allow
    "git show *": allow
    "git diff *": allow
    "rg *": allow
    "head *": allow
    "tail *": allow
    "*": deny
  write:
    "docs/index/*": allow
    "*": deny
---
