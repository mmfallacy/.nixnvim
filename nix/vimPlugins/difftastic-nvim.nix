{
  vimUtils,
  fetchFromGitHub,
  vimPlugins,
  rustPlatform,
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
    preInstall = ''
      mkdir -p target/release
      ln -s ${difftastic-lib}/lib/* target/release/
      # Difftastic.nvim expect the shared object doesnt have lib prefix
      # Precreate link instead of letting difftastic.nvim handle it
      # Both darwin and linux expect difftastic_nvim.so
      pushd target/release
      for f in libdifftastic_nvim.{so,dylib}; do
        [ -e "$f" ] || continue
        ln -s "$f" "difftastic_nvim.so"
      done
      popd
    '';
  };
  difftastic-lib = rustPlatform.buildRustPackage {
    inherit (difftastic) version src;
    pname = "difftastic-lib";
    cargoHash = "sha256-VSlFlLa4knQ7bH8yFHSKTTtt1cQ76dstlCdWBAtkf1I=";
  };
in
difftastic.overrideAttrs {
  dependencies = [ vimPlugins.nui-nvim ];
}
