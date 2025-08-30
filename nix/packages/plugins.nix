{ pkgs, extras }:
let
  # NOTE: Preference is stable -> unstable -> master. master = extras.pkgs-master.vimPlugins;
  unstable = extras.pkgs-unstable.vimPlugins;

  master = extras.pkgs-master.vimPlugins;

  # Create plugin source from mypkgs and set to follow pkgs stable
  mypkgs = extras.mypkgs.vimPlugins;
in
# At least fallback to unstable in the case some plugins do not get backported.
# Immediately update once nixpkgs-master gets merged to unstable after a few days.
# i.e. when `nixos-xx.xx` (stable branch) supports the version indicated beside unstable.<plugin>
with pkgs.vimPlugins;
let
  treesitter = import ./treesitter.nix { inherit pkgs extras; };
in
{
  start = [ lazy-nvim ];
  # Place all in opt so lazy-nvim sees it.
  opt = [
    # Common Dependencies
    plenary-nvim

    # Plugins
    oil-nvim
    snipe-nvim
    unstable.render-markdown-nvim
    unstable.live-preview-nvim
    vim-sleuth

    # AI
    avante-nvim
    dressing-nvim
    img-clip-nvim
    nui-nvim

    master.codecompanion-nvim
    fidget-nvim

    #
    snacks-nvim
    nvim-config-local

    # Local used plugins:
    follow-md-links-nvim
    typst-preview-nvim

    # Git integration
    neogit
    diffview-nvim
    gitsigns-nvim

    blink-cmp
    blink-cmp
    blink-emoji-nvim
    blink-cmp-avante

    # snippets
    friendly-snippets

    # (pkgs.symlinkJoin {
    #   # Set luasnip to what neovim expects (L3MON4D3/LuaSnip).
    #   name = "LuaSnip";
    #   paths = [ luasnip ];
    # })

    luasnip

    # nvim-cmp
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-emoji
    cmp_luasnip

    # Colorschemes and icons
    onedarkpro-nvim
    night-owl-nvim
    mini-base16
    nvim-web-devicons

    # Mini.nvim
    mini-ai
    mini-cursorword
    mini-files
    mini-hipatterns
    mini-pairs
    mini-splitjoin
    mini-statusline
    mini-surround

    # telescope.nvim and extensions
    telescope-nvim
    telescope-ui-select-nvim
    telescope-fzf-native-nvim

    # treesitter
    nvim-treesitter
    nvim-treesitter-context
    # NOTE: Parsers are handled by ./treesiter.nix.

    # LSP and other configuration
    nvim-lspconfig
    lazydev-nvim
    conform-nvim
    # NOTE: LSP installation is handled by ./lsp.nix.

  ]
  ++ treesitter;
}
