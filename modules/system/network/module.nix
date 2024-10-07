{ lib, ... }:

let inherit (lib) mkForce;
in {
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    useDHCP = mkForce true;
    wireless.enable = mkForce false;
  };

  services.resolved = {
    enable = true;
    fallbackDns = [
      # Quad9
      "9.9.9.9"
      "2620:fe::fe"
    ];
  };

  systemd.services.systemd-udev-settle.enable = mkForce false;
}
