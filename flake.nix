{
  description = "An unstable as f#@% flake-based NixOS configuration.";

  outputs = { self, flake-parts, ... }@inputs:
    let
      inherit (flake-parts.lib) mkFlake;

      linuxArch = "x86_64-linux";
      stateVersion = "24.11";
      inherit (import ./functions/hosts.nix {
        inherit inputs self stateVersion;
      })
        mkHost;

      hosts = {
        Skadi = {
          hostname = "Skadi";
          username = "heartblin";
          platform = linuxArch;
        };
      };
    in mkFlake { inherit inputs; } {
      systems = [ linuxArch ];

      flake = {
        nixosConfigurations = { ${hosts.Skadi.hostname} = mkHost hosts.Skadi; };
      };

      perSystem = { pkgs, ... }: {
        devShells.lint = pkgs.mkShellNoCC {
          nativeBuildInputs = with pkgs; [ statix nixfmt-classic ];
        };

        checks.statix = pkgs.stdenvNoCC.mkDerivation {
          name = "statix-check";
          src = ./.;
          doCheck = true;
          nativeBuildInputs = with pkgs; [ statix nixfmt-classic ];

          checkPhase = ''
            statix check
            nixfmt -c .
          '';

          # Shitty workaround
          installPhase = ''
            mkdir $out
          '';
        };

        formatter = with pkgs; nixfmt-classic;
      };
    };

  inputs = {
    # Official repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Make flakes pretty
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Declarative home
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Declarative disk partitioning
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Alternative to 'nix'
    lix.url =
      "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    lix.inputs.nixpkgs.follows = "nixpkgs";

    # Provides SecureBoot support
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };
}
