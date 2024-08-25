{ config, inputs, lib, modulesPath, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.chaotic.nixosModules.default
  ];

  # Underclock & Undervolt
  # Until I go get my laptop fixed I'll sacrifice performance for nice temps
  # Normally pushing 98C in high loads
  hardware.cpu.x86.msr.enable = true;
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.cpupower # ehhh...
    amdctl
  ];

  systemd.services.underclockAndUndervolt = let
    cpupower = "${pkgs.linuxKernel.packages.linux_zen.cpupower}/bin/cpupower";
    amdctl = "${pkgs.amdctl}/bin/amdctl";
    bash = "${pkgs.bash}/bin/bash -c";
  in {
    description = "Underclocks & Undervolts CPU";

    wantedBy = [ "multi-user.target" "post-resume.target" ];
    after = [ "post-resume.target" ];

    serviceConfig = {
      Type = "oneshot";
      Restart = "no";
      ExecStart =
        "${bash} '${cpupower} frequency-set -u 4.0Ghz && ${amdctl} -m -p0 -v 60'"; # 1175 mV
    };
  };

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
