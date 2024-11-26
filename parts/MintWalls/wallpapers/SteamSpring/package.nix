{ stdenvNoCC, fetchurl }:

let hash = "sha256-kcuPIhgQVB2Kp94Aek/8S2aZL1nWsyLRYJp6vJUe0w4=";

in stdenvNoCC.mkDerivation {
  name = "SteamSpring";
  src = fetchurl {
    inherit hash;
    url =
      "https://pbs.twimg.com/media/GIpg1jnbAAAbnf2?format=jpg&name=4096x4096";
  };

  phases = [ "installPhase" ];

  outputHashMode = "flat";
  outputHash = hash;

  installPhase = "cp $src $out";
  meta.description = "The Steam Spring Sale illustration, by nemupan";
}
