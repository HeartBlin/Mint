{ config, pkgs, ... }:

{
  mintWalls.wallpaper = "Flow";

  Mint = {
    ags.enable = true;
    chrome.enable = true;
    cli = {
      foot.enable = true;
      shell = "fish";
    };

    discord.enable = true;
    hyprland = {
      enable = true;

      wallpapers = {
        "eDP-1" = {
          monitor = "eDP-1";
          path = "${config.mintWalls.wallpaperPkg}";
        };
        "HDMI-A-1" = {
          monitor = "HDMI-A-1";
          path = "${config.mintWalls.wallpaperPkg}";
        };
      };
    };

    mangohud.enable = true;
    mpv.enable = true;
    theme = {
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      icons = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      gtk = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };

    vscode.enable = true;
  };
}
