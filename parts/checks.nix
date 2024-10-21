{ inputs, ... }:

{
  imports = [ inputs.pre-commit-hooks.flakeModule ];

  perSystem.pre-commit = let
    excludes = [
      ".envrc"
      ".gitignore"
      "LICENSE"
      "README.md"
      "flake.lock"
      "modules/system/nix/module.nix"
    ];
  in {
    settings = {
      excludes = [ "flake.lock" ];
      hooks = {
        deadnix = {
          enable = true;
          verbose = true;
          fail_fast = true;
          inherit excludes;
        };

        nixfmt-classic = {
          enable = true;
          verbose = true;
          fail_fast = true;
          inherit excludes;
        };

        statix = {
          enable = true;
          verbose = true;
          fail_fast = true;
          settings.ignore = [ "modules/system/nix/module.nix" ];
        };
      };
    };
  };
}
