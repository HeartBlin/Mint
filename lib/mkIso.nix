{ inputs, lib', self, withSystem }:

let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs.lib) nixosSystem;
in {
  mkIso = { hostname ? "nixos", username ? "nixos", system ? "x86_64-linux"
    , stateVersion ? "24.11", initialPassword ? "1234" }:
    withSystem system ({ inputs', ... }:
      let args = { inherit hostname inputs inputs' lib' self username; };
      in nixosSystem {
        specialArgs = args;
        modules = [
          # Module imports
          inputs.home-manager.nixosModules.home-manager
          inputs.agenix.nixosModules.default # Not that it gets any secrets tho ;)
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

          # Paths
          "${self}/hosts/${hostname}/config"
          "${self}/modules"

          # Options
          { nixpkgs.hostPlatform.system = system; }
          { system.stateVersion = stateVersion; }
          { networking.hostName = hostname; }
          { isoImage.squashfsCompression = "gzip -Xcompression-level 9"; }

          { # Create user
            users.users.${username} = {
              inherit initialPassword;
              isNormalUser = true;
              extraGroups = [ "wheel" "video" "networkmanager" ];
            };

            # Home-Manager setup
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;

              users.${username} = {
                imports = [
                  # Paths
                  "${self}/home/${username}/config.nix"
                  "${self}/home/modules"

                  # Options
                  { programs.home-manager.enable = true; }
                  { home.stateVersion = stateVersion; }
                ];
              };
            };
          }
        ];
      });
}
