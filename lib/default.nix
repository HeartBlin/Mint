{ inputs, self, lib', withSystem }:

let
  importModule = (import ./importModule.nix { inherit self; }).importModule;
  mkIfElse = (import ./mkIfElse.nix { inherit inputs; }).mkIfElse;
  mkSystem =
    (import ./mkSystem.nix { inherit inputs lib' self withSystem; }).mkSystem;
in { inherit importModule mkIfElse mkSystem; }
