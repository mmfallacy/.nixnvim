{ vimUtils, fetchFromGitHub }:
vimUtils.buildVimPlugin {
  pname = "99";
  version = "unstable-02-02-2026";
  src = fetchFromGitHub {
    owner = "ThePrimeagen";
    repo = "99";
    rev = "2c771814e1d95280ee99545de61b28dfa773c5fa";
    hash = "sha256-Gzh7YMWJtBzacy1ivOZhGrTVXhwMI2Yz3SiEWzET+PM=";
  };
  meta.homepage = "https://github.com/ThePrimeagen/99";
  meta.hydraPlatforms = [ ];
}
