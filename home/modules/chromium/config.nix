{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.Ark.chromium;
  hyprlandOnNvidia = osConfig.Ark.nvidia.enable && config.Ark.hyprland.enable;
in {
  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;

      package = pkgs.ungoogled-chromium.override {
        commandLineArgs = [
          (
            if hyprlandOnNvidia
            then "--disable-gpu-compositing"
            else " "
          )
          "--force-punycode-hostnames"
          "--hide-crashed-bubble"
          "--popups-to-tabs"
          "--hide-fullscreen-exit-ui"
          "--hide-sidepanel-button"
          "--remove-tabsearch-button"
          "--show-avatar-button=never"
          "--force-dark-mode"
          "--no-default-browser-check"
          "--enable-features=VaapiVideoDecoder"
          "--password-store=gnome"
        ];
      };
    };
  };
}
