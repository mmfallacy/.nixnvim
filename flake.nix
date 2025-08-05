{
  nixConfig.substituters = [
    "https://cache.nixos.org/"
  ];

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    systems.url = "github:nix-systems/default";
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs =
    {
      nixpkgs-stable,
      systems,
      mnw,
      ...
    }:
    builtins.foldl' (a: b: a // b) { } (
      builtins.map (
        system:
        let
          pkgs-stable = nixpkgs-stable.legacyPackages.${system};
        in
        {
          devShells.${system}.default = import ./nix/devShell.nix { pkgs = pkgs-stable; };
          packages.${system}.default = import ./nix/packages/neovim.nix {
            pkgs = pkgs-stable;
            inherit mnw;
          };
        }
      ) (import systems)
    );
}
