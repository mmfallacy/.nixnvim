{
  vimUtils,
  fetchFromGitHub,
  lib,
}:

vimUtils.buildVimPlugin {
  pname = "live-preview.nvim";
  version = "2025-08-17";
  src = fetchFromGitHub {
    owner = "brianhuster";
    repo = "live-preview.nvim";
    rev = "5890c4f7cb81a432fd5f3b960167757f1b4d4702";
    sha256 = "sha256-nWHytvuzWvFRilYCiMfzB64iZ+puXWrxJQfe1GtHJj8=";
  };
  # [brianhuster/live-preview.nvim#L24](https://github.com/brianhuster/live-preview.nvim/blob/6de1e71572673918e29cfc012c8dbfa59a2e464b/lua/livepreview/_spec.lua#L24) fails as it trips during neovimRequireCheckHook. Packages are not installed within the neovim context during build hence this fails.
  nvimSkipModules = [ "livepreview._spec" ];
  meta.homepage = "https://github.com/brianhuster/live-preview.nvim/";
  meta.license = lib.licenses.gpl3Only;

}
