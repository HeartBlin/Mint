{ inputs, self, withSystem, ... }:

let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  mkSystem = { hostname, username, prettyname, role, flakedir, system }:
    withSystem system ({ inputs', self', ... }:
      let
        args = {
          inherit hostname username prettyname role flakedir inputs inputs' self
            self' system;
        };
      in nixosSystem {
        specialArgs = args;
        modules = [
          # From flakes
          inputs.chaotic.nixosModules.default
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          inputs.homix.nixosModules.default
          inputs.lanzaboote.nixosModules.lanzaboote
          self.nixosModules.mintWalls

          # Paths
          "${self}/hosts/${hostname}/config.nix"
          "${self}/hosts/${hostname}/hardware"
          "${self}/modules"

          { # TODO: Deprecate HM
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;

              users.${username}.imports = [
                "${self}/hosts/${hostname}/user/config.nix"
                {
                  programs.home-manager.enable = true;
                  home.stateVersion = "24.11";
                }
              ];
            };
          }
        ];
      });
in {
  flake.nixosConfigurations = {
    Skadi = mkSystem rec {
      hostname = "Skadi";
      flakedir = "/home/${username}/Mint";
      username = "heartblin";
      prettyname = "HeartBlin";
      role = "laptop";
      system = "x86_64-linux";
    };
  };
}
