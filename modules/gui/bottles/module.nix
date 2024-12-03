{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.Mint.gui.bottles;
in {
  options.Mint.gui.bottles.enable = mkEnableOption "Enable Bottles";
  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ bottles ]; };
}
