{
  perSystem = { lib, pkgs, ... }:
    let
      inherit (pkgs) stdenvNoCC;
      inherit (lib) makeBinPath;
    in {
      packages.leaf = stdenvNoCC.mkDerivation rec {
        pname = "leaf";
        version = "v0.2.3";
        src = ./leaf.sh;

        nativeBuildInputs = [ pkgs.makeWrapper ];
        buildInputs = [ pkgs.nvd ];

        unpackCmd = ''
          mkdir src
          cp $curSrc src/leaf.sh
        '';

        installPhase = ''
          install -Dm755 leaf.sh $out/bin/leaf

          wrapProgram $out/bin/leaf --prefix PATH : "${makeBinPath buildInputs}"
        '';

        meta = {
          description = "A small bash script that manages NixOS rebuilding";
          license = lib.licenses.mit;
          platforms = lib.platforms.linux;
        };
      };
    };
}
