{ config, osConfig, inputs, inputs', lib, pkgs, prettyname, ... }:

let
  inherit (lib) attrValues getExe;
  inherit (config.Mint.gui.hyprland) wallpapers;
  inherit (inputs.mintwalls.lib) toHyprRGB;

  colors = {
    error = toHyprRGB osConfig.mintWalls.palette.error;
    onSurface = toHyprRGB osConfig.mintWalls.palette.onSurface;
    primary = toHyprRGB osConfig.mintWalls.palette.primary;
    primary' = osConfig.mintWalls.palette.primary;
    surface = toHyprRGB osConfig.mintWalls.palette.surface;
    tertiary = toHyprRGB osConfig.mintWalls.palette.tertiary;
  };

  time-hl = pkgs.writeShellScriptBin "time-hl" ''
    current_hour=$(date +"%H")
    user_string="<span color='#${colors.primary'}'>${prettyname}</span>"

    if [ "$current_hour" -ge 5 ] && [ "$current_hour" -lt 12 ]; then
      echo "Good morning, $user_string"
    elif [ "$current_hour" -ge 12 ] && [ "$current_hour" -lt 18 ]; then
      echo "Good day, $user_string"
    elif [ "$current_hour" -ge 18 ] && [ "$current_hour" -lt 22 ]; then
      echo "Good evening, $user_string"
    else
      echo "Good night, $user_string"
    fi
  '';

  backgrounds = map (wallpaper: {
    inherit (wallpaper) monitor path;
    blur_passes = 2;
    contrast = 0.9;
    brightness = 0.7;
    vibrancy = 0.17;
    vibrancy_darkness = 0;
  }) (attrValues wallpapers);

  cfg = config.Mint.gui.hyprland;
in {
  programs.hyprlock = {
    inherit (cfg) enable;
    package = inputs'.hyprlock.packages.hyprlock;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = backgrounds;

      input-field = [{
        monitor = "eDP-1";
        size = "300, 40";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "${colors.surface}";
        inner_color = "${colors.surface}";
        font_color = "${colors.onSurface}";
        #check_color = "${colors.tertiary}";
        #fail_color = "${colors.error}";
        fade_on_empty = true;
        placeholder_text = "";
        hide_input = false;
        position = "0, 150";
        halign = "center";
        valign = "bottom";
      }];

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%H")"'';
          color = "${colors.primary}";
          font_family = "JetBrains Mono Bold";
          font_size = 180;
          position = "0, 150";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%M")"'';
          color = "${colors.onSurface}";
          font_family = "JetBrains Mono Bold";
          font_size = 180;
          position = "0, -75";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %b %d")"'';
          color = "${colors.onSurface}";
          font_family = "JetBrains Mono Bold";
          position = "70, -70";
          halign = "left";
          valign = "top";
        }
        {
          monitor = "";
          text = "cmd[update:1000] bash ${getExe time-hl}";
          color = "${colors.onSurface}";
          font_family = "JetBrains Mono Bold";
          position = "70, -100";
          halign = "left";
          valign = "top";
        }
      ];
    };
  };

  home.packages = if cfg.enable then [ pkgs.jetbrains-mono ] else [ ];

}
