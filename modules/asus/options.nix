{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.Ark.asus.enable = mkEnableOption ''
    Enables asusd & supergfxd
  '';
}
