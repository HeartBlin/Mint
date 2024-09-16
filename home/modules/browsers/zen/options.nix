{lib, ...}: let
  inherit (lib) mkEnableOption;
in {options.Ark.browsers.zen.enable = mkEnableOption "Enable Chromium";}
