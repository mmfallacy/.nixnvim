# Staged Review Glossary

- **Review group:** One behavior-sized proposed commit, with its necessary implementation and tests. Example: a declaration parser and its declaration tests.
- **Selected hunk:** A portion of a tracked file's diff chosen for one group and copied into a reviewed index-only patch. Example: declaration assertions selected from a file that also contains assembly assertions.
- **Staged slice:** The exact changes currently in Git's index for review, possibly whole files, selected hunks, or a partial new-file patch. Example: a parser and only its declaration tests.
- **Remaining work:** Intended changes still unstaged for later groups, including changes left in a shared file. Example: the assembler and assembly assertions remaining in the worktree.
- **Independent validity:** A group works coherently on top of earlier groups without depending on later ones, and leaves later work coherent. Example: declaration tests can pass with the staged parser while assembly tests remain unstaged until the assembler is ready.
