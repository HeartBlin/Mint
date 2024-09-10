{
  inputs,
  self,
  lib',
  withSystem,
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  mkSystem = {
    hostname ? "nixos",
    username ? "user",
    system ? "x86_64-linux",
    stateVersion ? "24.11",
  }:
    withSystem system ({inputs', ...}: let
      args = {inherit hostname inputs inputs' lib' self username;};
    in
      nixosSystem {
        specialArgs = args;
        modules = [
          # Module imports
          inputs.home-manager.nixosModules.home-manager
          inputs.agenix.nixosModules.default

          # Paths
          "${self}/hosts/${hostname}/config"
          "${self}/hosts/${hostname}/hardware"
          "${self}/modules"

          # Options
          {nixpkgs.hostPlatform.system = system;}
          {system.stateVersion = stateVersion;}
          {networking.hostName = hostname;}
          {environment.systemPackages = [inputs'.agenix.packages.default];}
          {age.identityPaths = ["/home/heartblin/.ssh/HeartBlin"];}

          {
            # Create user
            users.users."${username}" = {
              isNormalUser = true;
              extraGroups = ["wheel" "video" "networkmanager"];
            };

            # Home-Manager setup
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;

              users.${username} = {
                imports = [
                  # Modules
                  inputs.agenix.homeManagerModules.default

                  # Paths
                  "${self}/home/${username}/config.nix"
                  "${self}/home/modules"

                  # Options
                  {programs.home-manager.enable = true;}
                  {home.stateVersion = stateVersion;}
                ];
              };
            };
          }
        ];
      });

  importModule = path: module: [
    "${self}/${path}/${module}/config.nix"
    "${self}/${path}/${module}/options.nix"
  ];

  mkIfElse = let
    inherit (inputs.nixpkgs.lib) mkIf mkMerge;
  in
    x: y: n:
      mkMerge [
        (mkIf x y)
        (mkIf (!x) n)
      ];
in {inherit mkSystem importModule mkIfElse;}
