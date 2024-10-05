{ pkgs, self, ... }:

let wallpaper = "${self.packages.${pkgs.system}.wallpapers}/share/wallpapers";
in {
  Ark = {
    chrome.enable = true;
    cli = {
      foot.enable = true;
      shell = "fish";
    };

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
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
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

    mangohud.enable = true;
    vscode.enable = true;
  };
}
