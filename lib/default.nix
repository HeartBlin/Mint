{ inputs, self, lib, lib', withSystem }:

let
  colors = (import ./colors.nix { inherit lib; }).colors;
  importModule = (import ./importModule.nix { inherit self; }).importModule;
  mkIfElse = (import ./mkIfElse.nix { inherit inputs; }).mkIfElse;
  mkSystem =
    (import ./mkSystem.nix { inherit inputs lib' self withSystem; }).mkSystem;
in { inherit colors importModule mkIfElse mkSystem; }
