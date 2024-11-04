{ pkgs, ... }:

{
  mintWalls.wallpaper = "Flow";

  Mint = {
    gui = {
      hyprland = {
        enable = true;
        wallpapers = {
          "eDP-1".monitor = "eDP-1";
          "HDMI-A-1".monitor = "HDMI-A-1";
        };
      };

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
    };
  };
}
