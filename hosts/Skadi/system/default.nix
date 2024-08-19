_: {
  config = {
    Ark = {
      asus.enable = true;
      audio.enable = true;
      bluetooth.enable = true;
      flakeDir = "/home/heartblin/Ark";
      gaming.enable = true;
      hyprland.enable = true;
      role = "laptop";
      nvidia = {
        enable = true;
        hybrid = {
          enable = true;
          id = {
            amd = "PCI:6:0:0";
            nvidia = "PCI:1:0:0";
          };
        };
      };

      secureboot.enable = true;
      vms = {
        enable = true;
        virtManager.enable = true;
        waydroid.enable = true;
      };
    };

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Bucharest";

    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}

