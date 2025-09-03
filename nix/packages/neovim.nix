{
  pkgs,
  mnw,
  extras,
}:
let
  plugins = import ./plugins.nix { inherit pkgs extras; };
  lsps = import ./lsp.nix { inherit pkgs extras; };
in
mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  luaFiles = [ ../../nvimrc/init.lua ];

  plugins = plugins // {
    dev.nvimrc = {
      pure = ../../nvimrc;
      impure = "/home/mmfallacy/.nixnvim/nvimrc";
    };
  };

  extraBinPath =
    with pkgs;
    [
      xclip
      wl-clipboard

      ripgrep
      fd

      websocat # Required by typst-preview-nvim

      extras.pkgs-unstable.vectorcode # Required by vectorcode-nvim. Use same version

      # extras.aider
    ]
    ++ lsps;

}
