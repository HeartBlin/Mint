{ config, inputs, lib, modulesPath, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.chaotic.nixosModules.default

    # Files
    ./disko.nix
    ./underclock.nix
  ];

  boot = {
    initrd = {
      kernelModules = [ ];
      availableKernelModules =
        [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
    };

    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];

    # Hibernation
    resumeDevice = "/dev/disk/by-uuid/559c68ba-790c-432a-bd2d-24adcbc8c281";
    kernelParams = [ "resume_offset=533760" ];
  };

  services = {
    logind.extraConfig = "HandlePowerKey=hibernate";
    upower = {
      enable = true;
      criticalPowerAction = "Hibernate";
    };
  };

  swapDevices = [{ device = "/swap/swapfile"; }];
  zramSwap.enable = true;

  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
