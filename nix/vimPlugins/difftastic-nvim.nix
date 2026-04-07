{
  vimUtils,
  fetchFromGitHub,
  vimPlugins,
}:
let

  difftastic = vimUtils.buildVimPlugin {
    pname = "difftastic.nvim";
    version = "0.0.9-unstable-2026-03-14";
    src = fetchFromGitHub {
      owner = "clabby";
      repo = "difftastic.nvim";
      rev = "6041ef0244b3fecf3b7f07de9af8cfbf8dbc4945";
      hash = "sha256-23NGKhytF3OsLJgdrC51IH/sIGoqe/yBfmPsZKHOMSk=";
    };
    meta.homepage = "https://github.com/clabby/difftastic.nvim/";
    meta.hydraPlatforms = [ ];
  };
in
difftastic.overrideAttrs {
  dependencies = [ vimPlugins.nui-nvim ];
}
