{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  cfg = config.Mint.underclock;
in {
  config = mkIf cfg.enable {
    hardware.cpu.x86.msr.enable = true;
    environment.systemPackages = with pkgs; [
      linuxKernel.packages.linux_6_6.cpupower
      amdctl
    ];

    systemd.services.underclockAndUndervolt = let
      cpupower = "${pkgs.linuxKernel.packages.linux_6_6.cpupower}/bin/cpupower";
      amdctl = "${pkgs.amdctl}/bin/amdctl";
      bash = "${pkgs.bash}/bin/bash -c";
    in {
      description = "Underclocks & Undervolts CPU";

      wantedBy = [ "multi-user.target" "post-resume.target" ];
      after = [ "post-resume.target" ];

      serviceConfig = {
        Type = "oneshot";
        Restart = "no";
        ExecStart =
          "${bash} '${cpupower} frequency-set -u ${cfg.clock} && ${amdctl} -m -p0 -v ${cfg.voltage}"; # 1175 mV
      };
    };
  };
}
