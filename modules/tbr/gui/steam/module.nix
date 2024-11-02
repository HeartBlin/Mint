{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.Mint.gui.steam;
in {
  options.Mint.gui.steam.enable = mkEnableOption "Enable Steam";

  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };
      gamemode = { inherit (cfg) enable; };
    };
  };
}
