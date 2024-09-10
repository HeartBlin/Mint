{lib, ...}: let
  inherit (lib) mkEnableOption;
in {options.Ark.vscode.enable = mkEnableOption "Enable VSCode";}
