{ lib, ... }:

let inherit (lib) mkForce;
in {
  config = {
    Ark = {
      asus.enable = false;
      flakeDir = "N/A"; # I clone the github repo
      gaming.enable = false;
      hyprland.enable = false;
      role = "iso";
      nvidia.enable = false;
      secureboot.enable = false;
      vms.enable = false;
    };

    ### TODO: Integrate them in module system
    networking = {
      wireless.enable = mkForce false;
      networkmanager.enable = true;
    };

    time.timeZone = "Europe/Bucharest";

    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}

