{
  perSystem = { pkgs, ... }: {
    checks.linterChecks = pkgs.stdenvNoCC.mkDerivation {
      name = "Linter Checks";
      src = ./.;
      doCheck = true;
      nativeBuildInputs = with pkgs; [ statix nixfmt-classic ];

      checkPhase = ''
        nixfmt -c .
        statix check
      '';

      # Shitty workaround
      installPhase = "mkdir $out";
    };
  };
}
