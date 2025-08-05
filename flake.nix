{
  nixConfig.substituters = [
    "https://cache.nixos.org/"
  ];

  outputs =
    {
      nixpkgs-stable,
      systems,
      mnw,
      ...
    }@inputs:
    builtins.foldl' (a: b: a // b) { } (
      builtins.map (
        system:
        let
          pkgs = nixpkgs-stable.legacyPackages.${system};

          extras = {
            pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
            pkgs-master = inputs.nixpkgs-master.legacyPackages.${system};
            pkgs-last = inputs.nixpkgs-last.legacyPackages.${system};
          };
        in
        rec {
          devShells.${system}.default = import ./nix/devShell.nix {
            inherit pkgs;
            selfpkgs = packages.${system};
          };
          packages.${system} = rec {
            neovim = import ./nix/packages/neovim.nix {
              inherit pkgs extras mnw;
            };
            default = neovim;
          };
        }
      ) (import systems)
    );

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-last.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    systems.url = "github:nix-systems/default";
    mnw.url = "github:Gerg-L/mnw";
  };

}
