# Project-Specific Agent Instructions

## Development Environment

- Check `./nix/devShell.nix` for available binaries. Packages are marked with `# @meta.mainProgram <name>` to indicate the binary name when it differs from the package name (e.g., `ripgrep` exposes `rg`).
- When binaries are not available, add it in `./nix/devShell.nix` and ask me to manually reload the development environment. Never tweak with the development environment on your own (e.g. install global binaries, etc.)

## Task Continuity

- When I say "ok continue", carry on with the previous goal I interrupted. Do not assume I want to continue the entire instruction without asking for permission.

## Documentation Updates

- Use the memory tool to update this AGENTS.md file for additional per-project rules.
- Consider commit-worthiness: minor workflow notes stay local; generalizable patterns that benefit future work may be worth committing.

## Code Quality

- Before completing code changes, run available lint/typecheck commands if they exist (check package.json, Makefile, or project-specific scripts).
- Lint and typecheck only modified files. Avoid running the linter and typechecker for the project as a whole.
- Follow existing code conventions: match naming patterns, style, and libraries already in use.

## Project Conventions

- Prefer existing libraries and utilities over introducing new dependencies.
- Never commit secrets, keys, or credentials. Warn users if they request this.
- Write idempotent, reversible operations where possible.
- If no project architecture has been established yet, adopt a vertically-sliced architecture. Split codebase into features instead of domain.
