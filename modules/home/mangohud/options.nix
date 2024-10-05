{ lib, ... }:

let inherit (lib) mkEnableOption;
in { options.Ark.mangohud.enable = mkEnableOption "Enable MangoHUD"; }
