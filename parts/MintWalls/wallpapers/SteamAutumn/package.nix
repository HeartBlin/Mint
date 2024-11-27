{ stdenvNoCC, fetchurl }:

let hash = "sha256-pscyAYPM5hQZOIlklkfGfqCGOtZyqkzdAnhgtGkqN30=";

in stdenvNoCC.mkDerivation {
  name = "SteamAutumn";
  src = fetchurl {
    inherit hash;
    url = "https://pbs.twimg.com/media/GdajCrIWMAAvmlM?format=jpg&name=large";
  };

  phases = [ "installPhase" ];

  outputHashMode = "flat";
  outputHash = hash;

  installPhase = "cp $src $out";
  meta.description = "The Steam Autumn Sale illustration, by nemupan";
}
