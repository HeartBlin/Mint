{ config, pkgs, ... }:

let cfg = config.Mint.gui.chrome;
in {
  programs.chromium = {
    inherit (cfg) enable;
    package = pkgs.google-chrome;
  };
}
