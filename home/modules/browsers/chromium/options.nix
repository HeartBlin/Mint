{lib, ...}: let
  inherit (lib) mkEnableOption;
in {options.Ark.browsers.chromium.enable = mkEnableOption "Enable Chromium";}
