{
  hostname,
  lib,
  ...
}: let
  inherit (lib) mkForce mkIf;
in {
  networking = {
    wireless.enable = mkIf (hostname == "Specter") (mkForce false);
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
  };

  services.resolved = {
    enable = true;
    fallbackDns = [
      # Quad9
      "9.9.9.9"
      "2620:fe::fe"
    ];
  };

  systemd.services.systemd-udev-settle.enable = false;
}
