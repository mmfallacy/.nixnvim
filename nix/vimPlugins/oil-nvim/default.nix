{
  luaPackages,
  neovimUtils,
  fetchFromGitHub,
}:
neovimUtils.buildNeovimPlugin {
  luaAttr = luaPackages.oil-nvim.overrideAttrs rec {
    version = "scm-1";
    rockspecVersion = version;
    # When updating rev, update git_rev in rockspec too!
    knownRockspec = ./oil.nvim-scm-1.rockspec;
    src = fetchFromGitHub {
      owner = "stevearc";
      repo = "oil.nvim";
      rev = "7e1cd7703ff2924d7038476dcbc04b950203b902";
      sha256 = "sha256-ebRao8UU8UI1S6Lumkd5vUiYYSj9UAazcEzThKyl8Uk=";
    };
  };
}
