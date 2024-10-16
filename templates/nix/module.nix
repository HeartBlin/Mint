{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Mint."";
in {
  config = mkIf cfg.enable {

  };
}
