{ inputs, self, withSystem, ... }:

let lib' = import ../lib { inherit inputs lib' self withSystem; };
in {
  flake.nixosConfigurations = {
    Skadi = lib'.mkSystem {
      hostname = "Skadi";
      system = "x86_64-linux";
    };
  };
}