{ inputs, self, libx, withSystem }:

let
  mkArgs = { inherit inputs libx self withSystem; };

  inherit (import "${self}/lib/mkSystem" mkArgs) mkSystem;
in { inherit mkSystem; }
