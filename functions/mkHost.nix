{ inputs, self, stateVersion }:

let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  hostConfig = "${self}/hosts";
  hostModules = "${self}/modules";

  homeConfig = "${self}/home/users";
  homeModules = "${self}/home/modules";
in {
  mkHost =
    { hostname ? "nixos", username ? "heartblin", platform ? "x86_64-linux" }:
    let
      sharedArgs = {
        inherit hostname inputs self stateVersion username platform;
      };
    in nixosSystem {
      specialArgs = sharedArgs;

      modules = [
        # Paths for the hosts
        "${hostConfig}/${hostname}"
        "${hostModules}"

        # Set hostname && stateVersion && hostPlatform
        {
          networking.hostName = "${hostname}";
          nixpkgs.hostPlatform = "${platform}";
          system.stateVersion = "${stateVersion}";
        }

        # Home-Manager import
        inputs.home-manager.nixosModules.home-manager

        # Set username && home-manager configuration
        {
          users.users."${username}" = {
            isNormalUser = true;
            extraGroups = [ "wheel" "video" "networking" ];
          };

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = sharedArgs;

            users."${username}" = {
              imports = [
                "${homeConfig}/${username}" # User config
                "${homeModules}" # User Modules
              ];

              programs.home-manager.enable = true;
              home.stateVersion = "${stateVersion}";
            };
          };
        }
      ];
    };
}
