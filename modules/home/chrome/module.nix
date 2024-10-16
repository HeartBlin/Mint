{ config, pkgs, ... }:

let cfg = config.Mint.chrome;
in {
  programs.chromium = {
    inherit (cfg) enable;
    package = pkgs.google-chrome;
  };
}
