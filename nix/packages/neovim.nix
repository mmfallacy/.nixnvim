{
  pkgs,
  mnw,
  extras,
}:
mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  initLua = ''
    vim.print("MNW")
  '';

  plugins = import ./plugins.nix { inherit pkgs extras; };
}
