{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkForce mkIf;
  cfg = config.Mint.gui.vmware;
in {
  options.Mint.gui.vmware.enable = mkEnableOption "Enable VMware";

  config = mkIf cfg.enable {
    virtualisation.vmware.host.enable = true;
    boot.kernelPackages = mkForce pkgs.linuxKernel.packages.linux_xanmod;
  };
}
