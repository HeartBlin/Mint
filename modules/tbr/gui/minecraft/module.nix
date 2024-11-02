{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.Mint.gui.minecraft;
in {
  options.Mint.gui.minecraft.enable = mkEnableOption "Enable Prism Launcher";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.prismlauncher pkgs.openjdk ];
    networking.firewall.allowedTCPPorts = [ 25565 ];
  };
}
