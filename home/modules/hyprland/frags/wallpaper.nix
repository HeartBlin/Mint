{ config, lib, pkgs, ... }:

let
  inherit (lib) attrValues concatMap mkIf;

  cfg = config.Ark.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      exec-once = [ "swww-daemon --no-cache" ];

      exec = concatMap (wallpaper:
        [
          "swww img ${wallpaper.path} -o ${wallpaper.monitor} -t wipe --transition-angle 30 --transition-step 255 --transition-fps 144 --transition-duration 1.2"
        ]) (attrValues cfg.wallpapers);
    };

    home.packages = with pkgs; [ swww ];
  };
}
