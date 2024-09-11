{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.Ark.steam;
in {
  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [proton-ge-bin];
      };
      gamemode.enable = true;
    };
  };
}
