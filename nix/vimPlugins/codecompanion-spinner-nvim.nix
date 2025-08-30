{
  vimUtils,
  fetchFromGitHub,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "codecompanion-spinner.nvim";
  version = "2025-07-23";
  src = fetchFromGitHub {
    owner = "franco-ruggeri";
    repo = "codecompanion-spinner.nvim";
    rev = "1f53b8d402de2a5ee6f9d64793f5eda49ed12a64";
    sha256 = "02yqbpg4550y6x3jvbqlx6qcw4sbrixd56mhws2fxrvpz2s09fr7";
  };
  meta.homepage = "https://github.com/franco-ruggeri/codecompanion-spinner.nvim/";
  meta.hydraPlatforms = [ ];
}
