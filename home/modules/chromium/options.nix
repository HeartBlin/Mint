{lib, ...}: let
  inherit (lib) mkEnableOption;
in {options.Ark.chromium.enable = mkEnableOption "Enable Chromium";}
