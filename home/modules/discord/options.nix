{lib, ...}: let
  inherit (lib) mkEnableOption;
in {options.Ark.discord.enable = mkEnableOption "Enable Discord";}
