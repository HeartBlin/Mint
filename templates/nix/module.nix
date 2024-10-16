{ config, ... }:

let cfg = config.Mint."";
in { programs."" = { inherit (cfg) enable; }; }
