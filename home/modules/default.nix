{ lib, lib', ... }:

let
  inherit (lib) flatten;
  inherit (lib') importModule;
  path = "home/modules";
in {
  imports = flatten [
    (importModule path "browsers/chromium")
    (importModule path "browsers/zen")
    (importModule path "discord")
    (importModule path "hyprland")
    (importModule path "obsidian")
    (importModule path "terminal")
    (importModule path "vscode")

    # Extra
    [ ./git/config.nix ]
  ];
}
