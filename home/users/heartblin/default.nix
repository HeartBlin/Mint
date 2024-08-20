{ osConfig, pkgs, self, ... }:

let
  hyprland = osConfig.Ark.hyprland.enable;
  wallpaper = "${self.packages.${pkgs.system}.arkWallpapers}/share/wallpapers";
in {
  config.Ark = {
    chromium.enable = true;
    element.enable = false;
    git = {
      enable = true;
      username = "HeartBlin";
      email = "161874560+HeartBlin@users.noreply.github.com";
      authKey = "/home/heartblin/.ssh/GithubAuth";
      signing = {
        enable = true;
        signKey = "/home/heartblin/.ssh/GithubSign.pub";
      };
    };

    hyprland = {
      enable = hyprland;
      wallpapers = {
        "eDP-1" = {
          monitor = "eDP-1";
          path = "${wallpaper}/Bloom-Dark.jpg";
        };
        "HDMI-A-1" = {
          monitor = "HDMI-A-1";
          path = "${wallpaper}/Bloom-Dark.jpg";
        };
      };
    };

    mangohud.enable = true;
    terminal = {
      foot.enable = true;
      shell = "fish";
    };

    vscode.enable = true;
  };
}
