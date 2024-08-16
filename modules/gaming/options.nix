{ lib, ... }:

let inherit (lib) mkEnableOption;
in {
  options.Ark.gaming.enable = mkEnableOption ''
    Enables steam && gamemode
  '';
}
