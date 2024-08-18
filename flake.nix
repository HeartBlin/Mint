{
  description = "An unstable as f#@% flake-based NixOS configuration.";

  outputs = { self, flake-parts, ... }@inputs:
    let
      inherit (flake-parts.lib) mkFlake;

      linuxArch = "x86_64-linux";
      stateVersion = "24.11";
      inherit (import ./functions/mkHost.nix {
        inherit inputs self stateVersion;
      })
        mkHost;
      inherit (import ./functions/mkIso.nix {
        inherit inputs self stateVersion;
      })
        mkIso;

      hosts = {
        # ROG Strix G513IE
        Skadi = {
          hostname = "Skadi";
          username = "heartblin";
          platform = linuxArch;
        };

        # ISO
        Specter = {
          hostname = "Specter";
          username = "nixos";
          platform = linuxArch;
        };
      };
    in mkFlake { inherit inputs; } {
      systems = [ linuxArch ];

      flake = {
        nixosConfigurations = {
          ${hosts.Skadi.hostname} = mkHost hosts.Skadi;
          ${hosts.Specter.hostname} = mkIso hosts.Specter;
        };
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
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Alternative to 'nix', on MAIN - BETA
    lix-repo = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix = {
      url =
        "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix-repo";
    };

    # Provides SecureBoot support
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # CachyOS kernel provider
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Tiling wayland compositor
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };
}
