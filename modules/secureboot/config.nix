{ config, inputs, lib, lib', pkgs, ... }:

let
  inherit (lib) mkForce;
  inherit (lib') mkIfElse;

  cfg = config.Ark.secureboot;
in {
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  config = mkIfElse cfg.enable
    # If secureboot is requested
    {
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
    }
    # If secureboot is disabled
    # Give the system a bootloader
    {
      boot.loader = {
        systemd-boot.enable = mkForce true;
        timeout = mkForce 0;
        efi.canTouchEfiVariables = true;
      };
    };
}
