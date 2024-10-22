{ config, inputs, ... }:

let cfg = config.Mint.ags;
in {
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = { inherit (cfg) enable; };
}
