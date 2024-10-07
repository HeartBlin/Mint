{ inputs, self, withSystem, ... }:

let
  inherit (inputs.nixpkgs) lib;

  libx = import "${self}/lib" { inherit inputs lib libx self withSystem; };
in {
  flake.nixosConfigurations = {
    Skadi = libx.mkSystem {
      hostName = "Skadi";
      userName = "heartblin";
      prettyName = "HeartBlin";
    };
  };
}
