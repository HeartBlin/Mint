{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.Mint.system.tpm;
in {
  options.Mint.system.tpm.enable = mkEnableOption "Enable TPM";

  config = mkIf cfg.enable {
    security.tpm2.enable = cfg.enable;
    environment.systemPackages = with pkgs;
      (if cfg.enable then [ tpm2-tss tpm2-tools ] else [ ]);
  };
}
