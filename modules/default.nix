{ lib, lib', ... }:

let
  inherit (lib) flatten mkOption;
  inherit (lib.types) enum;
  inherit (lib') importModule;

  path = "modules";
  roles = [ "iso" "laptop" "workstation" "server" ];
in {
  # This is dumb but ehh...
  imports = flatten [
    (importModule path "asus")
    (importModule path "audio")
    (importModule path "bluetooth")
    (importModule path "nvidia")
    (importModule path "greeter")
    (importModule path "nix")
    (importModule path "secureboot")
    (importModule path "steam")
    (importModule path "tpm")

    # Extras
    [ ./agenix/config.nix ]
    [ ./boot/config.nix ]
    [ ./hyprland/config.nix ]
    [ ./networking/config.nix ]
    [ ./nix/assertions.nix ]
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
