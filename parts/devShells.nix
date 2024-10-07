{ inputs, ... }:

{
  imports = [ inputs.pre-commit-hooks.flakeModule ];

  perSystem = { config, pkgs, ... }:
    let inherit (pkgs) mkShellNoCC;
    in {
      devShells.default = mkShellNoCC {
        name = "Nix";
        buildInputs = config.pre-commit.settings.enabledPackages;
        shellHook = config.pre-commit.installationScript;
      };
    };
}
