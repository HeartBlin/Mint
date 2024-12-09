{ modulesPath, pkgs, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ./disko.nix ];

  boot = {
    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
  };

  hardware.cpu.amd.updateMicrocode = true;
}
