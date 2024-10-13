{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Mint.gdm;
in {
  config =
    mkIf cfg.enable { services.xserver.displayManager.gdm.enable = true; };
}
