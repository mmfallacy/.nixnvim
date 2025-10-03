{
  vimUtils,
  fetchFromGitHub,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "codecompanion-spinner.nvim";
  version = "2025-09-11";
  src = fetchFromGitHub {
    owner = "franco-ruggeri";
    repo = "codecompanion-spinner.nvim";
    rev = "c1fa2a84ea1aed687aaed60df65e347c280f4f22";
    sha256 = "sha256-+lalwWE02YlLlU5zSqBotI5YstDuXtF8k0e6b7lxnhU=";
  };
  meta.homepage = "https://github.com/franco-ruggeri/codecompanion-spinner.nvim/";
}
