{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.gaming;
in {
  config = mkIf cfg.enable {
    programs = {
      steam.enable = true;
      gamemode.enable = true;
    };
  };
}
