{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.ags;
in {
  imports = [ inputs.ags.homeManagerModules.ags ];

  config = mkIf cfg.enable {
    programs.ags.enable = true;

    home.packages = [
      pkgs.bun
      pkgs.sassc
      pkgs.inotify-tools
    ];
  };
}
