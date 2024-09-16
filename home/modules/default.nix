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
    (importModule path "browsers/chromium")
    (importModule path "browsers/zen")
    (importModule path "discord")
    (importModule path "hyprland")
    (importModule path "terminal")
    (importModule path "vscode")

    # Extra
    [./git/config.nix]
  ];
}
