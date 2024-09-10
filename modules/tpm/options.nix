{lib, ...}: let
  inherit (lib) mkEnableOption;
in {options.Ark.tpm.enable = mkEnableOption "Enable TPM LUKS unlocking";}
