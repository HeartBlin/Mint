{ ... }:

{
  config.Ark = {
    chromium.enable = true;
    git = {
      enable = true;
      username = "HeartBlin";
      email = "161874560+HeartBlin@users.noreply.github.com";
      authKey = "/home/heartblin/.ssh/GithubAuth";
      signing = {
        enable = true;
        signKey = "/home/heartblin/.ssh/GithubSign.pub";
      };
    };

    vscode.enable = true;
  };
}
