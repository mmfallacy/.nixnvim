{ pkgs }:
pkgs.lib.pipe ./. [

  builtins.readDir

  (pkgs.lib.mapAttrs' (
    path: type:
    if type != "regular" || path == "default.nix" then
      pkgs.lib.nameValuePair path null
    else
      let
        fname = path |> pkgs.lib.splitString "." |> builtins.head;
      in
      pkgs.lib.nameValuePair fname (pkgs.callPackage (./. + "/${path}") { })
  ))

  (pkgs.lib.filterAttrs (k: v: v != null))
]
