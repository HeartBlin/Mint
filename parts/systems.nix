{ inputs, self, ... }:

let
  commonModules = {
    nix = [
      inputs.chaotic.nixosModules.default
      inputs.disko.nixosModules.disko
      inputs.lanzaboote.nixosModules.lanzaboote
    ];

    hm = [ inputs.mintwalls.homeManagerModules.mintWalls ];
  };
in {
  flake.nixosConfigurations = {
    Skadi = self.lib.mkSystem {
      hostname = "Skadi";
      username = "heartblin";
      prettyname = "HeartBlin";
      role = "laptop";
      extraModules = commonModules.nix;
      extraHMModules = commonModules.hm;
      extraGroups = [ "networkmanager" ];
    };
  };
}
