_: {
  Ark = {
    flakeDir = "/home/heartblin/Ark";
    nvidia = {
      enable = true;
      hybrid.enable = true;
    };

    role = "laptop";
    secureboot.enable = true;
    tpm.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
}
