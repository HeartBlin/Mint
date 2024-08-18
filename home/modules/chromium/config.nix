{ config, lib, osConfig, pkgs, ... }:

let
  inherit (lib) mkIf;

  createChromiumExtensionFor = x:
    { id, sha256, version, }: {
      inherit id;
      crxPath = builtins.fetchurl {
        url =
          "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${x}&x=id%3D${id}%26installsource%3Dondemand%26uc";
        name = "${id}.crx";
        inherit sha256;
      };
      inherit version;
    };

  createChromiumExtension = createChromiumExtensionFor
    (lib.versions.major pkgs.ungoogled-chromium.version);

  cfg = config.Ark.chromium;
  hyprlandOnNvidia = osConfig.Ark.nvidia.enable && config.Ark.hyprland.enable;
in {
  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;

      extensions = [
        # BitWarden
        (createChromiumExtension {
          id = "nngceckbapebfimnlniiiahkandclblb";
          sha256 = "1s9h1zipfz2yrv90hjsnnxcrrv08vm20nhs1bpg9ninpgi5vmvw0";
          version = "2024.7.1";
        })

        # uBlock Origin Lite
        (createChromiumExtension {
          id = "ddkjiahejlhfcafbddmgiahcphecmpfh";
          sha256 = "14krvrwfjy168m9g8arisnx3fcjg7ih7zk178vymk12461ap0dyn";
          version = "2024.8.12.902";
        })
      ];

      package = pkgs.ungoogled-chromium.override {
        commandLineArgs = [
          (if hyprlandOnNvidia then "--disable-gpu-compositing" else " ")
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
