{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.Mint.gui) hyprland;
  cfg = config.Mint.system.uwsm;
in {
  options.Mint.system.uwsm.enable =
    mkEnableOption "Enable UWSM session manager";

  config = mkIf cfg.enable {
    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = mkIf hyprland.enable {
          prettyName = "Hyprland";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };
  };
}

