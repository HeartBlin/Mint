{ lib, ... }:
let
  inherit (lib) concatLists;

  importModule = x: [ ./${x}/config.nix ./${x}/options.nix ];
in {
  imports = concatLists [
    (importModule "chromium")
    (importModule "element")
    (importModule "git")
    (importModule "vscode")

    [ # Extras
      ./git/assertions.nix # Does not get imported by 'importModule'
    ]
  ];
}
