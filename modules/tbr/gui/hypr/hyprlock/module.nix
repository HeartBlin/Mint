{ config, inputs', lib, pkgs, self, username, ... }:

let
  inherit (lib) getExe mkEnableOption mkIf;
  inherit (config.mintWalls) wallpaperPkg;
  inherit (self.lib) toHyprRGB;
  inherit (config.users.users.${username}) description;

  cfg = config.Mint.gui.hyprland;

  colors = {
    error = toHyprRGB config.mintWalls.palette.error;
    onSurface = toHyprRGB config.mintWalls.palette.onSurface;
    primary = toHyprRGB config.mintWalls.palette.primary;
    primary' = config.mintWalls.palette.primary;
    surface = toHyprRGB config.mintWalls.palette.surface;
    tertiary = toHyprRGB config.mintWalls.palette.tertiary;
  };

  time-hl = pkgs.writeShellScriptBin "time-hl" ''
    current_hour=$(date +"%H")
    user_string="<span color='#${colors.primary'}'>${description}</span>"

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

  config' = ''
    background {
      monitor=HDMI-A-1
      blur_passes=2
      brightness=0.700000
      contrast=0.900000
      path=${wallpaperPkg}
      vibrancy=0.170000
      vibrancy_darkness=0
    }

    background {
      monitor=eDP-1
      blur_passes=2
      brightness=0.700000
      contrast=0.900000
      path=${wallpaperPkg}
      vibrancy=0.170000
      vibrancy_darkness=0
    }

    general {
      disable_loading_bar=true
      hide_cursor=true
    }

    input-field {
      monitor=eDP-1
      size=300, 40
      dots_center=true
      dots_size=0.200000
      dots_spacing=0.200000
      fade_on_empty=true
      font_color=${colors.onSurface}
      halign=center
      hide_input=false
      inner_color=${colors.surface}
      outer_color=${colors.surface}
      outline_thickness=2
      placeholder_text=
      position=0, 150
      valign=bottom
    }

    label {
      monitor=
      color=${colors.primary}
      font_family=JetBrains Mono Bold
      font_size=180
      halign=center
      position=0, 150
      text=cmd[update:1000] echo -e "$(date +"%H")"
      valign=center
    }

    label {
      monitor=
      color=${colors.onSurface}
      font_family=JetBrains Mono Bold
      font_size=180
      halign=center
      position=0, -75
      text=cmd[update:1000] echo -e "$(date +"%M")"
      valign=center
    }

    label {
      monitor=
      color=${colors.onSurface}
      font_family=JetBrains Mono Bold
      halign=left
      position=70, -70
      text=cmd[update:1000] echo -e "$(date +"%A, %b %d")"
      valign=top
    }

    label {
      monitor=
      color=${colors.onSurface}
      font_family=JetBrains Mono Bold
      halign=left
      position=70, -100
      text=cmd[update:1000] bash ${getExe time-hl}
      valign=top
    }
  '';
in {
  options.Mint.gui.hyprland.enable = mkEnableOption "Enable Hyprland";

  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      package = inputs'.hyprlock.packages.hyprlock;
    };

    environment.systemPackages = [ pkgs.jetbrains-mono time-hl ];
    homix.".config/hypr/hyprlock.conf".text = config';
  };
}
