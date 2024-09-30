{ inputs, ... }:

{
  imports = [ inputs.pkgs-by-name.flakeModule ];
  perSystem = _: { pkgsDirectory = ../packages; };
}
