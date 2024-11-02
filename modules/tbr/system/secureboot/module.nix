{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkForce mkIf mkMerge;
  cfg = config.Mint.system.secureboot;
in {
  options.Mint.system.secureboot.enable = mkEnableOption "Enable SecureBoot";

  config = mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ sbctl ];

      boot = {
        loader = {
          systemd-boot.enable = mkForce false;
          timeout = mkForce 0;
          efi.canTouchEfiVariables = true;
        };

        lanzaboote = {
          enable = true;
          pkiBundle = "/etc/secureboot";
        };
      };
    })

    (mkIf (!cfg.enable) {
      boot.loader = {
        systemd-boot.enable = mkForce true;
        timeout = mkForce 0;
        efi.canTouchEfiVariables = true;
      };
    })
  ];
}
