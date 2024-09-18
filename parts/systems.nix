{ inputs, self, withSystem, ... }:

let
  inherit (inputs.nixpkgs) lib;
  lib' = import ../lib { inherit inputs lib lib' self withSystem; };
in {
  flake.nixosConfigurations = {
    Skadi = lib'.mkSystem {
      hostname = "Skadi";
      username = "heartblin";
      system = "x86_64-linux";
    };
  };
}
