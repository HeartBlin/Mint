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
      args = {inherit inputs inputs' lib';};
    in
      nixosSystem {
        specialArgs = args;
        modules = [
          # Module imports
          inputs.home-manager.nixosModules.home-manager

          # Paths
          "${self}/hosts/${hostname}/config"
          "${self}/hosts/${hostname}/hardware"
          "${self}/modules"

          # Options
          {nixpkgs.hostPlatform.system = system;}
          {system.stateVersion = stateVersion;}
          {networking.hostName = hostname;}

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
