{
  pkgs,
  mnw,
  extras,
}:
mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  luaFiles = [ ../../nvimrc/init.lua ];

  plugins = import ./plugins.nix { inherit pkgs extras; } // {
    dev.nvimrc = {
      pure = ../../nvimrc;
      impure = "/home/mmfallacy/.nixnvim/nvimrc";
    };
  };
}
