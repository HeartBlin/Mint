{ inputs, self, lib, libx, withSystem }:

let
  mkArgs = { inherit inputs libx self withSystem; };

  inherit (import "${self}/lib/colors.nix" { inherit lib; }) colors;
  inherit (import "${self}/lib/mkSystem.nix" mkArgs) mkSystem;
in { inherit colors mkSystem; }
