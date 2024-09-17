{
  perSystem = { pkgs, ... }: {
    checks.linterChecks = pkgs.stdenvNoCC.mkDerivation {
      name = "Linter Checks";
      src = ./.;
      doCheck = true;
      nativeBuildInputs = with pkgs; [ deadnix statix nixfmt-classic ];

      checkPhase = ''
        statix check
        deadnix -f
        nixfmt -c *
      '';

      # Shitty workaround
      installPhase = "mkdir $out";
    };
  };
}
