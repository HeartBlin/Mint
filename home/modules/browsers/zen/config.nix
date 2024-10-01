{ config, inputs', lib, ... }:

let
  inherit (lib) mkIf;
  version = "1.0.1-a.7";

  cfg = config.Ark.browsers.zen;
in {
  config = mkIf cfg.enable {
    home.packages = [
      (inputs'.zen-browser.packages.specific.overrideAttrs {
        inherit version;
        src = builtins.fetchTarball {
          url =
            "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
          sha256 = "1dlb2cl86ndsl6b6jv7qr7rdg2rzqjgn3y8rlw6d8jj5r0giyinh";
        };
      })
    ];
  };
}
