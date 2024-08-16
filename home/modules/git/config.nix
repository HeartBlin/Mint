{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.git;
in {
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.username;
      userEmail = cfg.email;

      extraConfig = mkIf cfg.signing.enable {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "${cfg.signing.signKey}";
      };
    };

    programs.ssh = mkIf (cfg.authKey != null) {
      enable = true;
      extraConfig = ''
        Host github.com
          HostName github.com
          PreferredAuthentications publickey
          IdentityFile ${cfg.authKey}
      '';
    };
  };
}
