{ modulesPath, pkgs, self, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "${self}/hosts/Skadi/hardware/disko.nix"
  ];

  boot = {
    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
  };

  hardware.cpu.amd.updateMicrocode = true;
}
