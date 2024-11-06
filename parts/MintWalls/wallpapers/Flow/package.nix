{ stdenvNoCC, fetchurl, imagemagick }:

stdenvNoCC.mkDerivation {
  name = "Flow";
  src = fetchurl {
    hash = "sha256-KSLWq+vJRGzjGy5/2Rjscbbo7urHYo1OMzwanzMSa/0=";
    url =
      "https://static1.squarespace.com/static/5e949a92e17d55230cd1d44f/t/64d01e7b91df60221015d1fa/1691360904587/Flow_Wallpaper_Mac.heic";
  };

  buildInputs = [ imagemagick ];
  phases = [ "installPhase" ];
  installPhase = ''
    magick $src flow.png
    cp flow.png $out
  '';
}
