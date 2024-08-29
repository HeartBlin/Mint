{ lib, ... }:
let
  inherit (lib) concatLists mkOption;
  inherit (lib.types) enum;

  roles = [ "iso" "laptop" "workstation" "server" ];

  importModule = x: [ ./${x}/config.nix ./${x}/options.nix ];
in {
  imports = concatLists [
    (importModule "asus")
    (importModule "audio")
    (importModule "bluetooth")
    (importModule "gaming")
    (importModule "greeter")
    (importModule "hyprland")
    (importModule "nix")
    (importModule "nvidia")
    (importModule "refind")
    (importModule "secureboot")
    (importModule "tpm")
    (importModule "vms")

    [ # Extras
      ./boot/config.nix # No options
      ./nix/assertions.nix
      ./tpm/assertions.nix
      ./networking/config.nix # No options
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
