{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Ark.audio.enable = mkEnableOption "Enables pipewire"; }
