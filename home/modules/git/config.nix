{ username, ... }:

{
  programs.git = {
    enable = true;
    userName = "HeartBlin";
    userEmail = "heartblin@gmail.com";

    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "/home/${username}/.ssh/GitHubSign.pub";
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        HostName github.com
        PreferredAuthentications publickey
        IdentityFile /home/${username}/.ssh/GitHubAuth
    '';
  };
}
