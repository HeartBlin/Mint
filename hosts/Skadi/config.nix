_: {
  Ark = {
    asus.enable = true;
    nvidia = {
      enable = true;
      hybrid.enable = true;
    };

    secureboot.enable = true;
    steam.enable = true;
    vmware.enable = true;
  };

  networking.networkmanager.enable = true;
  services.xserver.displayManager.gdm.enable = true;
}

