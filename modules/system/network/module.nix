{ hostname, lib, ... }:

let inherit (lib) mkForce;
in {

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    useDHCP = mkForce true;
    wireless.enable = mkForce false;
  };

  systemd = {
    targets.network-online.wantedBy = mkForce [ ];
    services = {
      systemd-udev-settle.enable = mkForce false;
      NetworkManager-wait-online.wantedBy = mkForce [ ];
    };
  };
}
