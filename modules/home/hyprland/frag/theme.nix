{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  inherit (config.Mint.hyprland) theme;

  cfg = config.Mint.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.exec-once = [
      "hyprctl setcursor ${theme.cursor.name} ${toString theme.cursor.size}"
    ];

    home = {
      packages = with pkgs; [ dconf ];
      pointerCursor = {
        inherit (theme.cursor) package name size;

        gtk.enable = true;
        x11.enable = true;
      };
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
      };
    };

    gtk = {
      enable = true;
      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      iconTheme = { inherit (theme.icons) name package; };
      theme = { inherit (theme.gtk) name package; };
    };
  };
}
