{ lib, ... }:

let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) nullOr str;
in {
  options.Ark = {
    git = {
      enable = mkEnableOption "Enable git";
      username = mkOption {
        type = nullOr str;
        description = "The username to be used with git";
        default = null;
      };

      email = mkOption {
        type = nullOr str;
        description = "The email to be used with git";
        default = null;
      };

      signing = {
        enable = mkEnableOption "Enable ssh key signing (no GPG)";
        signKey = mkOption {
          type = nullOr str;
          description = "The public key PATH, not the actual key.";
          default = null;
        };
      };

      authKey = mkOption {
        type = nullOr str;
        description = "The private key PATH, not the actual key";
        default = null;
      };
    };
  };
}
