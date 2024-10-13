{ config, inputs', lib, osConfig, pkgs, ... }:

let
  inherit (lib) getExe mkIf;
  inherit (osConfig.Mint) asus;

  ledDevice =
    if asus.enable then "asus::kbd_backlight" else "rgb:kbd_backlight";
  brightnessctl = getExe pkgs.brightnessctl;
  cfg = config.Mint.hyprland;
in {
  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      package = inputs'.hypridle.packages.hypridle;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock"; # No lock yet
          before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";

          after_sleep_cmd =
            "hyprctl dispatch dpms on && sleep 1 && ${brightnessctl} -r && ${brightnessctl} -rd ${ledDevice}";
        };

        listener = [
          {
            timeout = 60;
            on-timeout = "${brightnessctl} -sd ${ledDevice} set 0";
            on-resume = "${brightnessctl} -rd ${ledDevice}";
          }

          {
            timeout = 240;
            on-timeout = "${brightnessctl} -s set 10";
            on-resume = "${brightnessctl} -r";
          }

          {
            timeout = 300;
            on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
          }

          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }

          {
            timeout = 600;
            on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
      };
    };
  };
}
