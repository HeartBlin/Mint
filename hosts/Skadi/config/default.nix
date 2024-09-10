_: {
  Ark = {
    flakeDir = "/home/heartblin/Ark";
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
    role = "laptop";
  };

  boot.loader.systemd-boot.enable = true;
}
