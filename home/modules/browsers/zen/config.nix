{ config, inputs', lib, ... }:

let
  inherit (lib) mkIf;
  version = "1.0.1-a.5";

  cfg = config.Ark.browsers.zen;
in {
  config = mkIf cfg.enable {
    home.packages = [
      (inputs'.zen-browser.packages.specific.overrideAttrs {
        inherit version;
        src = builtins.fetchTarball {
          url =
            "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
          sha256 = "0rj8x0b7vnl6zj8mky9qip54l1cp8rpy0465gr28zsjnjhp7qyak";
        };
      })
    ];
  };
}
