{
  perSystem = { pkgs, ... }: {
    checks.linterChecks = pkgs.stdenvNoCC.mkDerivation {
      name = "Linter Checks";
      src = ./.;
      doCheck = true;
      nativeBuildInputs = with pkgs; [ deadnix statix nixfmt-classic ];

      checkPhase = ''
        statix check >> $out
        deadnix -f >> $out
        nixfmt -c * >> $out
      '';
    };
  };
}
