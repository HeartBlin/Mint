{ lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) str;
in {
  options.Ark.terminal = {
    foot.enable = mkEnableOption "Enable foot";
    shell = mkOption {
      type = str;
      default = "${pkgs.bash}/bin/bash";
      description = "What shell to use";
    };
  };
}
