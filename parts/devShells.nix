{ inputs, ... }:

{
  imports = [ inputs.pre-commit-hooks.flakeModule ];

  perSystem = { config, pkgs, ... }:
    let inherit (pkgs) mkShellNoCC;
    in {
      devShells = rec {
        asm = mkShellNoCC {
          name = "ASM";
          buildInputs = [ pkgs.nasm ];
        };

        bun = mkShellNoCC {
          name = "Bun";
          buildInputs = [ pkgs.bun ];
        };

        nix = default;
        default = mkShellNoCC {
          name = "Nix";
          buildInputs = config.pre-commit.settings.enabledPackages;
          shellHook = config.pre-commit.installationScript;
        };
      };
    };
}
