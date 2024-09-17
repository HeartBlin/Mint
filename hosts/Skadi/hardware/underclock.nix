{ pkgs, ... }:

# Underclock & Undervolt
# Until I go get my laptop fixed I'll sacrifice performance for nice temps
# Normally pushing 98C in high loads
{
  hardware.cpu.x86.msr.enable = true;
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.cpupower # ehhh...
    amdctl
  ];

  systemd.services.underclockAndUndervolt = let
    cpupower = "${pkgs.linuxKernel.packages.linux_zen.cpupower}/bin/cpupower";
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
        "${bash} '${cpupower} frequency-set -u 4.0Ghz && ${amdctl} -m -p0 -v 60'"; # 1175 mV
    };
  };
}
