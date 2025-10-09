{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "xeno.nvim";
  version = "2025-08-27";
  src = fetchFromGitHub {
    owner = "kyza0d";
    repo = "xeno.nvim";
    rev = "4a1d3946b5c3b9b581e76a84746a06b0977b1fed";
    sha256 = "sha256-zdFT/8CkRdAjXoUYEIX/8fMMyVHs18aJf/+Fv4MYctE=";
  };
  meta.homepage = "https://github.com/kyza0d/xeno.nvim/";
  meta.hydraPlatforms = [ ];
}
