{ inputs, self, withSystem, ... }:

let libx = import ../lib { inherit inputs libx self withSystem; };
in {
  flake.nixosConfigurations = {
    Skadi = libx.mkSystem {
      hostname = "Skadi";
      system = "x86_64-linux";
    };
  };
}
