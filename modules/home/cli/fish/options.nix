{ lib, pkgs, ... }:

let
  inherit (lib) mkOption;
  inherit (lib.types) str;
in {
  options.Ark.cli.shell = mkOption {
    type = str;
    default = "${pkgs.bash}/bin/bash";
    description = "What shell to use";
  };
}
