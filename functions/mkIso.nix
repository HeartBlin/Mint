{ inputs, self, stateVersion }:

let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  hostConfig = "${self}/hosts";
  hostModules = "${self}/modules";

  homeConfig = "${self}/home/users";
  homeModules = "${self}/home/modules";
in {
  mkIso =
    { hostname ? "nixos", username ? "heartblin", platform ? "x86_64-linux" }:
    let
      inherit (inputs) nixpkgs;

      sharedArgs = {
        inherit hostname inputs self stateVersion username platform;
      };
    in nixosSystem {
      specialArgs = sharedArgs;

      modules = [
        # ISO module
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

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
