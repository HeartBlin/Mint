{ inputs, self, lib, lib', withSystem }:

let
  inherit (import ./colors.nix { inherit lib; }) colors;
  inherit (import ./importModule.nix { inherit self; }) importModule;
  inherit (import ./mkIfElse.nix { inherit inputs; }) mkIfElse;
  inherit (import ./mkSystem.nix { inherit inputs lib' self withSystem; })
    mkSystem;
in { inherit colors importModule mkIfElse mkSystem; }
