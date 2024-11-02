{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.Mint.system.asus;
in {
  options.Mint.system.asus.enable = mkEnableOption "Enables asusd & supergfxd";

  config = mkIf cfg.enable {
    services = {
      supergfxd = { inherit (cfg) enable; };
      asusd = {
        inherit (cfg) enable;
        enableUserService = true;
      };
    };

    systemd.services.supergfxd.path = [ pkgs.pciutils ];
  };
}
