{ inputs, withSystem, ... }:

let
  inherit (inputs.nixpkgs.lib) concatLists mkIf mkOption nixosSystem;
  inherit (inputs.nixpkgs.lib.types) enum;

  mkSystem = { hostname, username, prettyname ? username, role
    , system ? "x86_64-linux", flakedir ? "/home/${username}/Mint"
    , extraModules ? [ ], extraHMModules ? [ ], extraGroups ? [ ]
    , stateVersion ? "24.11", pfp ? true }:
    withSystem system ({ inputs', self', ... }:
      let
        # Modules that every system should have
        defaultModules = {
          nix = [
            inputs.home-manager.nixosModules.home-manager
            inputs.homix.nixosModules.default
          ];

          hm = [ ];
        };

        # Arguments every system should have
        args = {
          inherit hostname username prettyname role flakedir inputs inputs'
            self' system;
        };

        # Paths that get auto-imported
        paths = {
          nix = [
            ../../hosts/${hostname}/config.nix
            ../../hosts/${hostname}/hardware
            ../../modules
          ];
          hm = [ ../../hosts/${hostname}/user/config.nix ];
        };
      in nixosSystem {
        specialArgs = args;

        modules = concatLists [
          extraModules
          defaultModules.nix
          paths.nix
          [{
            # Define the role of the system
            options.Mint.role = mkOption {
              type = enum [ "laptop" "desktop" "server" "iso" ];
              readOnly = true;
              default = role;
            };

            # General system configuration
            config = {
              system.stateVersion = stateVersion;
              networking.hostName = hostname;

              # Set up the user
              users.users.${username} = {
                isNormalUser = true;
                description = prettyname;
                extraGroups = [ "wheel" ] ++ extraGroups;
                homix = true;
              };

              # Set up home-manager
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = args;

                users.${username}.imports = concatLists [
                  extraHMModules
                  paths.hm
                  [{
                    programs.home-manager.enable = true;
                    home.stateVersion = stateVersion;
                  }]
                ];
              };

              # Profile picture
              system.activationScripts.profilePicture = mkIf pfp {
                text = ''
                  mkdir -p /var/lib/AccountsService/{icons,users}
                  cp /home/${username}/Mint/hosts/${hostname}/user/pfp.png /var/lib/AccountsService/icons/${username}
                  echo -e "[User]\nIcon=/var/lib/AccountsService/icons/${username}\n" > /var/lib/AccountsService/users/${username}
                '';
              };
            };
          }]
        ];
      });
in { flake.lib = { inherit mkSystem; }; }
