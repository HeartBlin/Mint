{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.Mint.gui.thunderbird;

in {
  options.Mint.gui.thunderbird.enable = mkEnableOption "Enable Thunderbird";

  config = mkIf cfg.enable { programs.thunderbird.enable = true; };
}
