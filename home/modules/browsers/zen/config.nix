{ config, inputs', lib, ... }:

let
  inherit (lib) mkIf;
  version = "1.0.1-a.2";

  cfg = config.Ark.browsers.zen;
in {
  config = mkIf cfg.enable {
    home.packages = [
      (inputs'.zen-browser.packages.specific.overrideAttrs {
        inherit version;
        src = builtins.fetchTarball {
          url =
            "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
          sha256 = "0an4i57736scjwlmiqj9w7fh950brkrlg82iyv86m51ycxsi58sk";
        };
      })
    ];
  };
}
