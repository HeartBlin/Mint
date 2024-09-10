{lib, ...}: let
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
      };
    };
  });
in {
  options.Ark.hyprland = {
    enable = mkEnableOption "Enable Hyprland";
    wallpapers = mkOption {
      type = wallpaperOption;
      description = "Wallpaper config for multiple monitors";
      default = {
        "eDP-1" = {
          monitor = "eDP-1";
          path = "";
        };
      };
    };
  };
}
