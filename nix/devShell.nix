{
  pkgs,
  selfpkgs,
}:
with pkgs;
mkShell {
  name = ".nixconfig base template";

  nativeBuildInputs =
    let
      mnw = pkgs.symlinkJoin {
        name = "mnw";
        paths = [ selfpkgs.neovim.devMode ];
        postBuild = ''
          # Rename nvim output to mnw
          mv $out/bin/nvim $out/bin/mnw
        '';
      };
    in
    [
      mnw
    ];

}
