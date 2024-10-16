{ config, pkgs, ... }:

let cfg = config.Mint.bluetooth;
in {
  hardware.bluetooth = {
    inherit (cfg) enable;
    package = pkgs.bluez5-experimental;
    powerOnBoot = true;
  };

  systemd.user.services.mpris-proxy = {
    inherit (cfg) enable;
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  services.blueman = { inherit (cfg) enable; };
}
