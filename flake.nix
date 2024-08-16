{
  description = "An unstable as f#@% flake-based NixOS configuration.";

  outputs = { self, flake-parts, ... }@inputs:
    let
      inherit (flake-parts.lib) mkFlake;

      linuxArch = "x86_64-linux";
      stateVersion = "24.11";
      mkHost = (import ./functions/hosts.nix {
        inherit inputs self stateVersion;
      }).mkHost;

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

      perSystem = { pkgs, ... }: { formatter = pkgs.nixfmt-classic; };
    };

  inputs = {
    # Official repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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

    # Make flakes pretty
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
}
