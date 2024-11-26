{ stdenvNoCC, fetchurl }:

let hash = "sha256-nYTY8UBD2vm5JQwP0ThUWIYzdTpWqB+vHvuefW+yghg=";

in stdenvNoCC.mkDerivation {
  name = "SteamSummer";
  src = fetchurl {
    inherit hash;
    url =
      "https://pbs.twimg.com/media/GRHBfvxXUAAa3xy?format=jpg&name=4096x4096";
  };

  phases = [ "installPhase" ];

  outputHashMode = "flat";
  outputHash = hash;

  installPhase = "cp $src $out";
  meta.description = "The Steam Summer Sale illustration, by nemupan";
}
