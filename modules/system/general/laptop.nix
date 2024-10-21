{ config, lib, pkgs, ... }:

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

    systemd.services.power-management = {
      enable = true;
      description = "Laptop role Power Management";
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = false;
      };

      unitConfig.RequiresMountsFor = "/sys";
      script = ''
        echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
        echo 0 > /proc/sys/kernel/nmi_watchdog
        echo 1 > /sys/module/snd_hda_intel/parameters/power_save

        for mod in \
          /sys/bus/i2c/devices/i2c-2/device/power/control \
          /sys/bus/i2c/devices/i2c-4/device/power/control \
          /sys/bus/i2c/devices/i2c-7/device/power/control \
          /sys/bus/i2c/devices/i2c-8/device/power/control \
          /sys/bus/pci/devices/0000:00:00.0/power/control \
          /sys/bus/pci/devices/0000:00:00.2/power/control \
          /sys/bus/pci/devices/0000:00:01.0/power/control \
          /sys/bus/pci/devices/0000:00:02.0/power/control \
          /sys/bus/pci/devices/0000:00:14.3/power/control \
          /sys/bus/pci/devices/0000:00:18.0/power/control \
          /sys/bus/pci/devices/0000:00:18.1/power/control \
          /sys/bus/pci/devices/0000:00:18.2/power/control \
          /sys/bus/pci/devices/0000:00:18.3/power/control \
          /sys/bus/pci/devices/0000:00:18.4/power/control \
          /sys/bus/pci/devices/0000:00:18.5/power/control \
          /sys/bus/pci/devices/0000:00:18.6/power/control \
          /sys/bus/pci/devices/0000:00:18.7/power/control \
          /sys/bus/pci/devices/0000:02:00.0/power/control \
          /sys/bus/pci/devices/0000:03:00.0/power/control \
          /sys/bus/pci/devices/0000:04:00.0/power/control \
          /sys/bus/pci/devices/0000:06:00.2/power/control \
          /sys/bus/pci/devices/0000:06:00.3/power/control \
          /sys/bus/pci/devices/0000:06:00.4/power/control \
          /sys/bus/pci/devices/0000:06:00.5/power/control \
          /sys/bus/pci/devices/0000:00:08.0/power/control \
          /sys/bus/usb/devices/1-3/power/control \
        ; do echo auto > $mod; done
      '';
    };

    hardware.bluetooth.powerOnBoot = mkForce false;

    environment.systemPackages = with pkgs; [ powertop ];
  };
}
