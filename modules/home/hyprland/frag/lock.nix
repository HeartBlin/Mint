{ config, inputs', lib, libx, pkgs, prettyName, ... }:

let
  inherit (lib) attrValues getExe mkIf;
  inherit (config.Ark.hyprland) wallpapers;
  inherit (libx.colors) toHypr;

  colors = {
    error = toHypr config.mintWalls.palette.error;
    onSurface = toHypr config.mintWalls.palette.onSurface;
    primary = toHypr config.mintWalls.palette.primary;
    primary' = config.mintWalls.palette.primary;
    surface = toHypr config.mintWalls.palette.surface;
    tertiary = toHypr config.mintWalls.palette.tertiary;
  };

  time-hl = pkgs.writeShellScriptBin "time-hl" ''
    current_hour=$(date +"%H")
    user_string="<span color='#${colors.primary'}'>${prettyName}</span>"

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

  cfg = config.Ark.hyprland;
in {
  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
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

    home.packages = [ pkgs.jetbrains-mono ];
  };
}
