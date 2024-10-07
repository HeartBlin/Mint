{ lib, modulesPath, pkgs, self, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "${self}/hosts/Skadi/hardware/disko.nix"
    "${self}/hosts/Skadi/hardware/undervolt.nix"
  ];

  boot = {
    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;
  };

  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.amd.updateMicrocode = true;
}
