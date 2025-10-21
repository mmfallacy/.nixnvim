{
  luaPackages,
  neovimUtils,
  fetchFromGitHub,
  fetchurl,
}:
neovimUtils.buildNeovimPlugin {
  luaAttr = luaPackages.oil-nvim.overrideAttrs rec {
    version = "scm-1";
    rockspecVersion = version;
    knownRockspec =
      (fetchurl {
        url = "mirror://luarocks/oil.nvim-scm-1.rockspec";
        sha256 = "sha256-ZT+expuppTD/NP57dls/BMSwUu6VBOSfEw8RQe4vqv0=";

      }).outPath;
    src = fetchFromGitHub {
      owner = "stevearc";
      repo = "oil.nvim";
      rev = "7e1cd7703ff2924d7038476dcbc04b950203b902";
      sha256 = "sha256-ebRao8UU8UI1S6Lumkd5vUiYYSj9UAazcEzThKyl8Uk=";
    };
  };
}
