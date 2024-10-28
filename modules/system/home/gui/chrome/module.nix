{ config, lib, pkgs, ... }:

let
  inherit (lib) mkForce mkIf;
  cfg = config.Mint.gui.chrome;
  wayland = config.programs.hyprland.enable;

  chromium' = pkgs.chromium.override {
    commandLineArgs = [
      "--enable-features=VaapiVideoDecodeLinuxGL"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
    ];
    enableWideVine = true;
  };
in {
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
