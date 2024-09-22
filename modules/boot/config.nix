{ hostname, inputs, pkgs, ... }:

{
  imports = [ inputs.chaotic.nixosModules.default ];

  boot = {
    initrd.systemd.enable = true;
    tmp.cleanOnBoot = true;

    kernelPackages = {
      "Skadi" = pkgs.linuxPackages_cachyos-lto;
      "Specter" = pkgs.linuxPackages_6_6;
    }."${hostname}";

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "loglevel=3"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "systemd.show_status=auto"
      "rd.systemd.show_status=auto"
    ];

    plymouth.enable = true;
  };
}
