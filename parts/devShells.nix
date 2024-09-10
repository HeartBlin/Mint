{
  perSystem = {pkgs, ...}: {
    devShells = {
      bun = pkgs.mkShellNoCC {
        nativeBuildInputs = with pkgs; [bun fish];
        shellHook = ''exec fish -C "echo Entered Bun dev shell."'';
      };

      nix = pkgs.mkShellNoCC {
        nativeBuildInputs = with pkgs; [statix deadnix nixfmt-classic fish];
        shellHook = ''exec fish -C "echo Entered NixOS dev shell."'';
      };
    };
  };
}
