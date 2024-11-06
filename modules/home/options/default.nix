{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) attrsOf str submodule;

  wallpaperOption = attrsOf (submodule {
    options = {
      monitor = mkOption {
        type = str;
        description = "Monitor to apply the wallpaper to";
      };

      path = mkOption {
        type = str;
        description = "Path to the image";
        default = "${config.mintWalls.wallpaperPkg}";
      };
    };
  });
in {
  options.Mint = {
    gui = {
      hyprland = {
        enable = mkEnableOption "Enable Hyprland";
        wallpapers = mkOption {
          type = wallpaperOption;
          description = "Wallpaper config for multiple monitors";
        };
      };
    };
  };
}
