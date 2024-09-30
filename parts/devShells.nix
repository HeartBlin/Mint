{ inputs, ... }:

{
  imports = [ inputs.pre-commit-hooks.flakeModule ];

  perSystem = { config, pkgs, ... }: {
    devShells = {
      bun = pkgs.mkShellNoCC {
        nativeBuildInputs = with pkgs; [ bun fish ];
        shellHook = ''exec fish -C "echo Entered Bun dev shell."'';
      };

      default = pkgs.mkShellNoCC {
        buildInputs = with pkgs;
          [ fish ] ++ config.pre-commit.settings.enabledPackages;
        shellHook = ''
          ${config.pre-commit.installationScript}
          exec fish -C "echo Entered Nix dev shell."
        '';
      };
    };
  };
}
