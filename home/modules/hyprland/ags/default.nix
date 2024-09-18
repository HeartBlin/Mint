{ config, inputs, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.hyprland;
in {
  imports = [ inputs.ags.homeManagerModules.default ];

  config = mkIf cfg.enable { programs.ags.enable = true; };
}
