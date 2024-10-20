{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Mint.tpm;
in {
  config = mkIf cfg.enable {
    security.tpm2.enable = cfg.enable;
    environment.systemPackages = with pkgs;
      (if cfg.enable then [ tpm2-tss tpm2-tools ] else [ ]);
  };
}
