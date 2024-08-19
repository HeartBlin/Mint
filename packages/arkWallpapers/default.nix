{ stdenvNoCC, fetchurl }:

stdenvNoCC.mkDerivation {
  name = "Ark-Wallpapers";
  version = 1.1;
  copilot = fetchurl {
    url =
      "https://www.windowslatest.com/wp-content/uploads/2024/05/Bloom-wallpaper-Dark.jpg";
    hash = "sha256-bdmI48l2DWlZrx8ZT9NQeZUcJpBrv0R7bhSZKIDVVmM=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/wallpapers
    cp $copilot $out/share/wallpapers/Bloom-Dark.jpg

    runHook postInstall
  '';
}
