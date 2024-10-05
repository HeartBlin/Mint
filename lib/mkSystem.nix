{ inputs, libx, self, withSystem }:

{
  mkSystem =
    { hostName, userName, system ? "x86_64-linux", stateVersion ? "24.11" }:
    withSystem system ({ inputs', ... }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit hostName inputs inputs' libx self userName; };

        modules = [
          # Module imports
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.default

          # Paths
          "${self}/hosts/${hostName}/config.nix"
          "${self}/hosts/${hostName}/hardware"
          "${self}/modules"

          # Options
          { nixpkgs.hostPlatform.system = system; }
          { system.stateVersion = stateVersion; }
          { networking.hostName = hostName; }
          {
            users.users."${userName}" = {
              isNormalUser = true;
              initialPassword = "changeme";
              extraGroups = [ "wheel" ];
            };

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit hostName inputs inputs' libx self userName;
              };

              users.${userName} = {
                imports = [
                  # Paths
                  "${self}/hosts/${hostName}/user/config.nix"

                  # Options
                  { programs.home-manager.enable = true; }
                  { home.stateVersion = stateVersion; }
                ];
              };
            };
          }
          {
            options.Ark.flakeDir = let
              inherit (inputs.nixpkgs.lib) mkOption;
              inherit (inputs.nixpkgs.lib.types) nullOr str;
            in mkOption {
              type = nullOr str;
              default = "/home/${userName}/Ark";
            };
          }
        ];
      });
}
