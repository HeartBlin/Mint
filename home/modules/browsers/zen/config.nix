{ config, inputs', lib, ... }:

let
  inherit (lib) mkIf;
  version = "1.0.1-a.4";

  cfg = config.Ark.browsers.zen;
in {
  config = mkIf cfg.enable {
    home.packages = [
      (inputs'.zen-browser.packages.specific.overrideAttrs {
        inherit version;
        src = builtins.fetchTarball {
          url =
            "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
          sha256 = "0jjfr1201gfw0cy8q1jbr504994z33sbw8ip86c6xbww8qm60bqh";
        };
      })
    ];
  };
}
