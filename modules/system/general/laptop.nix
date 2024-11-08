{ lib, role, ... }:

let inherit (lib) mkForce mkIf;
in {
  config = mkIf (role == "laptop") {
    services = {
      auto-cpufreq = {
        enable = true;
        settings = {
          charger.governor = "performance";
          battery = {
            governor = "powersave";
            turbo = "never";
          };
        };
      };

      upower = {
        enable = true;
        percentageLow = 15;
        percentageCritical = 5;
        percentageAction = 2;
        criticalPowerAction = "Hibernate";
      };
    };

    hardware.bluetooth.powerOnBoot = mkForce false;
  };
}
