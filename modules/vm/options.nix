{ lib, ... }:

let inherit (lib) mkEnableOption;
in {
  options.Ark.vm.enable = mkEnableOption ''
    Enable support for VMs (virt-manager)
  '';
}
