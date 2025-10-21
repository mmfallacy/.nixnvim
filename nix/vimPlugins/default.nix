{ pkgs }:
let
  hasFile = file: dir: dir |> builtins.readDir |> builtins.hasAttr file;
  hasDefault = hasFile "default.nix";
in
./.
|> builtins.readDir
|> pkgs.lib.mapAttrs' (
  path: type:
  # TODO: Refactor and clean this up
  if type == "directory" && hasDefault (./. + "/${path}") then
    pkgs.lib.nameValuePair path (pkgs.callPackage (./. + "/${path}") { })
  else if type != "regular" || path == "default.nix" then
    pkgs.lib.nameValuePair path null
  else
    let
      fname = path |> pkgs.lib.splitString "." |> builtins.head;
    in
    pkgs.lib.nameValuePair fname (pkgs.callPackage (./. + "/${path}") { })
)
|> pkgs.lib.filterAttrs (k: v: v != null)
