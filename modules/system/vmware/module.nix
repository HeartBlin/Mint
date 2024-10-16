{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkForce;
  cfg = config.Mint.vmware;
in {
  config = mkIf cfg.enable {
    virtualisation.vmware.host.enable = true;
    boot.kernelPackages = mkForce pkgs.linuxKernel.packages.linux_xanmod;
  };
}
