{
  pkgs,
  mnw,
}:
mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  initLua = ''
    vim.print("MNW")
  '';

}
