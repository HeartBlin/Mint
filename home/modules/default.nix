{ lib, ... }:
let
  inherit (lib) concatLists;

  importModule = x: [ ./${x}/config.nix ./${x}/options.nix ];
in {
  imports = concatLists [
    (importModule "ags")
    (importModule "chromium")
    (importModule "discord")
    (importModule "element")
    (importModule "git")
    (importModule "hyprland")
    (importModule "mangohud")
    (importModule "terminal")
    (importModule "vscode")

    [ # Extras
      ./git/assertions.nix # Does not get imported by 'importModule'
    ]
  ];
}
