{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.Ark.discord;
in {
  config = mkIf cfg.enable {
    home = {
      file.".config/vesktop/themes/Material-Discord.theme.css".source = "${self.packages.${pkgs.system}.material-discord}/share/themes/Material-Discord.theme.css";
      packages = [pkgs.vesktop];
    };
  };
}
