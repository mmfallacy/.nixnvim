{
  nixConfig.substituters = [
    "https://cache.nixos.org/"
  ];
  # This presumes that nix-command and flakes are already active via nix.conf
  nixConfig.extra-experimental-features = [ "pipe-operators" ];

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

          extras = rec {
            pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
            pkgs-master = inputs.nixpkgs-master.legacyPackages.${system};
            pkgs-last = inputs.nixpkgs-last.legacyPackages.${system};

            nil = inputs.nil.packages.${system}.nil;
            mypkgs.vimPlugins = import ./nix/vimPlugins { inherit pkgs; };

            aider = pkgs-unstable.aider-chat;
            gemini-cli = pkgs-unstable.gemini-cli;
            opencode = pkgs-unstable.opencode;
          };
        in
        rec {
          devShells.${system}.default = import ./nix/devShell.nix {
            inherit pkgs;
            selfpkgs = packages.${system};
          };
          packages.${system} = rec {
            neovim = import ./nix/packages/neovim {
              inherit pkgs extras mnw;
            };
            vimPlugins = extras.mypkgs.vimPlugins;
            default = neovim;
            # Reexport version from extras for .nixconfig to install
            aider = extras.aider;
            gemini-cli = extras.gemini-cli;
            kulala-fmt = pkgs.callPackage ./nix/packages/kulala-fmt { };
            opencode = extras.opencode;
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
    nil.url = "github:oxalica/nil";
  };

}
