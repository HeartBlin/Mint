{ lib, ... }:
let
  inherit (lib) concatLists;

  importModule = x: [ ./${x}/config.nix ./${x}/options.nix ];
in {
  imports = concatLists [
    (importModule "asus")
    (importModule "gaming")
    (importModule "nix")
    (importModule "nvidia")
    (importModule "secureboot")
    (importModule "vm")

    [ # Extras
      ./nix/assertions.nix
    ]
  ];
}
