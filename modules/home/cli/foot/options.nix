{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Ark.cli.foot.enable = mkEnableOption "Enable foot"; }
