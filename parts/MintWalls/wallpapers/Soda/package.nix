{ stdenvNoCC, fetchurl }:

let hash = "sha256-bUM5LXOI9nAFUJ0z/MfUj+iqJ6llCtSVLuBZwYSlqnM=";

in stdenvNoCC.mkDerivation {
  name = "Soda";
  src = fetchurl {
    inherit hash;
    url = ''
      https://drive.usercontent.google.com/download?id=1_Dear0Rq5fmbHMGOZkBbV4XwJyhhkwhF&export=download&authuser=0&confirm=t&uuid=6880ad07-ef4e-4f5e-a58c-6c0c65ae9183&at=AN_67v2qZO3zBqLTB__1MV7GW59S:1728907723087
    '';
  };

  phases = [ "installPhase" ];

  outputHashMode = "flat";
  outputHash = hash;

  installPhase = "cp $src $out";
}
