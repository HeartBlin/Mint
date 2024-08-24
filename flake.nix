{
  description = "An unstable as f#@% flake-based NixOS configuration.";

  outputs = { self, flake-parts, ... }@inputs:
    let
      inherit (flake-parts.lib) mkFlake;

      systems = {
        x86-linux = "x86_64-linux";
        all-linux = [ "x86_64-linux" "aarch64-linux" ];
      };

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
          platform = systems.x86-linux;
        };

        # ISO
        Specter = {
          hostname = "Specter";
          username = "nixos";
          platform = systems.x86-linux;
        };
      };
    in mkFlake { inherit inputs; } {
      systems = systems.all-linux;

      flake = {
        nixosConfigurations = {
          ${hosts.Skadi.hostname} = mkHost hosts.Skadi;
          ${hosts.Specter.hostname} = mkIso hosts.Specter;
        };
      };

      perSystem = { pkgs, ... }: {
        checks.linterChecks = pkgs.stdenvNoCC.mkDerivation {
          name = "Linter Checks";
          src = ./.;
          doCheck = true;
          nativeBuildInputs = with pkgs; [ statix nixfmt-classic ];

          checkPhase = ''
            nixfmt -c .
            statix check
          '';

          # Shitty workaround
          installPhase = "mkdir $out";
        };

        devShells.default = pkgs.mkShellNoCC {
          nativeBuildInputs = with pkgs; [ statix nixfmt-classic fish ];
          shellHook = "exec fish";
        };

        formatter = with pkgs; nixfmt-classic;
        packages.arkWallpapers = pkgs.callPackage ./packages/arkWallpapers { };
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

    # Alternative to 'nix'
    lix = {
      url =
        "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Provides SecureBoot support
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # CachyOS kernel provider
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # For getting waydroid-scripts.
    nur.url = "github:nix-community/NUR";

    # Tiling wayland compositor
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # Widgets && bars
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
