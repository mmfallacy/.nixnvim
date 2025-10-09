{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "headhunter.nvim";
  version = "2025-10-06";
  src = fetchFromGitHub {
    owner = "StackInTheWild";
    repo = "headhunter.nvim";
    rev = "45eff1653c27a19c47c8a2dfed4897d4a434408d";
    sha256 = "sha256-Icm5wuAZ6xWXsg0jO28uzXTl+3NSte3p1G7lViyb5ZI=";
  };
  meta.homepage = "https://github.com/StackInTheWild/headhunter.nvim/";
  meta.hydraPlatforms = [ ];
}
