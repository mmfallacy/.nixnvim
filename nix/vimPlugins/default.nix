{ pkgs }:
./.
|> builtins.readDir
|> pkgs.lib.mapAttrs' (
  path: type:
  if type != "regular" || path == "default.nix" then
    pkgs.lib.nameValuePair path null
  else
    pkgs.lib.nameValuePair path (pkgs.callPackage (./. + "/${path}") { })
)
|> pkgs.lib.filterAttrs (k: v: v != null)
