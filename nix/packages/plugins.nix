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
  treesitter = [
    nvim-treesitter
    nvim-treesitter-context
  ]
  # NOTE: Parsers are handled by ./treesiter.nix.
  ++ import ./treesitter.nix { inherit pkgs extras; };

  telescope = [
    telescope-nvim
    telescope-ui-select-nvim
    telescope-fzf-native-nvim
  ];

  mini = [
    mini-ai
    mini-cursorword
    mini-files
    mini-hipatterns
    mini-pairs
    mini-splitjoin
    mini-statusline
    mini-surround
  ];

  ai = [
    avante-nvim
    dressing-nvim
    img-clip-nvim
    nui-nvim

    unstable.codecompanion-nvim
    unstable.codecompanion-spinner-nvim
    unstable.codecompanion-lualine-nvim
    unstable.vectorcode-nvim
  ];

  cmp = [
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-emoji
    cmp_luasnip

    blink-cmp
    blink-cmp
    blink-emoji-nvim
    blink-cmp-avante

    friendly-snippets
    luasnip
  ];

  git = [

    neogit
    diffview-nvim
    gitsigns-nvim
  ];

  scheme = [
    onedarkpro-nvim
    night-owl-nvim
    mini-base16
    nvim-web-devicons
  ];

in
{
  start = [ lazy-nvim ];
  # Place all in opt so lazy-nvim sees it.
  opt = [
    # Common Dependencies
    plenary-nvim

    # NOTE: LSP installation is handled by ./lsp.nix and devShells.
    nvim-lspconfig
    lazydev-nvim
    conform-nvim

    mypkgs.otree-nvim

    # Miscellaneous
    oil-nvim
    snipe-nvim
    vim-sleuth
    snacks-nvim
    flash-nvim

    lualine-nvim

    # ft: markdown
    unstable.render-markdown-nvim
    unstable.live-preview-nvim

    # ft: typst
    typst-preview-nvim

    # ft: http
    rest-nvim
  ]
  ++ treesitter
  ++ telescope
  ++ mini
  ++ ai
  ++ cmp
  ++ git
  ++ scheme;
}
