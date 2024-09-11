{
  config,
  hostname,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.Ark.gdm;
in {
  config = mkIf cfg.enable {
    services.xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
      banner = ''
        ${hostname} on NixOS, using Ark dotfiles
      '';
    };
  };
}
