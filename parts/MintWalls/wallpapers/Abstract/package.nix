{ stdenvNoCC, fetchurl }:

let hash = "sha256-HL3mJOeF6UKXL3ymj9ZynzgZTUJgw/lsxq9Xhpe3A8A=";
in stdenvNoCC.mkDerivation {
  name = "Abstract";
  src = fetchurl {
    inherit hash;
    url = "https://i.imgur.com/Q8ZTZCH.png";
  };

  phases = [ "installPhase" ];
  installPhase = "cp $src $out";
}
