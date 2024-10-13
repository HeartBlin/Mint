{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Mint.chrome;

in {
  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.google-chrome;
    };
  };
}
