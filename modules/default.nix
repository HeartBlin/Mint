{ lib, ... }:

let
  inherit (lib.fileset) fileFilter toList;
  importModules = y: (toList (fileFilter (x: x.name == "module.nix") y));
in { imports = importModules ./.; }
