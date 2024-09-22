{ inputs, self, withSystem, ... }:

let
  inherit (inputs.nixpkgs) lib;
  inherit (lib') mkIso mkSystem;
  lib' = import ../lib { inherit inputs lib lib' self withSystem; };
in {
  flake.nixosConfigurations = {
    Skadi = mkSystem {
      hostname = "Skadi";
      username = "heartblin";
      system = "x86_64-linux";
      stateVersion = "24.11";
    };

    Specter = mkIso {
      hostname = "Specter";
      username = "liveuser";
      system = "x86_64-linux";
      stateVersion = "24.11";
      initialPassword = "changeme";
    };
  };
}
