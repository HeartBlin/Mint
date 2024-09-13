{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.Ark.hyprland) theme;

  cfg = config.Ark.hyprland;
in {
  config = mkIf cfg.enable {
    home.pointerCursor = {
      inherit (theme.cursor) package name size;

      gtk.enable = true;
      x11.enable = true;
    };

    gtk = {
      enable = true;

      iconTheme = {
        inherit (theme.icons) name package;
      };

      theme = {
        inherit (theme.gtk) name package;
      };
    };
  };
}
