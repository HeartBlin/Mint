{ config, lib, osConfig, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.hyprland;
  greeter = osConfig.Ark.greeter.customGreeter;
in {
  config = mkIf (cfg.enable && greeter.enable) {
    programs.bash = {
      enable = true;
      profileExtra = ''
        if [[ "$(tty)" = "/dev/tty1" ]]; then
          show_cursor() {
            tput cnorm
            exit
          }
          hide_cursor() {
            tput civis
          }

          trap show_cursor INT TERM
          hide_cursor

          clear
          echo -e "Starting\033[1;34m Hyprland"
        	Hyprland 2>&1 >/dev/null

          show_cursor
        fi
      '';
    };
  };
}
