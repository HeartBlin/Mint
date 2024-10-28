{ lib, ... }:

let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) str;
in {
  options.Mint = {
    gui = { vscode.enable = mkEnableOption "Enable Visual Studio Code"; };
    asus.enable = mkEnableOption "Enables asusd & supergfxd";
    bluetooth.enable = mkEnableOption "Enable Bluetooth";
    gdm.enable = mkEnableOption "Enable GDM display manager";
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
    underclock = {
      enable = mkEnableOption "Enable Underclocking";
      clock = mkOption {
        type = str;
        default = "4.0GHz";
        description = "Clock speed to underclock to";
      };

      voltage = mkOption {
        type = str;
        default = "60";
        description =
          "Voltage to undervolt to, consult amdctl for correct values";
      };
    };

    vmware.enable = mkEnableOption "Enable VMware";
  };
}
