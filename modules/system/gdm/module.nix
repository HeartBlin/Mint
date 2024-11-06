{ config, lib, ... }:

let
  inherit (lib) mkEnableOption;
  cfg = config.Mint.system.gdm;
in {
  options.Mint.system.gdm.enable = mkEnableOption "Enable GDM display manager";
  config.services.xserver.displayManager.gdm.enable = cfg.enable;
}
