{ inputs, moduleWithSystem, ... }:

{
  imports = [ inputs.pkgs-by-name.flakeModule ./lib ];
  perSystem = _: { pkgsDirectory = ./wallpapers; };

  flake.nixosModules = rec {
    default = mintWalls;
    mintWalls = moduleWithSystem (perSystem@{ config }:
      { config, lib, ... }:
      let
        inherit (lib) mkOption;
        inherit (lib.types) attrsOf enum path str;
        wallpapers = [
          "Abstract"
          "BetterSonoma"
          "Black"
          "Flow"
          "SteamAutumn"
          "SteamSpring"
          "SteamSummer"
        ];
      in {
        options.mintWalls = {
          wallpaper = mkOption {
            type = enum wallpapers;
            default = "Abstract";
            description = "The wallpaper in use";
          };

          wallpaperPkg = mkOption {
            type = path;
            default = perSystem.config.packages.${config.mintWalls.wallpaper};
            readOnly = true;
          };

          palette = mkOption {
            type = attrsOf str;
            default =
              import ./wallpapers/${config.mintWalls.wallpaper}/palette.nix;
            readOnly = true;
          };

          defaultPalette = mkOption {
            type = attrsOf str;
            readOnly = true;
            default = {
              borderBlue = "089AFF";
              borderViolet = "C26EFC";
              borderRed = "FA5B59";
              borderOrange = "FEA509";
            };
          };
        };
      });
  };
}
