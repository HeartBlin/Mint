{ config, lib, ... }:

let
  inherit (lib) mkIf;
  cfg = config.Ark.greeter.customGreeter;
in {
  config = mkIf cfg.enable {
    services.xserver.displayManager.lightdm.enable = false;
    environment.etc."issue" = {
      enable = true;
      # NFO-ass logo
      text = ''
        \e{cyan} ███▄    █  ██▓▒██   ██▒ ▒█████    ██████ \e{reset}
        \e{cyan} ██ ▀█   █ ▓██▒▒▒ █ █ ▒░▒██▒  ██▒▒██    ▒ \e{reset}
        \e{cyan}▓██  ▀█ ██▒▒██▒░░  █   ░▒██░  ██▒░ ▓██▄   \e{reset}
        \e{cyan}▓██▒  ▐▌██▒░██░ ░ █ █ ▒ ▒██   ██░  ▒   ██▒\e{reset}
        \e{cyan}▒██░   ▓██░░██░▒██▒ ▒██▒░ ████▓▒░▒██████▒▒\e{reset}
        \e{cyan}░ ▒░   ▒ ▒ ░▓  ▒▒ ░ ░▓ ░░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░\e{reset}
        \e{cyan}░ ░░   ░ ▒░ ▒ ░░░   ░▒ ░  ░ ▒ ▒░ ░ ░▒  ░ ░\e{reset}
        \e{cyan}   ░   ░ ░  ▒ ░ ░    ░  ░ ░ ░ ▒  ░  ░  ░  \e{reset}
        \e{cyan}         ░  ░   ░    ░      ░ ░        ░  \e{reset}
        \e{cyan}                                          \e{reset}
        \e{cyan}       -- Now on Version 24.11 --         \e{reset}

        Time     - \t
        Date     - \d
        HostName - \n on \l

      '';
    };
  };
}
