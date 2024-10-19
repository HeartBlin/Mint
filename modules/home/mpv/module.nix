{ config, ... }:

let cfg = config.Mint.mpv;
in { programs.mpv = { inherit (cfg) enable; }; }
