{ self, ... }:

{
  flake.templates = {
    moduleNix = {
      path = "${self}/templates/nix";
      description = "One file nix template for modules in this repo";
    };
  };
}
