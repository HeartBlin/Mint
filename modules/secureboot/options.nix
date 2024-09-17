{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Ark.secureboot.enable = mkEnableOption "Enable SecureBoot"; }
