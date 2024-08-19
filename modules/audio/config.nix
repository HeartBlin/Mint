{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.audio;
in {
  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}
