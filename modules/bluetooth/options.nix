{lib, ...}: let
  inherit (lib) mkEnableOption;
in {options.Ark.bluetooth.enable = mkEnableOption "Enable BlueTooth";}
