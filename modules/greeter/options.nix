{lib, ...}: let
  inherit (lib) mkEnableOption;
in {options.Ark.gdm.enable = mkEnableOption "Enable GDM greeter";}
