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
    let
      mapped = builtins.map (
        system:
        let
          default = {
            inherit system;
            config.allowUnfree = true;
          };

          pkgs = import nixpkgs-stable default;

          extras = rec {
            pkgs-unstable = import inputs.nixpkgs-unstable default;
            pkgs-master = import inputs.nixpkgs-master default;
            pkgs-last = import inputs.nixpkgs-last default;

            # nil = inputs.nil.packages.${system}.nil;
            mypkgs.vimPlugins = import ./nix/vimPlugins { pkgs = pkgs-unstable; };

            aider = pkgs-unstable.aider-chat;
            gemini-cli = pkgs-unstable.gemini-cli;
            opencode = pkgs-master.callPackage ./nix/packages/opencode.nix {
              runtimeDeps = [ pkgs-unstable.rtk ];
            };
            ocdv = opencode.override {
              xdgConfig = "/Users/mmfallacy/.nixnvim/";
            };
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
            ocdv = extras.ocdv;
          };
        }
      ) (import systems);
    in
    builtins.foldl' nixpkgs-stable.lib.recursiveUpdate {
      inherit mapped;
    } mapped;

  inputs = {
    nixpkgs-stable.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    nixpkgs-last.url = "https://channels.nixos.org/nixos-25.11/nixexprs.tar.xz";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    systems.url = "github:nix-systems/default";
    mnw.url = "github:Gerg-L/mnw";
  };

}
