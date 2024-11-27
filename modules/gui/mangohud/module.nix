{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.Mint.gui.mangohud;

  config' = ''
    battery
    cpu_power
    cpu_stats
    cpu_temp
    fps
    frame_timing=1
    frametime=0
    gpu_power
    gpu_stats
    gpu_temp
    horizontal
    hud_no_margin
    legacy_layout=0
    ram
    table_columns=14
    vram
  '';
in {
  options.Mint.gui.mangohud.enable = mkEnableOption "Enable MangoHUD";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.mangohud_git ];
    homix.".config/MangoHud/MangoHud.conf".text = config';
  };
}
