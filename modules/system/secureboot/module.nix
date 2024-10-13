{ config, lib, pkgs, ... }:

let
  inherit (lib) mkForce mkIf mkMerge;

  cfg = config.Mint.secureboot;
in {
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
