{ lib, ... }:

let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) str;
in {
  options.Ark = {
    asus.enable = mkEnableOption "Enables asusd & supergfxd";
    gdm.enable = mkEnableOption "Enables GDM display manager";
    nvidia = {
      enable = mkEnableOption "Enable Nvidia drivers";
      hybrid = {
        enable = mkEnableOption "Enable Nvidia hybrid graphics";
        id = {
          amd = mkOption {
            type = str;
            default = "PCI:6:0:0";
            description = "ID of AMD GPU";
          };

          nvidia = mkOption {
            type = str;
            default = "PCI:1:0:0";
            description = "ID of Nvidia GPU";
          };
        };
      };
    };

    secureboot.enable = mkEnableOption "Enable SecureBoot";
    steam.enable = mkEnableOption "Enable Steam";
    tpm.enable = mkEnableOption "Enable TPM";
    vmware.enable = mkEnableOption "Enable VMware";
  };
}
