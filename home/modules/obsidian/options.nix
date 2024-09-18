{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Ark.obsidian.enable = mkEnableOption "Enable Obsidian"; }
