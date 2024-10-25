{ inputs, self, withSystem, ... }:

let
  inherit (inputs.nixpkgs) lib;

  libx = import "${self}/lib" { inherit inputs lib libx self withSystem; };
in {
  flake.nixosConfigurations = {
    Skadi = libx.mkSystem rec {
      flakeDir = "/home/${userName}/Mint";
      hostName = "Skadi";
      prettyName = "HeartBlin";
      role = "laptop";
      timeZone = "Europe/Bucharest";
      userName = "heartblin";
    };
  };
}
