{
  perSystem = { pkgs, ... }: {
    checks.linterChecks = pkgs.stdenvNoCC.mkDerivation {
      name = "Linter Checks";
      src = ./.;
      doCheck = true;
      nativeBuildInputs = with pkgs; [ statix nixfmt-classic ];

      checkPhase = ''
        statix check
        nixfmt -c *
      '';

      # Shitty workaround
      installPhase = "mkdir $out";
    };
  };
}
