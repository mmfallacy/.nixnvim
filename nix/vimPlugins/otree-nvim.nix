{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "Otree.nvim";
  version = "2025-09-18";
  src = fetchFromGitHub {
    owner = "Eutrius";
    repo = "Otree.nvim";
    rev = "1540ea0a300916f1c43063fda185463b3e8f2f40";
    sha256 = "sha256-ZLWtsMxy9SYp+GhNSBp4NpsbNCdsRV6+cirwLZiSu3k=";
  };
  meta.homepage = "https://github.com/Eutrius/Otree.nvim/";
  meta.hydraPlatforms = [ ];
}
