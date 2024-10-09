{ lib, userName, ... }:

let
  inherit (builtins) concatLists;
  inherit (lib.fileset) fileFilter toList;

  importModules = y: (toList (fileFilter (x: x.name == "module.nix") y));
in {
  # System Modules & Options
  imports = concatLists [ (importModules ./system) [ ./system/options ] ];

  # Home Modules & Options
  home-manager.users.${userName} = {
    imports = concatLists [ (importModules ./home) [ ./home/options ] ];
  };
}
