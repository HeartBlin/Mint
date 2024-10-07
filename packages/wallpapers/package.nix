{ stdenvNoCC, fetchurl, imagemagick, }:

stdenvNoCC.mkDerivation {
  name = "wallpapers";
  version = 1.0;
  m3 = fetchurl {
    url =
      "https://drive.usercontent.google.com/download?id=1FF6Hx_GvBJmIuSVp43PgEX8DzqoxwvKd&export=download&authuser=0&confirm=t&uuid=d91ed180-45e6-47de-ac41-d8873f09788f&at=AO7h07eXCtf4W0n0xPJvycn4L6q6:1725998540388";
    hash = "sha256-/2HeSjIQiJl/ttl4o94lFNRsYaMXIEEqGsqFezLWO24=";
  };

  theTower = fetchurl {
    url =
      "https://static.wikia.nocookie.net/nier/images/0/0f/WorldofNier_7.jpg/revision/latest?cb=20240204093404";
    hash = "sha256-ncdgGvLljI+2zQN68ahrhNzOCT68AWRbHL/AEdCRfJ0=";
  };

  phases = [ "installPhase" ];

  installPhase = let
    magick = "${imagemagick}/bin/magick";
    convert = x: y:
      "${magick} $out/share/wallpapers/${x} $out/share/wallpapers/${y}";
    crop = x: y: z:
      "${magick} $out/share/wallpapers/${x} -crop ${y} $out/share/wallpapers/${z}";
  in ''
    runHook preInstall
    mkdir -p $out/share/wallpapers

    cp $m3 $out/share/wallpapers/ProBlack.heic
    ${convert "ProBlack.heic" "ProBlack.png"}

    cp $theTower $out/share/wallpapers/TheTower.webp
    ${convert "TheTower.webp" "TheTower.png"}
    ${crop "TheTower.png" "4000x1950+0+0" "TheTowerCropped.png"}

    runHook postInstall
  '';
}
