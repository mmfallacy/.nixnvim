# Staged Review Glossary

- **Review group:** One behavior-sized proposed commit, with its necessary implementation and tests. Example: a declaration parser and its declaration tests.
- **Selected hunk:** A portion of a tracked file's diff chosen for one group. Example: declaration assertions selected from a file that also has assembly assertions.
- **Staged slice:** The exact changes currently in Git's index for review, possibly comprising whole files and selected hunks. Example: the parser plus only its declaration assertions.
- **Remaining work:** Intended changes still unstaged for later groups, including leftover hunks in a split file. Example: the assembler and its assembly assertions.
- **Independent validity:** A group works coherently on top of earlier groups without depending on later ones, and its leftover changes can still form coherent later groups. Example: declaration tests can pass with the staged parser while assembly tests remain unstaged until the assembler is ready.
