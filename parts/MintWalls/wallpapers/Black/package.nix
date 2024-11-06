{ stdenvNoCC, fetchurl }:

let hash = "sha256-bXr9d/2NIQL3DHLKQMmXOiaytvNKx9RpygUVYJcQEfc=";
in stdenvNoCC.mkDerivation {
  name = "Black";
  src = fetchurl {
    inherit hash;
    url = "https://jmd.im/black_wallpapers/III/desktop/BLACK_III_desktop.jpg";
  };

  phases = [ "installPhase" ];
  installPhase = "cp $src $out";
}
