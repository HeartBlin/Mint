_: {
  Ark = {
    flakeDir = "/home/heartblin/Ark";
    gdm.enable = true;
    nvidia = {
      enable = true;
      hybrid.enable = true;
    };

    role = "laptop";
    secureboot.enable = true;
    steam.enable = true;
    tpm.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
}
