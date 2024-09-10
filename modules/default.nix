{
  lib,
  lib',
  ...
}: let
  inherit (lib) concatLists mkOption;
  inherit (lib.types) enum;
  inherit (lib') importModule;

  path = "modules";
  roles = ["iso" "laptop" "workstation" "server"];
in {
  imports = concatLists [
    (importModule path "nvidia")
    (importModule path "nix")
    (importModule path "secureboot")
    (importModule path "tpm")

    # Extras
    [./nix/assertions.nix]
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
