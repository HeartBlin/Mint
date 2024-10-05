{ inputs, libx, self, withSystem }:

{
  mkSystem = { hostName, userName, prettyName ? "", system ? "x86_64-linux"
    , stateVersion ? "24.11" }:
    withSystem system ({ inputs', ... }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit hostName inputs inputs' libx self userName; };

        modules = [
          # Module imports
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.default
          inputs.lanzaboote.nixosModules.lanzaboote

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
              description = prettyName;
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

          # Inform the system where the flake is
          {
            options.Ark.flakeDir = let
              inherit (inputs.nixpkgs.lib) mkOption;
              inherit (inputs.nixpkgs.lib.types) nullOr str;
            in mkOption {
              type = nullOr str;
              default = "/home/${userName}/Ark";
            };
          }

          # Set pfp
          {
            system.activationScripts.profilePicture.text = ''
              mkdir -p /var/lib/AccountsService/{icons,users}
              cp /home/${userName}/Ark/hosts/${hostName}/user/pfp.png /var/lib/AccountsService/icons/${userName}
              echo -e "[User]\nIcon=/var/lib/AccountsService/icons/${userName}\n" > /var/lib/AccountsService/users/${userName}
            '';
          }
        ];
      });
}
