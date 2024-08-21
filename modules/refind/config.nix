{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.refind;
in {
  config = mkIf cfg.enable { environment.systemPackages = [ pkgs.refind ]; };
}
