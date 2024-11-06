{ stdenvNoCC, fetchurl }:

let hash = "sha256-46BhjyREEy/hls2waa2ZokfdO6shAoF9brGItb57p3g=";
in stdenvNoCC.mkDerivation {
  name = "BetterSonoma";
  src = fetchurl {
    inherit hash;
    url = ''
      https://static1.squarespace.com/static/5e949a92e17d55230cd1d44f/t/65ca8d7e72b2b13769ced989/1707773333181/BSonoma_Mac.png
    '';
  };

  phases = [ "installPhase" ];
  installPhase = "cp $src $out";
}
