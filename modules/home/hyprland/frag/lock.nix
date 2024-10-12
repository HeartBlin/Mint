{ config, inputs', lib, pkgs, prettyName, ... }:

let
  inherit (lib) attrValues getExe mkIf;
  inherit (config.Ark.hyprland) wallpapers;

  time-hl = pkgs.writeShellScriptBin "time-hl" ''
    current_hour=$(date +"%H")
    user_string="<span color='#BBC3FF'>${prettyName}</span>"

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
          outer_color = "rgb(121318)";
          inner_color = "rgb(121318)";
          font_color = "rgb(E4E1E9)";
          check_color = "rgb(121318)";
          fail_color = "rgb(FFB4AB)";
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
            color = "rgb(BBC3FF)";
            font_family = "JetBrains Mono Bold";
            font_size = 180;
            position = "0, 150";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] echo -e "$(date +"%M")"'';
            color = "rgb(E4E1E9)";
            font_family = "JetBrains Mono Bold";
            font_size = 180;
            position = "0, -75";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] echo -e "$(date +"%A, %b %d")"'';
            color = "rgb(E4E1E9)";
            font_family = "JetBrains Mono Bold";
            position = "70, -70";
            halign = "left";
            valign = "top";
          }
          {
            monitor = "";
            text = "cmd[update:1000] bash ${getExe time-hl}";
            color = "rgb(E4E1E9)";
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
