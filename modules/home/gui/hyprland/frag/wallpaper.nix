{ config, lib, pkgs, ... }:

let
  inherit (lib) attrValues concatMap concatStringsSep mkIf pipe;
  inherit (pkgs) writeShellApplication;

  monitors = concatMap (wallpaper:
    [
      "swww img ${wallpaper.path} -o ${wallpaper.monitor} -t wipe --transition-angle 30 --transition-step 255 --transition-fps 144 --transition-duration 1.2"
    ]) (attrValues cfg.wallpapers);

  # TODO: Switch to using |> when the operator is supported by Alejandra
  socketCommands = pipe monitors [
    (monitors: map (cmd: "${cmd} || true") monitors) # Least confusing Nix line
    (concatStringsSep "\n")
  ];

  # Monitor Reload on Connected
  # Reload Hyprland on a monitor connection
  # This executes any "exec" lines
  # In this case, the wallpapers get applied to new monitors (that are defined)
  MRoC = writeShellApplication {
    name = "monitor-reload-on-connected";
    runtimeInputs = with pkgs; [ socat ];
    text = ''
      handle() {
        case $1 in monitoradded*)
        ${socketCommands}
        esac
      }

      socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done
    '';
  };

  cfg = config.Mint.gui.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "swww-daemon --no-cache"
        "${pkgs.bash}/bin/bash -c ${MRoC}/bin/monitor-reload-on-connected"
      ];

      exec = monitors;
    };

    home.packages = with pkgs; [ swww ];
  };
}
