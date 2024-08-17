{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkForce mkIf mkMerge;

  cfg = config.Ark.secureboot;
in {
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  config = mkMerge [
    # If secureboot is requested
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ sbctl ];

      boot = {
        loader = {
          systemd-boot.enable = mkForce false;
          timeout = 0;
          efi.canTouchEfiVariables = true;
        };

        lanzaboote = {
          enable = true;
          pkiBundle = "/etc/secureboot";
        };
      };
    })

    # If secureboot is disabled
    # Give the system a bootloader
    (mkIf (!cfg.enable) {
      boot.loader = {
        systemd-boot.enable = true;
        timeout = 0;
        efi.canTouchEfiVariables = true;
      };
    })
  ];
}
