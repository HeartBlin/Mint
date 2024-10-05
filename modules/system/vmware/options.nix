{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Ark.vmware.enable = mkEnableOption "Enables VMWare"; }
