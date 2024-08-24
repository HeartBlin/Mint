{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Ark.ags.enable = mkEnableOption "Enable AGS"; }
