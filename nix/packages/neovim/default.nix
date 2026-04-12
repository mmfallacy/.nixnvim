{
  pkgs,
  mnw,
  extras,
  ...
}:
let
  plugins = import ./plugins.nix { inherit pkgs extras; };
  lsps = import ./lsp.nix { inherit pkgs extras; };
in
mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  luaFiles = [ ../../../nvimrc/init.lua ];

  plugins = plugins // {
    dev.nvimrc = {
      pure = ../../../nvimrc;
      impure = "/Users/mmfallacy/.nixnvim/nvimrc";
    };
  };

  extraBinPath =
    with pkgs;
    [
      ripgrep
      fd

      websocat # Required by typst-preview-nvim
      lsof # Required by opencode.nvim

      # difftastic 0.68 as difftastic.nvim requires aligned_lines
      extras.pkgs-unstable.difftastic # Required by difftastic.nvim

      # octo-nvim
      gh
    ]
    ++ lib.optionals (pkgs.system != "aarch64-darwin") [
      xclip
      wl-clipboard
    ]
    ++ lsps;

  # https://github.com/lumen-oss/rocks.nvim?tab=readme-ov-file#a-note-on-loading-rocks
  extraLuaPackages =
    ps:
    builtins.concatLists [
      ps.rest-nvim.propagatedBuildInputs
      [
        # Add extra packages here
      ]
    ];
}
