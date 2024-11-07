{ config, inputs', lib, pkgs, self, ... }:

let
  inherit (lib)
    attrValues concatMap concatStringsSep getExe mkEnableOption mkOption mkIf
    pipe;
  inherit (lib.types) attrsOf str submodule;
  inherit (self.lib) toHyprRGB;
  inherit (config.mintWalls) defaultPalette;
  inherit (pkgs) writeShellApplication;

  cfg = config.Mint.gui.hyprland;
  colors = {
    bB = toHyprRGB defaultPalette.borderBlue;
    bV = toHyprRGB defaultPalette.borderViolet;
    bR = toHyprRGB defaultPalette.borderRed;
    bO = toHyprRGB defaultPalette.borderOrange;

    bB' = defaultPalette.borderBlue;
    bV' = defaultPalette.borderViolet;
    bR' = defaultPalette.borderRed;
    bO' = defaultPalette.borderOrange;
  };

  changeColor = pkgs.writeShellScript "changeColor" ''
    ${pkgs.asusctl}/bin/asusctl led-mode static -c ${colors.bB'} -z 1 &
    ${pkgs.asusctl}/bin/asusctl led-mode static -c ${colors.bV'} -z 2 &
    ${pkgs.asusctl}/bin/asusctl led-mode static -c ${colors.bR'} -z 3 &
    ${pkgs.asusctl}/bin/asusctl led-mode static -c ${colors.bO'} -z 4
  '';

  foot = config.Mint.cli.foot.enable;
  chrome = config.Mint.gui.chrome.enable;
  vscode = config.Mint.gui.vscode.enable;
  asus = config.Mint.system.asus.enable;
  nautilus = config.Mint.gui.nautilus.enable;
  nvidia = config.Mint.system.nvidia.enable;
  hyprshot = getExe pkgs.hyprshot;

  ledDevice = if asus then "asus::kbd_backlight" else "rgb:kbd_backlight";
  brightnessctl = getExe pkgs.brightnessctl;

  # Hyprlands main config file
  config' = ''
    # SystemD fuckery
    exec-once = ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && ${pkgs.systemd}/systemctl --user stop hyprland-session.target && ${pkgs.systemd}/bin/systemctl --user start hyprland-session.target

    # Monitors
    monitor = eDP-1, 1920x1080@144, 0x0, 1
    monitor = HDMI-A-1, 1920x1080@60, 1920x0, 1

    # Envvars
    ${if nvidia then ''
      env = LIVBA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = NVD_BACKEND,direct'' else
      ""}

    # Execs
    exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    ${if asus then "exec-once = ${changeColor}" else ""}
    exec-once = swayosd-server
    exec-once = ${pkgs.bash}/bin/bash -c ${MRoC}/bin/monitor-reload-on-connected"
    exec-once = swww-daemon --no-cache
    exec-once = systemctl start --user hypridle

    # Cursor (nvidia)
    ${if nvidia then ''
      cursor {
        allow_dumb_copy = true
      }'' else
      ""}

    # Render settings
    render {
      direct_scanout = true
      explicit_sync = 1
      explicit_sync_kms = 1
    }

    # General settings
    general {
      border_size = 2
      col.active_border = ${colors.bB} ${colors.bV} ${colors.bR} ${colors.bO} 45deg
      col.inactive_border = rgb(333333)
      gaps_in = 5
      gaps_out = 20
      layout = dwindle
      resize_on_border = true
    }

    # Eyecandy
    decoration {
      rounding = 5
      blur {
        brightness = 1.000000
        contrast = 1.000000
        enabled = true
        noise = 0.020000
        passes = 4
        size = 5
        vibrancy = 0.200000
        vibrancy_darkness = 0.500000
      }
    }

    # Get rid of that initial zoom istg
    animations {
      first_launch_animation = false
    }

    # Workspace setup
    workspace = 1, monitor:eDP-1, default:true
    workspace = 2, monitor:eDP-1
    workspace = 3, monitor:eDP-1
    workspace = 4, monitor:eDP-1
    workspace = 5, monitor:eDP-1
    workspace = 6, monitor:HDMI-A-1, default:true
    workspace = 7, monitor:HDMI-A-1
    workspace = 8, monitor:HDMI-A-1
    workspace = 9, monitor:HDMI-A-1
    workspace = 10, monitor:HDMI-A-1

    # Input control
    input {
      kb_layout = ro
      touchpad {
        clickfinger_behavior = true
      }
    }

    # dwindle layout
    dwindle {
      force_split = 0
      preserve_split = true
    }

    # Misc settings
    misc {
      always_follow_on_dnd = true
      animate_manual_resizes = false
      background_color = rgb(000000)
      disable_hyprland_logo = true
      disable_autoreload = false
      disable_splash_rendering = true
      force_default_wallpaper = 2
      key_press_enables_dpms = true
      mouse_move_enables_dpms = true
    }

    # Binds
    ## Programs
    ${if foot then "bind = Super, Return, exec, foot" else ""}
    ${if vscode then "bind = Super, C, exec, code" else ""}
    ${if chrome then "bind = Super, W, exec, chromium" else ""}
    ${if nautilus then "bind = Super, E, exec, nautilus" else ""}
    bind = Super, Space, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun
    bind = Super, L, exec, hyprlock

    ## Actions
    bind = Super, Q, killactive
    bind = Super Shift, Q, exec, pkill Hyprland
    bind = Super, F, fullscreen
    bind = Super, T, togglefloating

    ## Screenshot
    bind =, Print,  exec, ${hyprshot} -m region -o ~/Pictures/Screenshots
    bind = Shift , Print,  exec, ${hyprshot} -m output -o ~/Pictures/Screenshots

    ## Workspaces
    bind = Super, 1, workspace, 1
    bind = Super, 2, workspace, 2
    bind = Super, 3, workspace, 3
    bind = Super, 4, workspace, 4
    bind = Super, 5, workspace, 5
    bind = Super, F1, workspace, 6
    bind = Super, F2, workspace, 7
    bind = Super, F3, workspace, 8
    bind = Super, F4, workspace, 9
    bind = Super, F5, workspace, 10
    bind = Super, S, togglespecialworkspace

    bind = Super Shift, 1, movetoworkspace, 1
    bind = Super Shift, 2, movetoworkspace, 2
    bind = Super Shift, 3, movetoworkspace, 3
    bind = Super Shift, 4, movetoworkspace, 4
    bind = Super Shift, 5, movetoworkspace, 5
    bind = Super Shift, F1, movetoworkspace, 6
    bind = Super Shift, F2, movetoworkspace, 7
    bind = Super Shift, F3, movetoworkspace, 8
    bind = Super Shift, F4, movetoworkspace, 9
    bind = Super Shift, F5, movetoworkspace, 10
    bind = Super Shift, S, movetoworkspace, special

    # Mouse binds
    bindm = Super, mouse:272, movewindow
    bindm = Super, mouse:273, resizewindow

    # Locked binds
    bindl =, XF86AudioMute, exec, swayosd-client --output-volume mute-toggle
    bindl =, XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle

    # Release binds
    bindr = CAPS, Caps_Lock, exec, swayosd-client --caps-lock

    # Locked-repeating binds
    ## Brightness
    bindle =, XF86MonBrightnessUp, exec, swayosd-client --brightness raise
    bindle =, XF86MonBrightnessDown, exec, swayosd-client --brightness lower

    ## KBD Backlight
    bindle =, XF86KbdBrightnessUp, exec, ${brightnessctl} -d ${ledDevice} set +33%
    bindle =, XF86KbdBrightnessDown, exec, ${brightnessctl} -d ${ledDevice} set 33%-

    ## Audio
    bindle =, XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise
    bindle =, XF86AudioLowerVolume, exec, swayosd-client --output-volume lower
    bindle =, XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl position 10-
    bindle =, XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl position 10+

    # WindowRules
    ## Eyecandy
    windowrulev2=dimaround, class:^(polkit-gnome-authentication-agent-1)$

    # XWayland
    windowrulev2=rounding 0, xwayland:1

    # Idle Inhibit
    windowrulev2=idleinhibit always, title:^(Minecraft server)$
  '';

  # Generate commands to set wallpaper on any monitor that was declared
  monitors = concatStringsSep "\n" (concatMap (wallpaper:
    [
      "exec = swww img ${wallpaper.path} -o ${wallpaper.monitor} -t wipe --transition-angle 30 --transition-step 255 --transition-fps 144 --transition-duration 1.2"
    ]) (attrValues cfg.wallpapers));

  # Merge config' with monitors
  configFinal = concatStringsSep "\n" [ config' monitors ];

  # The socket want the monitors but without 'exec = '
  monitorsForSocket = concatMap (wallpaper:
    [
      "swww img ${wallpaper.path} -o ${wallpaper.monitor} -t wipe --transition-angle 30 --transition-step 255 --transition-fps 144 --transition-duration 1.2"
    ]) (attrValues cfg.wallpapers);

  # Generate the commands for the socket listener for every monitor declared
  socketCommands = pipe monitorsForSocket [
    (monitors: map (cmd: "${cmd} || true") monitors) # Least confusing Nix line
    (concatStringsSep "\n")
  ];

  # Auto-apply wallpapers to any plugged in monitor that is declared
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

  # Define a custom type for monitors
  wallpaperOption = attrsOf (submodule {
    options = {
      monitor = mkOption {
        type = str;
        description = "Monitor to apply the wallpaper to";
      };

      path = mkOption {
        type = str;
        description = "Path to the image";
        default = "${config.mintWalls.wallpaperPkg}";
      };
    };
  });
in {
  options.Mint.gui.hyprland = {
    enable = mkEnableOption "Enable Hyprland";
    wallpapers = mkOption {
      type = wallpaperOption;
      description = "Wallpaper config for multiple monitors";
    };
  };

  config = mkIf cfg.enable {
    programs = {
      xwayland.enable = true;
      hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs'.hyprland.packages.hyprland;
      };
    };

    environment = {
      systemPackages = with pkgs; [ swayosd swww ];
      sessionVariables.NIXOS_OZONE_WL = "1";
    };
    homix.".config/hypr/hyprland.conf".text = configFinal;
  };
}
