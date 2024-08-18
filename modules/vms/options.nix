{ lib, ... }:

let inherit (lib) mkEnableOption;
in {
  options.Ark.vms = {
    enable = mkEnableOption "Enable support for VMs";
    virtManager.enable = mkEnableOption "Enable virt-manager";
    waydroid.enable = mkEnableOption "Enable waydroid & waydroid-scripts";
  };
}
