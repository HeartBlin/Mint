{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  cfg = config.Mint.gui.discord;
in {
  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ equibop ]; };
}
