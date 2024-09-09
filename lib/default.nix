{ inputs, self, libx, withSystem }:

let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  mkSystem =
    { hostname ? "nixos", system ? "x86_64-linux", stateVersion ? "24.11" }:
    withSystem system ({ inputs, ... }:
      nixosSystem {
        specialArgs = { inherit inputs libx; };
        modules = [
          # Paths
          "${self}/hosts/${hostname}/system.nix"

          # Options
          { nixpkgs.hostPlatform.system = system; }
          { system.stateVersion = stateVersion; }
          { networking.hostName = hostname; }
        ];
      });
in { inherit mkSystem; }
