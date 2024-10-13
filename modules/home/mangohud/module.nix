{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Mint.vscode;
in {
  config = mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = {
        legacy_layout = 0;
        horizontal = true;
        battery = true;
        gpu_stats = true;
        cpu_stats = true;
        cpu_power = true;
        gpu_power = true;
        cpu_temp = true;
        gpu_temp = true;
        ram = true;
        vram = true;
        fps = true;
        frametime = 0;
        hud_no_margin = true;
        table_columns = 14;
        frame_timing = 1;
      };
    };
  };
}
