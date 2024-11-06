{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkForce mkIf;
  inherit (builtins) concatStringsSep;

  cfg = config.Mint.gui.chrome;
  wayland = config.programs.hyprland.enable;

  flags = concatStringsSep " " [
    "--enable-features=VaapiVideoDecodeLinuxGL"
    "--ignore-gpu-blocklist"
    (if wayland then "--disable-gpu" else "")
    "--enable-zero-copy"
  ];

  chromium' = pkgs.symlinkJoin {
    name = "chromium-wrapped";
    paths = [ pkgs.chromium ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/chromium --add-flags "${flags}"
    '';
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
