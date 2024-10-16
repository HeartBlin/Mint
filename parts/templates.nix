{ self, ... }:

{
  flake.templates = { moduleNix = { path = "${self}/templates/nix"; }; };
}
