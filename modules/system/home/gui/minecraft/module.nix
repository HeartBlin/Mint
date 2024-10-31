{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  cfg = config.Mint.gui.minecraft;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.prismlauncher pkgs.openjdk ];
    networking.firewall.allowedTCPPorts = [ 25565 ];
  };
}
