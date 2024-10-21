{ inputs, libx, self, withSystem }:

{
  mkSystem = { hostName, userName, prettyName ? "", role
    , system ? "x86_64-linux", stateVersion ? "24.11"
    , timeZone ? "Europe/Bucharest", flakeDir ? "/home/${userName}/Mint" }:
    withSystem system ({ inputs', self', ... }:
      let
        inherit (inputs.nixpkgs.lib) nixosSystem;
        inherit (inputs.nixpkgs.lib) mkOption;
        inherit (inputs.nixpkgs.lib.types) enum nullOr str;

        commonArgs = {
          inherit hostName inputs inputs' libx prettyName self self' userName;
        };

        allArgs = {
          inherit enum mkOption role hostName system stateVersion timeZone
            commonArgs inputs prettyName self userName flakeDir nullOr str;
        };

        inputModules = with inputs; [
          chaotic.nixosModules.default
          disko.nixosModules.disko
          home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          lix.nixosModules.default
        ];

        pathModules = [
          "${self}/hosts/${hostName}/config.nix"
          "${self}/hosts/${hostName}/hardware"
          "${self}/modules"
        ];

      in nixosSystem {
        specialArgs = commonArgs;

        modules = inputModules ++ pathModules ++ [
          (import ./role.nix allArgs) # Define roles
          (import ./system.nix allArgs) # Define system config
          (import ./user.nix allArgs) # Define a user
          (import ./flakeDir.nix allArgs) # Define the location of the flake
        ];
      });
}
