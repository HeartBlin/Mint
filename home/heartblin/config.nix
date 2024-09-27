{ pkgs, self, ... }:

let wallpaper = "${self.packages.${pkgs.system}.arkWalls}/share/wallpapers";
in {
  Ark = {
    browsers = {
      chromium.enable = true;
      zen.enable = true;
    };

    discord.enable = true;
    hyprland = {
      enable = true;
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
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };
      };

      wallpapers = {
        "eDP-1" = {
          monitor = "eDP-1";
          path = "${wallpaper}/TheTowerCropped.png";
        };
        "HDMI-A-1" = {
          monitor = "HDMI-A-1";
          path = "${wallpaper}/TheTowerCropped.png";
        };
      };
    };

    obsidian.enable = true;
    terminal = {
      foot.enable = true;
      shell = "fish";
    };

    vscode.enable = true;
  };
}
