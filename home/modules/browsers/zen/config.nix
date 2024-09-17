{ config, inputs', lib, ... }:

let
  inherit (lib) mkIf;
  version = "1.0.1-a.1";

  cfg = config.Ark.browsers.zen;
in {
  config = mkIf cfg.enable {
    home.packages = [
      (inputs'.zen-browser.packages.specific.overrideAttrs {
        inherit version;
        src = builtins.fetchTarball {
          url =
            "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
          sha256 = "0ckd2ra2clhly8s0xk11ni7k1mnw0l9y061zp4h9xyxf4gkz898f";
        };
      })
    ];
  };
}
