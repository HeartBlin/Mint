{ stdenvNoCC, fetchurl, imagemagick, }:

stdenvNoCC.mkDerivation {
  name = "arkWalls";
  version = 1.1;
  m3 = fetchurl {
    url =
      "https://drive.usercontent.google.com/download?id=1FF6Hx_GvBJmIuSVp43PgEX8DzqoxwvKd&export=download&authuser=0&confirm=t&uuid=d91ed180-45e6-47de-ac41-d8873f09788f&at=AO7h07eXCtf4W0n0xPJvycn4L6q6:1725998540388";
    hash = "sha256-/2HeSjIQiJl/ttl4o94lFNRsYaMXIEEqGsqFezLWO24=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/wallpapers
    cp $m3 $out/share/wallpapers/Pro\ Black.heic
    ${imagemagick}/bin/magick $out/share/wallpapers/Pro\ Black.heic $out/share/wallpapers/ProBlack.png

    runHook postInstall
  '';
}
