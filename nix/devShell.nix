{
  pkgs,
  selfpkgs,
}:
with pkgs;
mkShell {
  name = ".nixconfig base template";

  nativeBuildInputs =
    let
      bin = pkg: lib.getExe pkg;

      mnw = pkgs.symlinkJoin rec {
        name = "mnw";
        meta.mainProgram = name;
        paths = [ selfpkgs.neovim.devMode ];
        postBuild = ''
          # Rename nvim output to mnw
          mv $out/bin/nvim $out/bin/mnw
        '';
      };

      # Open mnw at given directory by changing pwd.
      mnwcd = pkgs.writeShellScriptBin "mnwcd" ''
        pushd "$1" && ${bin mnw} . "''${@:2}" && popd
      '';

      opencode = selfpkgs.opencode.override {
        xdgConfig = "/home/mmfallacy/.nixnvim/";
      };

    in
    [
      mnw
      mnwcd
      opencode
    ];
}
