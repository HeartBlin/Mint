{ config, pkgs, ... }:

let cfg = config.Mint.asus;
in {
  services = {
    supergfxd = { inherit (cfg) enable; };
    asusd = {
      inherit (cfg) enable;
      enableUserService = true;
    };
  };

  systemd.services.supergfxd.path = [ pkgs.pciutils ];
}
