{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.Mint.gui.nautilus;
in {
  options.Mint.gui.nautilus.enable = mkEnableOption "Enable Nautilus";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nautilus ];
    programs.nautilus-open-any-terminal.enable = true;
    services = {
      gvfs.enable = true;
      gnome.sushi.enable = true;
    };
  };
}
