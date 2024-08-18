{ lib, ... }:
let
  inherit (lib) concatLists mkOption;
  inherit (lib.types) enum;

  roles = [ "iso" "laptop" "workstation" "server" ];

  importModule = x: [ ./${x}/config.nix ./${x}/options.nix ];
in {
  imports = concatLists [
    (importModule "asus")
    (importModule "gaming")
    (importModule "nix")
    (importModule "nvidia")
    (importModule "secureboot")
    (importModule "vms")

    [ # Extras
      ./nix/assertions.nix
    ]
  ];

  options.Ark.role = mkOption {
    type = enum roles;
    default = "workstation";
    description = ''
      This enables/disables various modules
      example: ISOs don't get 'nh'
    '';
  };
}
