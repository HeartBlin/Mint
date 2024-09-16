{
  config,
  inputs',
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.Ark.browsers.zen;
in {
  config = mkIf cfg.enable {
    home.packages = [inputs'.zen-browser.packages.specific];
  };
}
