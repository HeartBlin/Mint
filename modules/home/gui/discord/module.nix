{ config, pkgs, ... }:

let cfg = config.Mint.gui.discord;
in { home.packages = if cfg.enable then [ pkgs.equibop ] else [ ]; }
