{ config, lib, ... }:

let
  inherit (config.Mint) role;
  inherit (lib) mkForce mkIf;
in {
  config = mkIf (role == "laptop") {
    services.upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 2;
      criticalPowerAction = "Hibernate";
    };

    hardware.bluetooth.powerOnBoot = mkForce false;
  };
}
