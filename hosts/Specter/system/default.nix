_: {
  config = {
    Ark = {
      asus.enable = false;
      audio.enable = true;
      bluetooth.enable = false;
      flakeDir = "N/A"; # I clone the github repo
      gaming.enable = false;
      greeter.customGreeter.enable = false;
      hyprland.enable = false;
      role = "iso";
      nvidia.enable = false;
      refind.enable = false;
      secureboot.enable = false;
      tpm.enable = false;
      vms.enable = false;
    };

    time.timeZone = "Europe/Bucharest";

    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}

