{ inputs, ... }:

{
  imports = [ inputs.pre-commit-hooks.flakeModule ];

  perSystem.pre-commit = {
    settings = {
      excludes = [ "flake.lock" ];
      hooks = {
        deadnix = {
          enable = true;
          verbose = true;
          fail_fast = true;
        };

        nixfmt-classic = {
          enable = true;
          verbose = true;
          fail_fast = true;
          excludes = [ "flake.lock" "modules/system/nix/module.nix" ];
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
