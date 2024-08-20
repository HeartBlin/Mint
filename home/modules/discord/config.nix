{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.discord;
in {
  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
    ];
  };
}
