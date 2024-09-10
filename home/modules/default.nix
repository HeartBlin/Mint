{
  lib,
  lib',
  ...
}: let
  inherit (lib) concatLists;
  inherit (lib') importModule;
  path = "home/modules";
in {
  imports = concatLists [
    (importModule path "chromium")
    (importModule path "hyprland")
    (importModule path "vscode")
  ];
}
