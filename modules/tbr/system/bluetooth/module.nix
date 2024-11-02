{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.Mint.system.bluetooth;
in {
  options.Mint.system.bluetooth.enable = mkEnableOption "Enable Bluetooth";

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
      powerOnBoot = true;
    };

    systemd.user.services.mpris-proxy = {
      enable = true;
      description = "Mpris proxy";
      after = [ "network.target" "sound.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };

    services.blueman.enable = true;
  };
}
