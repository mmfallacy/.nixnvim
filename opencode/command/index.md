---
description: Builds "DeepWiki" docs (docs/index/) explaining system what/why/how.
agent: writer
model: google/gemini-2.5-flash-lite
temperature: 0.2
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
    "mkdir docs/index": allow
    "*": deny
  write:
    "docs/index/*": allow
    "*": deny
---

Build "DeepWiki" in `docs/index/` — explain what, why, and how the system works.

## Docs Structure

| File | What | Why | How |
|------|------|-----|-----|
| `README.md` | What the project is | Problem it solves | Quick start |
| `ARCHITECTURE.md` | System components | Design rationale | Data flow |
| `COMPONENTS.md` | Key modules/files | Their responsibilities | Usage patterns |
| `PATTERNS.md` | Coding conventions | Consistency benefits | Code examples |
| `TECHS.md` | Technologies used | Selection criteria | Integration points |
| `GLOSSARY.md` | Domain terms | Concepts | Relationships |

## Per-Doc Template

### What
Brief description of this component/concept.

### Why
The problem it solves or value it provides.

### How
Implementation details, usage, or flow. Use Mermaid diagrams.

## Rules

- Bespoke: Unique aspects only, no generic definitions
- Answer 3 questions: What? Why? How?
- Link to GLOSSARY for jargon
- Note "Known Divergences" if code/docs conflict
- Read-only codebase: Only write to `docs/index/`

## Workflow

1. Scan codebase structure (glob/read)
2. Identify core components + relationships
3. Create docs in order: TECHS → ARCHITECTURE → COMPONENTS → PATTERNS → GLOSSARY
4. Cross-link (`[Component](./COMPONENTS.md#section)`)
5. Keep docs < 200 lines each
