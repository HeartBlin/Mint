{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Ark.hyprland.enable = mkEnableOption "Enable Hyprland"; }
