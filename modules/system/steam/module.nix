{ config, pkgs, ... }:

let cfg = config.Mint.steam;
in {
  programs = {
    steam = {
      inherit (cfg) enable;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
    gamemode = { inherit (cfg) enable; };
  };
}
