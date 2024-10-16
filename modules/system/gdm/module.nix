{ config, ... }:

let cfg = config.Mint.gdm;
in { services.xserver.displayManager.gdm.enable = cfg.enable; }
