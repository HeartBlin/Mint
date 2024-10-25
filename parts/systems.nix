{ inputs, self, withSystem, ... }:

let libx = import "${self}/lib" { inherit inputs libx self withSystem; };
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
