{ config, lib, osConfig, pkgs, ... }:

let
  inherit (lib) mkIf;

  package = if nvidia then
    pkgs.obsidian.overrideAttrs (x: rec {
      desktopItem =
        x.desktopItem.override (y: { exec = "${y.exec} --disable-gpu"; });

      installPhase =
        builtins.replaceStrings [ "${x.desktopItem}" ] [ "${desktopItem}" ]
        x.installPhase;
    })
  else
    pkgs.obsidian;

  nvidia = osConfig.Ark.nvidia.enable;
  cfg = config.Ark.obsidian;
in { config.home.packages = mkIf cfg.enable [ package ]; }
