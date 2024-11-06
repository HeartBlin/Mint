{ lib, pkgs, ... }:

let
  inherit (builtins) toString isBool;
  inherit (lib) boolToString escape;
  inherit (lib.generators) toINI;

  toGtkINI = toINI {
    mkKeyValue = key: value:
      let value' = if isBool value then boolToString value else toString value;
      in "${escape [ "=" ] key}=${value'}";
  };

  main = toGtkINI {
    Settings = {
      gtk-application-prefer-dark-theme = 1;
      gtk-icon-theme-name = "Adwaita";
      gtk-theme-name = "adw-gtk3-dark";
    };
  };
in {
  environment = {
    systemPackages =
      [ pkgs.bibata-cursors pkgs.adwaita-icon-theme pkgs.adw-gtk3 ];

    sessionVariables = {
      GTK_THEME = "adw-gtk3-dark";
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "24";
    };
  };

  homix = {
    ".config/gtk-3.0/settings.ini".text = main;
    ".config/gtk-4.0/settings.ini".text = main;
  };
}
