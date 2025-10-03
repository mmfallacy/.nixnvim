{
  vimUtils,
  fetchFromGitHub,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "codecompanion-lualine.nvim";
  version = "2025-09-11";
  src = fetchFromGitHub {
    owner = "franco-ruggeri";
    repo = "codecompanion-lualine.nvim";
    rev = "b264433444715bf07ee9f7d5015086b927ccf7f1";
    sha256 = "sha256-I8WIEeOjebd99ojgm+l6cMqh+U2bGeHsM7m5x2XI+eg=";
  };
  meta.homepage = "https://github.com/franco-ruggeri/codecompanion-lualine.nvim/";
}
