{ stdenvNoCC, fetchFromGitHub, }:

stdenvNoCC.mkDerivation {
  name = "Material-Discord";
  version = 1.0;

  src = fetchFromGitHub {
    owner = "CapnKitten";
    repo = "Material-Discord";
    rev = "f594f7254d127f215f7873d263abeed2eb6428f7";
    sha256 = "sha256-eepZqOlssj833VDqxzUZ4W+Xz2YZxTC2l9LKVOjBP1s=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes
    cp $src/Material-Discord.theme.css $out/share/themes/Material-Discord.theme.css

    runHook postInstall
  '';
}
