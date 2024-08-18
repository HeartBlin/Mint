{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.vms;
in {
  config = mkIf cfg.enable {
    nixpkgs.overlays = mkIf cfg.waydroid.enable [ inputs.nur.overlay ];
    virtualisation = {
      libvirtd.enable = cfg.virtManager.enable;
      waydroid.enable = cfg.waydroid.enable;
    };

    programs.virt-manager.enable = cfg.virtManager.enable;
    environment.systemPackages =
      mkIf cfg.waydroid.enable [ pkgs.nur.repos.ataraxiasjel.waydroid-script ];
  };
}
