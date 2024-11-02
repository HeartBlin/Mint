{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkForce mkIf;
  cfg = config.Mint.gui.chrome;
  wayland = config.programs.hyprland.enable;

  chromium' = pkgs.chromium.override {
    commandLineArgs = [
      "--enable-features=VaapiVideoDecodeLinuxGL"
      "--ignore-gpu-blocklist"
      (if wayland then "--disable-gpu" else "")
      "--enable-zero-copy"
    ];
    enableWideVine = true;
  };
in {
  options.Mint.gui.chrome.enable = mkEnableOption "Enable Google Chrome";
  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # Ublock Origin
      ];
    };

    environment = {
      systemPackages = [ chromium' ];
      sessionVariables.NIXOS_OZONE_WL = mkIf wayland (mkForce "1");
    };
  };
}
