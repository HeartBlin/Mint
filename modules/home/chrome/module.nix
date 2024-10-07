{ config, lib, libx, osConfig, pkgs, ... }:

let
  inherit (lib) mkIf;
  inherit (libx) ifCond;

  cfg = config.Ark.chrome;
  nvidia = osConfig.Ark.nvidia.enable;
  hyprland = config.Ark.hyprland.enable;

in {
  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.google-chrome.override {
        commandLineArgs = [
          (ifCond nvidia "--disable-gpu")
          (ifCond hyprland "--enable-features=UseOzonePlatform")
          (ifCond hyprland "--ozone-platform=wayland")
        ];
      };
    };
  };
}
