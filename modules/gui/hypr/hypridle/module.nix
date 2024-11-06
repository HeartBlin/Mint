{ config, inputs', lib, pkgs, ... }:

let
  inherit (lib) getExe mkIf;
  inherit (config.Mint.system) asus;

  ledDevice =
    if asus.enable then "asus::kbd_backlight" else "rgb:kbd_backlight";
  brightnessctl = getExe pkgs.brightnessctl;
  cfg = config.Mint.gui.hyprland;

  config' = ''
    general {
      after_sleep_cmd=hyprctl dispatch dpms on && sleep 1 && ${brightnessctl} -r && ${brightnessctl} -rd ${ledDevice}
      before_sleep_cmd=${pkgs.systemd}/bin/loginctl lock-session
      lock_cmd=pidof hyprlock || hyprlock
    }

    listener {
      on-resume=${brightnessctl} -rd ${ledDevice}
      on-timeout=${brightnessctl} -sd ${ledDevice} set 0
      timeout=60
    }

    listener {
      on-resume=${brightnessctl} -r
      on-timeout=${brightnessctl} -s set 10
      timeout=240
    }

    listener {
      on-timeout=${pkgs.systemd}/bin/loginctl lock-session
      timeout=300
    }

    listener {
      on-resume=hyprctl dispatch dpms on
      on-timeout=hyprctl dispatch dpms off
      timeout=330
    }

    listener {
      on-timeout=${pkgs.systemd}/bin/systemctl suspend
      timeout=600
    }
  '';
in {
  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      package = inputs'.hypridle.packages.hypridle;
    };

    homix.".config/hypr/hypridle.conf".text = config';
  };
}
