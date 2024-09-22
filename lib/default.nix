{ inputs, self, lib, lib', withSystem }:

let
  mkArgs = { inherit inputs lib' self withSystem; };

  inherit (import ./colors.nix { inherit lib; }) colors;
  inherit (import ./importModule.nix { inherit self; }) importModule;
  inherit (import ./mkIfElse.nix { inherit inputs; }) mkIfElse;

  inherit (import ./mkIso.nix mkArgs) mkIso;
  inherit (import ./mkSystem.nix mkArgs) mkSystem;
in { inherit colors importModule mkIfElse mkIso mkSystem; }
