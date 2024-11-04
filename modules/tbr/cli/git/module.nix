{ pkgs, username, ... }:

let
  gitConfig = ''
    [commit]
    	gpgsign = true

    [gpg]
    	format = "ssh"

    [user]
    	email = "heartblin@gmail.com"
    	name = "HeartBlin"
    	signingkey = "/home/${username}/.ssh/id_ed25519.github_signing.pub"
  '';

  sshConfig = ''
    Host *
      ForwardAgent no
      AddKeysToAgent no
      Compression no
      ServerAliveInterval 0
      ServerAliveCountMax 3
      HashKnownHosts no
      UserKnownHostsFile ~/.ssh/known_hosts
      ControlMaster no
      ControlPath ~/.ssh/master-%r@%n:%p
      ControlPersist no

    Host github.com
      HostName github.com
      PreferredAuthentications publickey
      IdentityFile /home/${username}/.ssh/id_ed25519.github_auth
  '';
in {
  environment.systemPackages = [ pkgs.git ];
  homix = {
    ".config/git/config".text = gitConfig;
    ".ssh/config".text = sshConfig;
  };
}
