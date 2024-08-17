{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.vm;
in {
  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
