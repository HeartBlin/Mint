{
  perSystem = {pkgs, ...}: {
    checks.linterChecks = pkgs.stdenvNoCC.mkDerivation {
      name = "Linter Checks";
      src = ./.;
      doCheck = true;
      nativeBuildInputs = with pkgs; [statix alejandra];

      checkPhase = ''
        statix check
        alejandra -c *
      '';

      # Shitty workaround
      installPhase = "mkdir $out";
    };
  };
}
