{ pkgs, extras, ... }:
# NOTE: If possible, please include only global LSPs here. Per-project language servers and formatters should reside in each project's respective devShell!
let
  master = extras.pkgs-master;
  unstable = extras.pkgs-unstable;
in
with pkgs;
[

  # Lua
  lua-language-server
  stylua

  # Nix
  nil
  nixd
  alejandra
  unstable.nixfmt-rfc-style

  # Markdown
  # stable has version 2024-10-07 which is 3 releases behind latest (2024-12-18) at the time of writing.
  marksman
  unstable.harper # Grammar checker required by nvim-lspconfig:harper_ls (0.56.0)

  # Typescript
  nodePackages.prettier

  # Bash
  shfmt
  shellcheck
  bash-language-server

  # Json
  jq
  vscode-langservers-extracted
]
