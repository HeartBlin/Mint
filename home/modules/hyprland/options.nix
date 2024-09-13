{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) attrsOf int package str submodule;

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
    theme = {
      cursor = {
        package = mkOption {
          type = package;
          description = "The package that contains the cursor";
          default = pkgs.bibata-cursors;
        };

        size = mkOption {
          type = int;
          description = "The size of the cursor";
          default = 16;
        };

        name = mkOption {
          type = str;
          description = "The name of the cursor";
          default = "Bibata-Modern-Ice";
        };
      };

      icons = {
        name = mkOption {
          type = str;
          description = "The name of the icon theme";
          default = "Adwaita";
        };

        package = mkOption {
          type = package;
          description = "The package that contains the icons";
          default = pkgs.adwaita-icon-theme;
        };
      };

      gtk = {
        name = mkOption {
          type = str;
          description = "The name of the gtk theme";
          default = "adw-gtk3-dark";
        };

        package = mkOption {
          type = package;
          description = "The package that contains the gtk theme";
          default = pkgs.adw-gtk3;
        };
      };
    };
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
