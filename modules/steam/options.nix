{ lib, ... }:

let inherit (lib) mkEnableOption;
in {
  options.Ark.steam.enable = mkEnableOption ''
    Enables steam && gamemode
  '';
}
