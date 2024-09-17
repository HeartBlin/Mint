{ lib, ... }:

let
  inherit (lib) mkOption;
  inherit (lib.types) nullOr str;
in {
  options.Ark.flakeDir = mkOption {
    type = nullOr str;
    default = null;
    description = ''
      The location of the flake directory on the system.
      Used mainly for the 'nh' helper
    '';
  };
}
