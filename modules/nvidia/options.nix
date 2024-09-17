{ lib, ... }:

let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) str;
in {
  options.Ark.nvidia = {
    enable = mkEnableOption "Enable Nvidia drivers";
    hybrid = {
      enable = mkEnableOption "Enable Nvidia hybrid graphics";
      id = {
        amd = mkOption {
          type = str;
          default = "PCI:6:0:0";
          description = "ID of AMD GPU";
        };

        intel = mkOption {
          type = str;
          default = "";
          description = "ID of Intel GPU";
        };

        nvidia = mkOption {
          type = str;
          default = "PCI:1:0:0";
          description = "ID of Nvidia GPU";
        };
      };
    };
  };
}
