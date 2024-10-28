{ username, ... }:

{
  programs.git = {
    enable = true;
    userName = "HeartBlin";
    userEmail = "heartblin@gmail.com"; # Doxxed

    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "/home/${username}/.ssh/id_ed25519.github_signing.pub";
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        HostName github.com
        PreferredAuthentications publickey
        IdentityFile /home/${username}/.ssh/id_ed25519.github_auth
    '';
  };
}
