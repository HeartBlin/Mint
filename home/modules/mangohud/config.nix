{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.mangohud;
in {
  config = mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
      enableSessionWide = true;

      settings = {
        # CPU
        cpu_stats = true;
        cpu_temp = true;
        cpu_load_value = [ "60" "90" ];
        cpu_load_color = [ "39F900" "FDFD09" "B22222" ];

        # GPU
        gpu_stats = true;
        gpu_temp = true;
        gpu_load_value = [ "60" "90" ];
        gpu_load_color = [ "39F900" "FDFD09" "B22222" ];
        throttling_status = true;

        # RAM
        ram = true;
        swap = true;
        vram = true;

        # FPS
        fps = true;
        frame_timing = true;

        font_size = 26;
        position = "top-center";
        background_alpha = 0.0;
        alpha = 0.5;
      };
    };
  };
}
