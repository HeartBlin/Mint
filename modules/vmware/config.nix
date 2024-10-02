{ config, hostname, lib, pkgs, ... }:

let
  inherit (lib) mkForce mkIf;

  cfg = config.Ark.vmware;
in {
  config = mkIf cfg.enable {
    specialisation.vmware.configuration = {
      system.nixos.tags = [ "vmware" ];
      boot.kernelPackages = mkForce pkgs.linuxPackages_6_6;

      # For some reason, Hyprland does not launch in this spec
      services.desktopManager.plasma6.enable = true;
      services.xserver.displayManager.gdm.banner =
        mkForce "${hostname} on NixOS-VMWare, using Ark dotfiles";

      virtualisation.vmware.host = {
        enable = true;
        package = pkgs.vmware-workstation;
      };
    };
  };
}
