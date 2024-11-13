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
    homix.".config/hypr/hypridle.conf".text = config';
    services.hypridle = {
      enable = true;
      package = inputs'.hypridle.packages.hypridle;
    };

    systemd.user.services.power-handler = {
      description = "Handle power source changes for hypridle";
      wantedBy = [ "default.target" ];

      serviceConfig = {
        Type = "simple";
        RemainAfterExit = "yes";
        ExecStart = pkgs.writeShellScript "check-power" ''
          while true; do
            adp0_online=$(cat /sys/class/power_supply/ADP0/online)
            usbc_online=$(cat /sys/class/power_supply/ucsi-source-psy-USBC000:001/online)

            if [ "$adp0_online" = "1" ] || [ "$usbc_online" = "1" ]; then
              systemctl --user stop hypridle
            else
              systemctl --user start hypridle
            fi
            sleep 2
          done
        '';
        Restart = "always";
        RestartSec = "5s";
      };
    };
  };
}
