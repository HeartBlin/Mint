{ lib, ... }:
let
  inherit (lib) concatLists;

  importModule = x: [ ./${x}/config.nix ./${x}/options.nix ];
in {
  imports = concatLists [
    (importModule "gaming")
    (importModule "nix")
    (importModule "nvidia")

    [ # Extras
      ./nix/assertions.nix
    ]
  ];
}
