# This file handles nvim-treesitter's parsers.
# To install a parser, include it in the array of the grammars variable.
# To install nvim-treesitter, include it as part of ./plugins.nix;
{
  pkgs,
  extras,
}:
let
  inherit (extras.pkgs-unstable.vimPlugins) nvim-treesitter;
  # nvim-treesitter provides us a neat way of creating a derivation of nvim-treesitter
  # either withAllGrammars or via withPlugins where we specify the grammars we include.
  TSwithAllGrammars = nvim-treesitter.withAllGrammars;

  TSwithGrammars = nvim-treesitter.withPlugins (
    grammar:
    with grammar;
    # This array basically contains treesitter's ensure_installed
    # The following are based off of LazyVim's default ensure_installed.
    [
      bash
      c
      diff
      html
      javascript
      jsdoc
      json
      lua
      luadoc
      luap
      markdown
      markdown_inline
      printf
      python
      query
      regex
      toml
      tsx
      typescript
      vim
      vimdoc
      xml
      yaml
      zig

      nix
      http
      # Go
      go
      gomod
      gosum

      #Svelte
      svelte
    ]
  );

in
TSwithGrammars.dependencies
