{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.tpm;
in {
  config = mkIf cfg.enable {
    security.tpm2.enable = true;
    boot.initrd.systemd.enable = true;
    environment.systemPackages = with pkgs; [ tpm2-tss tpm2-tools ];
  };
}