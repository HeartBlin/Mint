{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Ark.chrome.enable = mkEnableOption "Enable Google Chrome"; }
