{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Ark.refind.enable = mkEnableOption "Enable rEFInd"; }
