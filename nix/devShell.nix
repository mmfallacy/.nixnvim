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

      ocdv =
        (selfpkgs.opencode.override {
          xdgConfig = "/home/mmfallacy/.nixnvim/";
        }).overrideAttrs
          (old: {
            postInstall = ''
              ${old.postInstall or ""}
              mv $out/bin/opencode $out/bin/ocdv
            '';
          });

    in
    [
      mnw
      mnwcd
      ocdv
    ];
}
