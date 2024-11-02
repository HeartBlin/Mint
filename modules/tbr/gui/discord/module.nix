{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.Mint.gui.discord;
in {
  options.Mint.gui.discord.enable = mkEnableOption "Enable Discord";
  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ equibop ]; };
}
