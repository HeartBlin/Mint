{ config, lib, osConfig, pkgs, ... }:

let
  inherit (lib) mkIf;
  inherit (osConfig.programs.hyprland) package;

  ## TODO: Hyprland should read a lot of options from
  ## config or osConfig, to adjust various parameters
  ## ex: if NixOS is set to Romanian, input.kb_layout should be 'ro'
  nvidia = osConfig.Ark.nvidia.enable;
  foot = config.Ark.terminal.foot.enable;
  vscode = config.Ark.vscode.enable;
  chromium = config.Ark.chromium.enable;
  cfg = config.Ark.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      inherit package;
      enable = true;

      settings = {
        monitor = [
          "eDP-1, 1920x1080@144, 0x0, 1"
          "HDMI-A-1, 1920x1080@60, 1920x0, 1"
        ];

        env = [
          (mkIf nvidia "LIVBA_DRIVER_NAME,nvidia")
          (mkIf nvidia "XDG_SESSION_TYPE,wayland")
          (mkIf nvidia "__GLX_VENDOR_LIBRARY_NAME,nvidia")
          (mkIf nvidia "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0")
        ];

        exec-once = [
          # Polkit
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        ];

        cursor = mkIf nvidia {
          # no_hardware_cursors = true;
          allow_dumb_copy = true;
        };

        render = {
          explicit_sync = 1;
          explicit_sync_kms = 1;
          direct_scanout = true; # TODO: test this more
        };

        general = {
          gaps_in = 10;
          gaps_out = 10;
          border_size = 3;

          "col.active_border" = "rgba(ff5e81ac)";
          "col.inactive_border" = "rgba(595959aa)";

          layout = "dwindle";
        };

        decoration = { rounding = 5; };

        workspace = [
          "1, monitor:eDP-1, default:true"
          "2, monitor:eDP-1"
          "3, monitor:eDP-1"
          "4, monitor:eDP-1"
          "5, monitor:eDP-1"
          "6, monitor:HDMI-A-1, default:true"
          "7, monitor:HDMI-A-1"
          "8, monitor:HDMI-A-1"
          "9, monitor:HDMI-A-1"
          "10, monitor:HDMI-A-1"
        ];

        input = {
          kb_layout = "ro";
          touchpad.clickfinger_behavior = true;
        };

        dwindle = {
          no_gaps_when_only = 0;
          force_split = 0;
          preserve_split = true;
        };

        misc = {
          always_follow_on_dnd = true;
          animate_manual_resizes = false;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
          force_default_wallpaper = 2;
        };

        bind = [
          # Programs
          (mkIf foot "Super, Return, exec, footclient")
          (mkIf vscode "Super, C, exec, code")
          (mkIf chromium "Super, W, exec, chromium")
          "Super, Space, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"

          # Actions
          "Super, Q, killactive"
          "Super Shift, Q, exec, pkill Hyprland"
          "Super, F, fullscreen"
          "Super, T, togglefloating"

          # Workspaces
          "Super, 1, workspace, 1"
          "Super, 2, workspace, 2"
          "Super, 3, workspace, 3"
          "Super, 4, workspace, 4"
          "Super, 5, workspace, 5"
          "Super, F1, workspace, 6"
          "Super, F2, workspace, 7"
          "Super, F3, workspace, 8"
          "Super, F4, workspace, 9"
          "Super, F5, workspace, 10"

          "Super Shift, 1, movetoworkspace, 1"
          "Super Shift, 2, movetoworkspace, 2"
          "Super Shift, 3, movetoworkspace, 3"
          "Super Shift, 4, movetoworkspace, 4"
          "Super Shift, 5, movetoworkspace, 5"
          "Super Shift, F1, movetoworkspace, 6"
          "Super Shift, F2, movetoworkspace, 7"
          "Super Shift, F3, movetoworkspace, 8"
          "Super Shift, F4, movetoworkspace, 9"
          "Super Shift, F5, movetoworkspace, 10"
        ];

        bindm =
          [ "Super, mouse:272, movewindow" "Super, mouse:273, resizewindow" ];
      };
    };
  };
}
