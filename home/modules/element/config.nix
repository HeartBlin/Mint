{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.element;
in { config = mkIf cfg.enable { home.packages = [ pkgs.element-desktop ]; }; }
