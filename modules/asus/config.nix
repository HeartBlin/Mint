{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.Ark.asus;
in {
  config = mkIf cfg.enable {
    services = {
      supergfxd.enable = true;
      asusd = {
        enable = true;
        enableUserService = true;
      };
    };

    systemd.services.supergfxd.path = [pkgs.pciutils];
  };
}
