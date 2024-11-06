{ config, inputs', lib, pkgs, self, ... }:

let
  inherit (lib) mkIf;
  inherit (config.mintWalls) wallpaperPkg;
  inherit (self.lib) toHyprRGB;

  cfg = config.Mint.gui.hyprland;

  colors = {
    error = toHyprRGB config.mintWalls.palette.error;
    onSurface = toHyprRGB config.mintWalls.palette.onSurface;
    primary = toHyprRGB config.mintWalls.palette.primary;
    primary' = config.mintWalls.palette.primary;
    surface = toHyprRGB config.mintWalls.palette.surface;
    tertiary = toHyprRGB config.mintWalls.palette.tertiary;
  };

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
  '';
in {
  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      package = inputs'.hyprlock.packages.hyprlock;
    };

    environment.systemPackages = [ pkgs.jetbrains-mono ];
    homix.".config/hypr/hyprlock.conf".text = config';
  };
}
