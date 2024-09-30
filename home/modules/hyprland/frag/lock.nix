{ config, lib, lib', self, ... }:

let
  inherit (lib) mkIf;
  inherit (lib'.colors) pallete toHypr;

  c = {
    blue = toHypr pallete.bBlue;
    violet = toHypr pallete.bViolet;
    red = toHypr pallete.bRed;
    orange = toHypr pallete.bOrange;
  };

  cfg = config.Ark.hyprland;
in {
  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          no_fade_in = true;
        };

        background = [{
          monitor = "";
          color = "rgb(000000)";
        }];

        input-field = [{
          monitor = "eDP-1";
          size = "300, 50";
          outline_thickness = 3;
          dots_center = true;
          outer_color = c.blue;
          inner_color = "rgb(000000)";
          font_color = "rgb(FFFFFF)";
          fade_on_empty = true;
          hide_input = false;
          check_color = c.violet;
          fail_color = c.red;
          capslock_color = c.orange;
          numlock_color = c.orange;
          bothlock_color = c.orange;
          rounding = 10;
          position = "0, 100";
          valign = "bottom";
          placeholder_text = "";
          fail_text = "";
        }];

        image = [{
          monitor = "";
          path = "${self}/home/modules/hyprland/frag/lock.png";

          border_size = 0;

          valign = "bottom";
          position = "0, 200";
        }];
      };
    };
  };
}
